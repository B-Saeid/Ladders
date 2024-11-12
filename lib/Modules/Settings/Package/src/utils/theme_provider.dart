import 'package:flutter/cupertino.dart';

import '../../../../../Shared/Utilities/device_platform.dart';
import '../../settings_ui.dart';

class ThemeProvider {
  static SettingsThemeData getTheme({
    required DevicePlatform platform,
    required bool isLight,
  }) {
    switch (platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
        return _androidTheme(isLight);
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return _iosTheme(isLight);
      case DevicePlatform.web:
        return _webTheme(isLight);
      case DevicePlatform.device:
        throw Exception(
          'You can\'t use the DevicePlatform.device in this context. '
          'Incorrect platform: ThemeProvider.getTheme',
        );
    }
  }

  static SettingsThemeData _androidTheme(bool isLight) {
    const lightLeadingIconsColor = Color.fromARGB(255, 70, 70, 70);
    const darkLeadingIconsColor = Color.fromARGB(255, 197, 197, 197);

    // const lightSettingsListBackground = Color.fromRGBO(240, 240, 240, 1);
    // const darkSettingsListBackground = Color.fromRGBO(27, 27, 27, 1);

    const lightSettingsTitleColor = Color.fromRGBO(11, 87, 208, 1);
    const darkSettingsTitleColor = Color.fromRGBO(211, 227, 253, 1);

    const lightTileHighlightColor = Color.fromARGB(255, 220, 220, 220);
    const darkTileHighlightColor = Color.fromARGB(255, 46, 46, 46);

    const lightInactiveTitleColor = Color.fromARGB(255, 146, 144, 148);
    const darkInactiveTitleColor = Color.fromARGB(255, 118, 117, 122);

    const lightInactiveSubtitleColor = Color.fromARGB(255, 197, 196, 201);
    const darkInactiveSubtitleColor = Color.fromARGB(255, 71, 70, 74);

    const lightTileDescriptionTextColor = Color.fromARGB(255, 70, 70, 70);
    const darkTileDescriptionTextColor = Color.fromARGB(255, 198, 198, 198);

    // final listBackground = isLight ? lightSettingsListBackground : darkSettingsListBackground;

    final titleTextColor = isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

    final tileHighlightColor = isLight ? lightTileHighlightColor : darkTileHighlightColor;

    final tileDescriptionTextColor =
        isLight ? lightTileDescriptionTextColor : darkTileDescriptionTextColor;

    final leadingIconsColor = isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

    final inactiveTitleColor = isLight ? lightInactiveTitleColor : darkInactiveTitleColor;

    final inactiveSubtitleColor = isLight ? lightInactiveSubtitleColor : darkInactiveSubtitleColor;

    return SettingsThemeData(
      tileHighlightColor: tileHighlightColor,
      // settingsListBackground: listBackground,
      titleTextColor: titleTextColor,
      tileDescriptionTextColor: tileDescriptionTextColor,
      leadingIconsColor: leadingIconsColor,
      inactiveTitleColor: inactiveTitleColor,
      inactiveSubtitleColor: inactiveSubtitleColor,
    );
  }

  static SettingsThemeData _iosTheme(bool isLight) {
    // const lightSettingsListBackground = Color.fromRGBO(242, 242, 247, 1);
    // const darkSettingsListBackground = CupertinoColors.black;

    const lightSettingSectionColor = CupertinoColors.white;
    const darkSettingSectionColor = Color(0xff1C1C1E);

    const lightSettingsTitleColor = Color.fromRGBO(109, 109, 114, 1);
    const darkSettingsTitleColor = CupertinoColors.systemGrey;

    const lightDividerColor = Color.fromARGB(255, 238, 238, 238);
    const darkDividerColor = Color.fromARGB(255, 40, 40, 42);

    const lightTrailingTextColor = Color.fromARGB(255, 138, 138, 142);
    const darkTrailingTextColor = Color.fromARGB(255, 152, 152, 159);

    const lightTileHighlightColor = Color.fromARGB(255, 209, 209, 214);
    const darkTileHighlightColor = Color.fromARGB(255, 58, 58, 60);

    const lightLeadingIconsColor = CupertinoColors.systemGrey;
    const darkLeadingIconsColor = CupertinoColors.systemGrey;

    const lightTileDescriptionTextColor = Color.fromARGB(255, 57, 57, 57);
    const darkTileDescriptionTextColor = Color.fromARGB(154, 227, 227, 227);
    // final listBackground = isLight ? lightSettingsListBackground : darkSettingsListBackground;

    final tileBackgroundColor = isLight ? lightSettingSectionColor : darkSettingSectionColor;

    final sectionTitleTextColor = isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

    final dividerColor = isLight ? lightDividerColor : darkDividerColor;

    final trailingTextColor = isLight ? lightTrailingTextColor : darkTrailingTextColor;

    final tileHighlightColor = isLight ? lightTileHighlightColor : darkTileHighlightColor;

    final leadingIconsColor = isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

    final tileDescriptionTextColor =
        isLight ? lightTileDescriptionTextColor : darkTileDescriptionTextColor;
    final inactiveTitleColor =
        isLight ? CupertinoColors.inactiveGray : CupertinoColors.inactiveGray.darkColor.withOpacity(0.4);

    return SettingsThemeData(
      tileHighlightColor: tileHighlightColor,
      // settingsListBackground: listBackground,
      tileColor: tileBackgroundColor,
      titleTextColor: sectionTitleTextColor,
      dividerColor: dividerColor,
      trailingTextColor: trailingTextColor,
      leadingIconsColor: leadingIconsColor,
      inactiveTitleColor: inactiveTitleColor,
      inactiveSubtitleColor: inactiveTitleColor,
      tileDescriptionTextColor: tileDescriptionTextColor,
    );
  }

  static SettingsThemeData _webTheme(bool isLight) {
    const lightLeadingIconsColor = Color.fromARGB(255, 70, 70, 70);
    const darkLeadingIconsColor = Color.fromARGB(255, 197, 197, 197);

    // const lightSettingsListBackground = Color.fromRGBO(240, 240, 240, 1);
    //done
    // const darkSettingsListBackground = Color.fromRGBO(32, 33, 36, 1);

    const lightSettingSectionColor = CupertinoColors.white;
    //done
    const darkSettingSectionColor = Color(0xFF292a2d);

    const lightSettingsTitleColor = Color.fromRGBO(11, 87, 208, 1);
    //done
    const darkSettingsTitleColor = Color.fromRGBO(232, 234, 237, 1);

    const lightTileHighlightColor = Color.fromARGB(255, 220, 220, 220);
    const darkTileHighlightColor = Color.fromARGB(255, 46, 46, 46);

    const lightTileDescriptionTextColor = Color.fromARGB(255, 70, 70, 70);
    const darkTileDescriptionTextColor = Color.fromARGB(154, 160, 166, 198);

    // final listBackground = isLight ? lightSettingsListBackground : darkSettingsListBackground;

    final titleTextColor = isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

    final tileHighlightColor = isLight ? lightTileHighlightColor : darkTileHighlightColor;

    final tileDescriptionTextColor =
        isLight ? lightTileDescriptionTextColor : darkTileDescriptionTextColor;

    final leadingIconsColor = isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

    final sectionBackground = isLight ? lightSettingSectionColor : darkSettingSectionColor;

    return SettingsThemeData(
      tileHighlightColor: tileHighlightColor,
      // settingsListBackground: listBackground,
      titleTextColor: titleTextColor,
      tileColor: sectionBackground,
      tileDescriptionTextColor: tileDescriptionTextColor,
      leadingIconsColor: leadingIconsColor,
    );
  }
}
