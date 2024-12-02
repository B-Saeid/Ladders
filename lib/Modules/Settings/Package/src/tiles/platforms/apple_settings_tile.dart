import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../Shared/Styles/app_colors.dart';
import '../../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../../../../Shared/Widgets/cupertino_well.dart';
import '../../../../../../Shared/Widgets/fit_within.dart';
import '../../../../../../Shared/Widgets/neat_circular_indicator.dart';
import '../../../settings_ui.dart';

class AppleSettingsTile extends ConsumerWidget {
  const AppleSettingsTile({
    required this.tileType,
    required this.leading,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.onToggle,
    required this.value,
    required this.initialValue,
    required this.activeSwitchColor,
    required this.enabled,
    required this.trailing,
    required this.loading,
    super.key,
  });

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget title;
  final Widget? description;
  final VoidCallback? onPressed;
  final Function(bool value)? onToggle;
  final Widget? value;
  final bool loading;
  final bool? initialValue;
  final bool enabled;
  final Color? activeSwitchColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = SettingsTheme.of(context);

    return IgnorePointer(
      ignoring: !enabled,
      child: buildContent(
        context: context,
        theme: theme,
        ref: ref,
      ),
    );
  }

  Widget buildContent({
    required BuildContext context,
    required WidgetRef ref,
    required SettingsTheme theme,
  }) {
    final symmetricVerticalPadding =
        tileType.isSwitch ? 8.delayedScale(ref, startFrom: 1.2, beforeStart: 0) : 8.scalable(ref);
    // return ConstrainedBox(
    //   constraints: const BoxConstraints(minHeight: 44),
    //   child: CupertinoListTile(
    //     title: title,
    //     onTap: tileType != SettingsTileType.switchTile
    //         ? onPressed
    //         : /*() => onToggle!(!initialValue!)*/ null,
    //     trailing: trailing ??
    //         (tileType == SettingsTileType.switchTile
    //             ? buildSwitch(context: context, theme: theme)
    //             : tileType == SettingsTileType.navigationTile
    //                 ? const CupertinoListTileChevron()
    //                 : null),
    //     additionalInfo: tileType != SettingsTileType.switchTile ? value : null,
    //     // leading: leading,
    //     // leading: buildLeading(theme: theme, ref: ref),
    //     leading: leading,
    //     subtitle: description,
    //   ),
    // );
    return CupertinoWell(
      separated: false,
      color: AppColors.onScaffoldBackground(ref),
      // color: theme.themeData.tileColor,
      pressedColor: theme.themeData.tileHighlightColor,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: symmetricVerticalPadding,
          start: 12,
          bottom: symmetricVerticalPadding,
        ),
        child: Row(
          children: [
            if (leading != null) buildLeading(ref),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: leading != null ? 12 : 0, end: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: trailing == null && !tileType.isSimple ? 2.scalable(ref) : 0,
                        ),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 5,
                          // runSpacing: 5,
                          children: [
                            /// Title & Value
                            buildTitle(theme),
                            if (value != null && tileType != SettingsTileType.switchTile)
                              Padding(
                                padding: EdgeInsets.only(top: 5.0.scalable(ref)),
                                child: buildValue(context: context, theme: theme),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (onPressed != null && tileType == SettingsTileType.switchTile)
                      buildVerticalDivider(ref),
                    buildTrailing(context, ref),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeading(WidgetRef ref) => FitWithin(
        size: Size.square(32.scalable(ref, maxFactor: 2)),
        child: IconTheme.merge(
          data: IconThemeData(
            // color: enabled ? null : theme.themeData.inactiveTitleColor,
            color: enabled ? null : LiveData.themeData(ref).disabledColor,
          ),
          child: leading!,
        ),
      );

  Widget buildTitle(SettingsTheme theme) => DefaultTextStyle.merge(
        style: TextStyle(
          // color: enabled ? theme.themeData.settingsTileTextColor : theme.themeData.inactiveTitleColor,
          color: enabled ? null : theme.themeData.inactiveTitleColor,
          fontSize: 16,
        ),
        child: title,
      );

  Widget buildValue({
    required BuildContext context,
    required SettingsTheme theme,
  }) =>
      DefaultTextStyle.merge(
        style: TextStyle(
          color: enabled ? theme.themeData.trailingTextColor : theme.themeData.inactiveTitleColor,
          fontSize: 17,
        ),
        child: value!,
      );

  Widget buildTrailing(BuildContext context, WidgetRef ref) {
    if (trailing != null) {
      return IconTheme.merge(
        data: IconThemeData(
          size: 24.scalable(
            ref,
            maxValue: 32,
            allowBelow: false,
          ),
          color: enabled ? null : LiveData.themeData(ref).disabledColor,
        ),
        child: trailing!,
      );
    }

    final scaleFactor = LiveData.scalePercentage(ref);
    return switch (tileType) {
      _ when loading => const NeatCircularIndicator(),
      SettingsTileType.simpleTile => const SizedBox(),
      SettingsTileType.switchTile => CupertinoSwitch(
          value: initialValue!,
          onChanged: enabled ? onToggle : null,
          activeColor: enabled ? activeSwitchColor : LiveData.themeData(ref).disabledColor,
        ),
      SettingsTileType.navigationTile => Padding(
          padding: const EdgeInsetsDirectional.only(start: 6, end: 2),
          child: Icon(
            color: enabled ? null : LiveData.themeData(ref).disabledColor,
            Directionality.of(context) == TextDirection.ltr
                ? CupertinoIcons.chevron_forward
                : CupertinoIcons.chevron_left,
            size: 18 * scaleFactor,
          ),
        ),
    };
  }

  Widget buildVerticalDivider(WidgetRef ref) => Container(
        width: 2,
        height: 26,
        margin: const EdgeInsetsDirectional.only(start: 3, end: 6),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: LiveData.themeData(ref).dividerColor,
        ),
      );
}
