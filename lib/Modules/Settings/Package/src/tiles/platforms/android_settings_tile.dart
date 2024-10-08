import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings_ui.dart';

class AndroidSettingsTile extends ConsumerWidget {
  const AndroidSettingsTile({
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
  final bool initialValue;
  final bool enabled;
  final Color? activeSwitchColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = SettingsTheme.of(context);
    // final scaleFactor = LiveData.scalePercentage(ref);
    //
    // final cantShowAnimation = tileType == SettingsTileType.switchTile
    //     ? onToggle == null && onPressed == null
    //     : onPressed == null;

    // final old = IgnorePointer(
    //   ignoring: !enabled,
    //   child: Material(
    //     color: Colors.transparent,
    //     child: InkWell(
    //       onTap: cantShowAnimation
    //           ? null
    //           : () {
    //               if (tileType == SettingsTileType.switchTile) {
    //                 onToggle?.call(!initialValue);
    //               } else {
    //                 onPressed?.call(context);
    //               }
    //             },
    //       highlightColor: theme.themeData.tileHighlightColor,
    //       child: Row(
    //         children: [
    //           if (leading != null)
    //             Padding(
    //               padding: const EdgeInsetsDirectional.only(start: 24),
    //               child: IconTheme(
    //                 data: IconTheme.of(context).copyWith(
    //                   color: enabled
    //                       ? theme.themeData.leadingIconsColor
    //                       : theme.themeData.inactiveTitleColor,
    //                 ),
    //                 child: leading!,
    //               ),
    //             ),
    //           Expanded(
    //             child: Padding(
    //               padding: EdgeInsetsDirectional.only(
    //                 start: 24,
    //                 end: 24,
    //                 bottom: 19 * scaleFactor,
    //                 top: 19 * scaleFactor,
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   DefaultTextStyle(
    //                     style: TextStyle(
    //                       color: enabled
    //                           ? theme.themeData.settingsTileTextColor
    //                           : theme.themeData.inactiveTitleColor,
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w400,
    //                     ),
    //                     child: title ?? Container(),
    //                   ),
    //                   if (value != null)
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 4.0),
    //                       child: DefaultTextStyle(
    //                         style: TextStyle(
    //                           color: enabled
    //                               ? theme.themeData.tileDescriptionTextColor
    //                               : theme.themeData.inactiveSubtitleColor,
    //                         ),
    //                         child: value!,
    //                       ),
    //                     )
    //                   else if (description != null)
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 4.0),
    //                       child: DefaultTextStyle(
    //                         style: TextStyle(
    //                           color: enabled
    //                               ? theme.themeData.tileDescriptionTextColor
    //                               : theme.themeData.inactiveSubtitleColor,
    //                         ),
    //                         child: description!,
    //                       ),
    //                     ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           // if (tileType == SettingsTileType.switchTile)
    //           //   SizedBox(
    //           //     height: 30,
    //           //     child: VerticalDivider(),
    //           //   ),
    //           if (trailing != null)
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16),
    //               child: trailing!,
    //             )
    //           else if (tileType == SettingsTileType.switchTile)
    //             Padding(
    //               padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
    //               child: Switch.adaptive(
    //                 value: initialValue,
    //                 onChanged: onToggle,
    //                 activeColor: enabled ? activeSwitchColor : theme.themeData.inactiveTitleColor,
    //               ),
    //             ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return switch (tileType) {
      SettingsTileType.switchTile => buildSwitchTile(),
      _ => buildListTile(),
    };
  }

  Widget buildListTile() => ListTile(
        leading: leading,
        title: title,
        subtitle: value ?? description,
        onTap: onPressed,
        enabled: enabled,
        trailing: trailing,
      );

  Widget buildSwitchTile() {
    assert(trailing == null);
    return SwitchListTile.adaptive(
      secondary: leading,
      title: title,
      value: initialValue,
      onChanged: enabled ? onToggle : null,
      subtitle: description,
    );
  }
}
