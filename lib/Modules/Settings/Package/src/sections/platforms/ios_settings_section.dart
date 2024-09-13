import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../settings_ui.dart';
import '../../tiles/platforms/ios_settings_tile.dart';

class IOSSettingsSection extends ConsumerWidget {
  const IOSSettingsSection({
    required this.tiles,
    required this.margin,
    required this.title,
    super.key,
  });

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = SettingsTheme.of(context);
    final isLastNonDescriptive =
        tiles.last is SettingsTile && (tiles.last as SettingsTile).description == null;
    final scaleFactor = LiveData.scalePercentage(ref);

    return Padding(
      padding: margin ??
          EdgeInsets.only(
            top: 14.0 * scaleFactor,
            bottom: isLastNonDescriptive ? 27 * scaleFactor : 10 * scaleFactor,
            left: 16,
            right: 16,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 18,
                bottom: 5 * scaleFactor,
              ),
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  color: theme.themeData.titleTextColor,
                  fontSize: 13,
                ),
                child: title!,
              ),
            ),
          buildTileList(theme),
        ],
      ),
    );
  }

  Widget buildTileList(SettingsTheme theme) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: tiles.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final tile = tiles[index];
        final enableTop = showTopBorderRadius(index);
        final enableBottom = showBottomBorderRadius(index, tile);

        return IOSSettingsTileAdditionalInfo(
          enableTopBorderRadius: enableTop,
          enableBottomBorderRadius: enableBottom,
          child: tile,
        );
      },
      separatorBuilder: (BuildContext context, int index) => ColoredBox(
        color: theme.themeData.settingsSectionBackground!,
        child: Divider(
          height: 0,
          color: theme.themeData.dividerColor,
        ),
      ),
    );
  }

  bool showBottomBorderRadius(int index, AbstractSettingsTile tile) {
    final isLast = index == tiles.length - 1;
    final hasDescription = index < tiles.length && tile is SettingsTile && (tile).description != null;
    return isLast || hasDescription;
  }

  bool showTopBorderRadius(int index) {
    final isFirst = index == 0;
    final previousHasDescription = index > 0 &&
        tiles[index - 1] is SettingsTile &&
        (tiles[index - 1] as SettingsTile).description != null;
    return isFirst || previousHasDescription;
  }
}
