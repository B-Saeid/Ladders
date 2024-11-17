import 'package:flutter/material.dart';

import '../../../../../Shared/Utilities/device_platform.dart';
import '../../settings_ui.dart';
import 'platforms/android_settings_tile.dart';
import 'platforms/apple_settings_tile.dart';
import 'platforms/web_settings_tile.dart';

enum SettingsTileType {
  simpleTile,
  switchTile,
  navigationTile;

  bool get isSimple => this == SettingsTileType.simpleTile;

  bool get isSwitch => this == SettingsTileType.switchTile;
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    this.leading,
    this.trailing,
    this.value,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    this.loading = false,
    super.key,
  })  : onToggle = null,
        on = null,
        activeSwitchColor = null,
        tileType = SettingsTileType.simpleTile;

  const SettingsTile.navigation({
    this.leading,
    this.trailing,
    this.value,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    this.loading = false,
    super.key,
  })  : onToggle = null,
        on = null,
        activeSwitchColor = null,
        tileType = SettingsTileType.navigationTile;

  const SettingsTile.switchTile({
    required this.on,
    required this.onToggle,
    this.activeSwitchColor,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    super.key,
    this.loading = false,
  })  : value = null,
        tileType = SettingsTileType.switchTile;

  final Widget? leading;
  final Widget? trailing;
  final Widget title;
  final Widget? description;
  final VoidCallback? onPressed;
  final bool loading;

  final Color? activeSwitchColor;
  final Widget? value;
  final Function(bool value)? onToggle;
  final SettingsTileType tileType;
  final bool? on;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = SettingsTheme.of(context);

    switch (theme.platform) {
      case DevicePlatform.android:
        return AndroidSettingsTile(
          description: description,
          onPressed: onPressed,
          onToggle: onToggle,
          tileType: tileType,
          value: value,
          leading: leading,
          title: title,
          enabled: loading ? false : enabled,
          activeSwitchColor: activeSwitchColor,
          loading: loading,
          on: on,
          trailing: trailing,
        );
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
        return AppleSettingsTile(
          description: description,
          onPressed: onPressed,
          onToggle: onToggle,
          tileType: tileType,
          value: value,
          leading: leading,
          title: title,
          trailing: trailing,
          enabled: loading ? false : enabled,
          activeSwitchColor: activeSwitchColor,
          loading: loading,
          initialValue: on ?? false,
        );
      case DevicePlatform.web:
      case DevicePlatform.windows:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
        return WebSettingsTile(
          description: description,
          onPressed: onPressed,
          onToggle: onToggle,
          tileType: tileType,
          value: value,
          leading: leading,
          title: title,
          enabled: loading ? false : enabled,
          trailing: trailing,
          loading: loading,
          activeSwitchColor: activeSwitchColor,
          initialValue: on ?? false,
        );
      case DevicePlatform.device:
        throw Exception(
          'You can\'t use the DevicePlatform.device in this context. '
          'Incorrect platform: SettingsTile.build',
        );
    }
  }
}
