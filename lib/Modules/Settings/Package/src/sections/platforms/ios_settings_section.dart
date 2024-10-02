import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../Shared/Styles/app_colors.dart';
import '../../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../settings_ui.dart';

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
  Widget build(BuildContext context, WidgetRef ref) => CupertinoListSection.insetGrouped(
        header: _SectionHeader(title),
        backgroundColor: AppColors.scaffoldBackground(ref),
        children: tiles,
      );
}

class _SectionHeader extends ConsumerWidget {
  const _SectionHeader(this.title);

  final Widget? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = SettingsTheme.of(context);
    final scaleFactor = LiveData.scalePercentage(ref);
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 18,
        bottom: 5 * scaleFactor,
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: theme.themeData.titleTextColor,
          fontSize: 16,
        ),
        child: title!,
      ),
    );
  }
}
