import 'package:flutter/material.dart';

import '../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../settings_ui.dart';
import 'platforms/android_settings_section.dart';
import 'platforms/apple_settings_section.dart';
import 'platforms/web_settings_section.dart';

class SettingsSection extends AbstractSettingsSection {
  const SettingsSection({
    required this.tiles,
    this.margin,
    this.header,
    super.key,
  });

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    final platform = StaticData.platform; 

    if (platform.isApple) {
      return AppleSettingsSection(
        header: header,
        tiles: tiles,
        margin: margin,
      );
    } else if (platform.isWeb) {
      return WebSettingsSection(
        header: header,
        tiles: tiles,
        margin: margin,
      );
    } else {
      return AndroidSettingsSection(
        header: header,
        tiles: tiles,
        margin: margin,
      );
    }
  }
}
