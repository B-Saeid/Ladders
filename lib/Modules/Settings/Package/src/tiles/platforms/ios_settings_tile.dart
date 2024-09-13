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
  final Widget? title;
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
    final additionalInfo = IOSSettingsTileAdditionalInfo.of(context);
    final theme = SettingsTheme.of(context);

    return IgnorePointer(
      ignoring: !enabled,
      child: buildTile(
        context: context,
        ref: ref,
        theme: theme,
        additionalInfo: additionalInfo,
      ),
    );
  }

  Widget buildTile({
    required BuildContext context,
    required WidgetRef ref,
    required SettingsTheme theme,
    required IOSSettingsTileAdditionalInfo additionalInfo,
  }) {
    var content = buildContent(
      context: context,
      theme: theme,
      additionalInfo: additionalInfo,
      ref: ref,
    );
    final device = StaticData.platform;
    if (kIsWeb || !device.isApple) {
      content = Material(
        color: Colors.transparent,
        child: content,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: additionalInfo.enableTopBorderRadius ? const Radius.circular(12) : Radius.zero,
        bottom: additionalInfo.enableBottomBorderRadius ? const Radius.circular(12) : Radius.zero,
      ),
      child: content,
    );
  }

  Widget buildDescription(SettingsTheme theme) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        color: theme.themeData.titleTextColor,
        fontSize: 13,
      ),
      child: description!,
    );
  }

  Widget buildTrailing({
    required BuildContext context,
    required SettingsTheme theme,
  }) {
    if (trailing != null) return trailing!;

    return switch (tileType) {
      SettingsTileType.switchTile => CupertinoSwitch(
          value: initialValue ?? true,
          onChanged: onToggle,
          activeColor: enabled ? activeSwitchColor : theme.themeData.inactiveTitleColor,
        ),
      _ => DefaultTextStyle.merge(
          style: TextStyle(
            color: enabled ? theme.themeData.trailingTextColor : theme.themeData.inactiveTitleColor,
            fontSize: 17,
          ),
          child: value ?? const SizedBox(),
        ),
    };
  }

  Widget buildContent({
    required BuildContext context,
    required WidgetRef ref,
    required SettingsTheme theme,
    required IOSSettingsTileAdditionalInfo additionalInfo,
  }) {
    final scaleFactor = LiveData.scalePercentage(ref);

    return CupertinoWell(
      color: theme.themeData.settingsSectionBackground,
      pressedColor: theme.themeData.tileHighlightColor,
      onPressed: onPressed,
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: EdgeInsetsDirectional.only(
          top: 8 * scaleFactor,
          start: 18,
          bottom: 8,
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
                        children: [
                          /// Title & Description
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTitle(theme),
                              if (description != null) buildDescription(theme),
                            ],
                          ),
                          buildTrailing(context: context, theme: theme),
                        ],
                      ),
                    ),
                    if (tileType == SettingsTileType.navigationTile)
                      buildChevron(context: context, theme: theme, ref: ref),
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
        size: 24.scalable(ref, maxPercentage: 2),
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
      child: title!,
    );
  }

  Widget buildChevron({
    required BuildContext context,
    required WidgetRef ref,
    required SettingsTheme theme,
  }) {
    final scaleFactor = LiveData.scalePercentage(ref);
    return Padding(
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
    );
  }
}

class IOSSettingsTileAdditionalInfo extends InheritedWidget {
  final bool enableTopBorderRadius;
  final bool enableBottomBorderRadius;

  const IOSSettingsTileAdditionalInfo({
    super.key,
    required this.enableTopBorderRadius,
    required this.enableBottomBorderRadius,
    required super.child,
  });

  @override
  bool updateShouldNotify(IOSSettingsTileAdditionalInfo oldWidget) => true;

  static IOSSettingsTileAdditionalInfo of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<IOSSettingsTileAdditionalInfo>();
    // assert(result != null, 'No IOSSettingsTileAdditionalInfo found in context');
    return result ??
        const IOSSettingsTileAdditionalInfo(
          enableBottomBorderRadius: true,
          enableTopBorderRadius: true,
          child: SizedBox(),
        );
  }
}
