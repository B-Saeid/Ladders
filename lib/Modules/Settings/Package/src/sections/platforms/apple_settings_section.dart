import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../Shared/Styles/app_colors.dart';
import '../../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../settings_ui.dart';

class AppleSettingsSection extends ConsumerWidget {
  const AppleSettingsSection({
    required this.tiles,
    required this.margin,
    this.header,
    super.key,
  });

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: _getTilesList(context, ref),
  );

  /// Since iOS design impose displaying the description separated under the setting tile.
  ///
  /// This logic is written to properly display ios setting tiles with
  /// descriptive ones being taken into account any where they are in the list
  ///   - alone
  ///   - first
  ///   - last
  ///   - within
  ///   YOU GET THE IDEA!
  List<Widget> _getTilesList(BuildContext context, WidgetRef ref) {
    final tilesWidgetList = <Widget>[];

    var nonDescriptiveTiles = 0;
    var lastDescriptiveIndex = -1;

    for (var i = 0; i < tiles.length; i++) {
      // print('i is $i');
      if (tiles[i].description == null) {
        // print('inside tiles[i].description == null');
        nonDescriptiveTiles++;
      } else {
        // print('inside else');

        if (nonDescriptiveTiles > 0) {
          // print('inside nonDescriptiveTiles > 0');
          nonDescriptiveTiles = 0;
          // print('lastDescriptiveIndex = $lastDescriptiveIndex');
          final start = lastDescriptiveIndex == -1 ? 0 : lastDescriptiveIndex + 1;
          // print('start = $start');
          // print('end = $i');
          lastDescriptiveIndex = i;
          tilesWidgetList.add(_lastIsDescriptive(context, start, i));
        } else {
          lastDescriptiveIndex = i;
          tilesWidgetList.add(_singleDescriptive(context, i));
        }
      }
    }

    /// Add the remaining non-descriptive tiles
    if (nonDescriptiveTiles > 0) {
      // print('inside the outside nonDescriptiveTiles > 0');
      final start = lastDescriptiveIndex == -1 ? 0 : lastDescriptiveIndex + 1;
      tilesWidgetList.add(_nonDescriptive(ref, start, tiles.length));
    }

    return tilesWidgetList;
  }

  _CustomCupertinoListSection _singleDescriptive(BuildContext context, int i) =>
      _CustomCupertinoListSection(
        header: i == 0 && header != null ? _SectionHeader(header!) : null,

        /// Since Description for iOS is not with in the tile itself it is added here
        footer: buildDescription(context, tiles[i].description!),
        tiles: [tiles[i]],
      );

  _CustomCupertinoListSection _lastIsDescriptive(BuildContext context, int start, int end) =>
      _CustomCupertinoListSection(
        header: start == 0 && header != null ? _SectionHeader(header!) : null,

        /// Since Description for iOS is not with in the tile itself it is added here
        footer: buildDescription(context, tiles[end].description!),
        tiles: tiles.getRange(start, end + 1).toList(),
      );

  Widget buildDescription(BuildContext context, Widget description) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: DefaultTextStyle.merge(
      style: TextStyle(
        color: SettingsTheme.of(context).themeData.tileDescriptionTextColor,
        fontSize: 13,
      ),
      child: description,
    ),
  );

  _CustomCupertinoListSection _nonDescriptive(WidgetRef ref, int start, int end) =>
      _CustomCupertinoListSection(
        header: start == 0 && header != null ? _SectionHeader(header!) : null,
        tiles: tiles.getRange(start, end).toList(),
      );
}

class _SectionHeader extends ConsumerWidget {
  const _SectionHeader(this.header);

  final Widget header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 18,
        bottom: 5.scalable(ref),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: SettingsTheme.of(context).themeData.titleTextColor,
          fontSize: 16,
        ),
        child: header,
      ),
    );
  }
}

class _CustomCupertinoListSection extends ConsumerWidget {
  const _CustomCupertinoListSection({
    this.header,
    this.footer,
    required this.tiles,
  });

  final Widget? header;
  final Widget? footer;
  final List<Widget> tiles;

  @override
  Widget build(BuildContext context, WidgetRef ref) => CupertinoListSection.insetGrouped(
    header: header,
    dividerMargin: 0,
    hasLeading: false,
    additionalDividerMargin: 12,
    backgroundColor: AppColors.scaffoldBackground(ref),
    footer: footer,
    children: tiles,
  );
}
