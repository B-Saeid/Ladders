import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../settings_ui.dart';

class WebSettingsSection extends ConsumerWidget {
  const WebSettingsSection({
    required this.tiles,
    required this.margin,
    this.header,
    super.key,
  });

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: margin ?? const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (header != null) buildHeader(context, ref),
            Card(
              elevation: 4,
              color: SettingsTheme.of(context).themeData.tileColor,
              child: buildTileList(),
            ),
          ],
        ),
      );

  Container buildHeader(BuildContext context, WidgetRef ref) => Container(
        height: 65.scalable(ref),
        padding: EdgeInsetsDirectional.only(
          bottom: 5.scalable(ref),
          start: 6,
          top: 40.scalable(ref),
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: SettingsTheme.of(context).themeData.titleTextColor,
            fontSize: 15,
          ),
          child: header!,
        ),
      );

  Widget buildTileList() => ListView.separated(
        shrinkWrap: true,
        itemCount: tiles.length,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => tiles[index],
        separatorBuilder: (__, _) => const Divider(
          height: 0,
          thickness: 1,
        ),
      );
}
