import 'package:flutter/material.dart';

import '../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../../../Shared/Utilities/device_platform.dart';
import '../../settings_ui.dart';
import 'platforms/android_settings_section.dart';
import 'platforms/ios_settings_section.dart';
import 'platforms/web_settings_section.dart';

class SettingsSection extends AbstractSettingsSection {
  const SettingsSection({
    required this.tiles,
    this.margin,
    this.title,
    super.key,
  });

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final platform = StaticData.platform;

    switch (platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
        return AndroidSettingsSection(
          title: title,
          tiles: tiles,
          margin: margin,
        );
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
        return IOSSettingsSection(
          title: title,
          tiles: tiles,
          margin: margin,
        );
      case DevicePlatform.web:
        return WebSettingsSection(
          title: title,
          tiles: tiles,
          margin: margin,
        );
      case DevicePlatform.device:
        throw Exception(
          'You can\'t use the DevicePlatform.device in this context. '
          'Incorrect platform: SettingsSection.build',
        );
    }
  }
}
