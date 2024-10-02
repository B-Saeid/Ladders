import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../../../../Shared/Widgets/cupertino_well.dart';
import '../../../settings_ui.dart';

class IOSSettingsTile extends ConsumerWidget {
  const IOSSettingsTile({
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
    super.key,
  });

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget title;
  final Widget? description;
  final VoidCallback? onPressed;
  final Function(bool value)? onToggle;
  final Widget? value;
  final bool? initialValue;
  final bool enabled;
  final Color? activeSwitchColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = SettingsTheme.of(context);

    return IgnorePointer(
      ignoring: !enabled,
      child: buildTile(
        context: context,
        ref: ref,
        theme: theme,
      ),
    );
  }

  Widget buildTile({
    required BuildContext context,
    required WidgetRef ref,
    required SettingsTheme theme,
  }) {
    var content = buildContent(
      context: context,
      theme: theme,
      ref: ref,
    );
    final device = StaticData.platform;
    if (kIsWeb || !device.isApple) {
      content = Material(
        color: Colors.transparent,
        child: content,
      );
    }

    return content;
  }

  Widget buildDescription(SettingsTheme theme) => DefaultTextStyle.merge(
        style: TextStyle(
          color: theme.themeData.titleTextColor,
          fontSize: 13,
        ),
        child: description!,
      );

  Widget buildValue({
    required BuildContext context,
    required SettingsTheme theme,
  }) =>
      switch (tileType) {
        SettingsTileType.switchTile => const SizedBox(),
        _ => DefaultTextStyle.merge(
            style: TextStyle(
              color: enabled ? theme.themeData.trailingTextColor : theme.themeData.inactiveTitleColor,
              fontSize: 17,
            ),
            child: value ?? const SizedBox(),
          ),
      };

  Widget buildContent({
    required BuildContext context,
    required WidgetRef ref,
    required SettingsTheme theme,
  }) {
    final symmetricVerticalPadding = 8.delayedScale(ref, startFrom: 1.2, beforeStart: 0);
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
      color: theme.themeData.settingsSectionBackground,
      pressedColor: theme.themeData.tileHighlightColor,
      onPressed: onPressed,
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: EdgeInsetsDirectional.only(
          top: symmetricVerticalPadding,
          start: 18,
          bottom: symmetricVerticalPadding,
        ),
        child: Row(
          children: [
            if (leading != null) buildLeading(theme: theme, ref: ref),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 18, end: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 5,
                        children: [
                          /// Title & Description
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTitle(theme),
                              if (description != null) buildDescription(theme),
                            ],
                          ),
                          buildValue(context: context, theme: theme),
                        ],
                      ),
                    ),
                    if (onPressed != null && tileType == SettingsTileType.switchTile)
                      buildDivider(context: context, theme: theme, ref: ref),
                    buildTrailing(context: context, theme: theme, ref: ref),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeading({
    required SettingsTheme theme,
    required WidgetRef ref,
  }) {
    return IconTheme.merge(
      data: IconThemeData(
        color: enabled ? theme.themeData.leadingIconsColor : theme.themeData.inactiveTitleColor,
        size: 24.scalable(ref, maxFactor: 2),
      ),
      child: leading!,
    );
  }

  Widget buildTitle(SettingsTheme theme) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        color: enabled ? theme.themeData.settingsTileTextColor : theme.themeData.inactiveTitleColor,
        fontSize: 16,
      ),
      child: title,
    );
  }

  Widget buildTrailing({
    required BuildContext context,
    required WidgetRef ref,
    required SettingsTheme theme,
  }) {
    if (trailing != null) return trailing!;

    final scaleFactor = LiveData.scalePercentage(ref);
    return switch (tileType) {
      SettingsTileType.simpleTile => const SizedBox(),
      SettingsTileType.switchTile => CupertinoSwitch(
          value: initialValue ?? true,
          onChanged: onToggle,
          activeColor: enabled ? activeSwitchColor : theme.themeData.inactiveTitleColor,
        ),
      SettingsTileType.navigationTile => Padding(
          padding: const EdgeInsetsDirectional.only(start: 6, end: 2),
          child: IconTheme.merge(
            data: IconTheme.of(context).copyWith(color: theme.themeData.leadingIconsColor),
            child: Icon(
              Directionality.of(context) == TextDirection.ltr
                  ? CupertinoIcons.chevron_forward
                  : CupertinoIcons.chevron_left,
              size: 18 * scaleFactor,
            ),
          ),
        ),
    };
  }

  Widget buildDivider({
    required BuildContext context,
    required WidgetRef ref,
    required SettingsTheme theme,
  }) =>
      Container(
        width: 2,
        height: 26,
        margin: const EdgeInsetsDirectional.only(start: 3, end: 6),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: LiveData.themeData(ref).dividerColor,
        ),
      );
}
