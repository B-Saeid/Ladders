import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../settings_ui.dart';

class AndroidSettingsSection extends ConsumerWidget {
  const AndroidSettingsSection({
    required this.tiles,
    required this.margin,
    this.header,
    super.key,
  });

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) buildHeader(context, ref),
          buildTileList(),
        ],
      );

  Padding buildHeader(BuildContext context, WidgetRef ref) => Padding(
        padding: EdgeInsetsDirectional.only(
          top: 24.scalable(ref),
          bottom: 10.scalable(ref),
          start: 24,
          end: 24,
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: SettingsTheme.of(context).themeData.titleTextColor,
          ),
          child: header!,
        ),
      );

  Widget buildTileList() => ListView.builder(
        shrinkWrap: true,
        itemCount: tiles.length,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => tiles[index],
      );
}
