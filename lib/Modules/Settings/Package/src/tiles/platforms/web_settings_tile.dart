import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../settings_ui.dart';

class WebSettingsTile extends ConsumerWidget {
  const WebSettingsTile({
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
  final Widget? trailing;
  final Color? activeSwitchColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = SettingsTheme.of(context);
    final scaleFactor = LiveData.scalePercentage(ref);

    final cantShowAnimation = tileType == SettingsTileType.switchTile
        ? onToggle == null && onPressed == null
        : onPressed == null;

    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12), // Card default border radius
          onTap: cantShowAnimation
              ? null
              : () {
                  if (tileType == SettingsTileType.switchTile) {
                    onToggle?.call(!initialValue);
                  } else {
                    onPressed?.call();
                  }
                },
          highlightColor: theme.themeData.tileHighlightColor,
          child: Row(
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 24,
                  ),
                  child: IconTheme.merge(
                    data: IconTheme.of(context).copyWith(
                      color: theme.themeData.leadingIconsColor,
                    ),
                    child: leading!,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 24,
                    end: 24,
                    bottom: 19 * scaleFactor,
                    top: 19 * scaleFactor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle.merge(
                        style: TextStyle(
                          color: theme.themeData.settingsTileTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        child: title ?? const SizedBox(),
                      ),
                      if (value != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: DefaultTextStyle.merge(
                            style: TextStyle(
                              color: theme.themeData.tileDescriptionTextColor,
                            ),
                            child: value!,
                          ),
                        )
                      else if (description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: theme.themeData.tileDescriptionTextColor,
                            ),
                            child: description!,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // if (tileType == SettingsTileType.switchTile)
              //   SizedBox(
              //     height: 30,
              //     child: VerticalDivider(),
              //   ),
              if (tileType == SettingsTileType.switchTile)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
                  child: Switch.adaptive(
                    value: initialValue,
                    onChanged: onToggle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
