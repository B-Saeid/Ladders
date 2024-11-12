import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../../../Shared/Utilities/device_platform.dart';
import '../../settings_ui.dart';
import '../utils/theme_provider.dart';

enum ApplicationType {
  /// Use this parameter is you are using the MaterialApp
  material,

  /// Use this parameter is you are using the CupertinoApp
  cupertino,

  /// Use this parameter is you are using the MaterialApp for Android
  /// and the CupertinoApp for iOS.
  both,
}

class SettingsList extends ConsumerWidget {
  const SettingsList({
    required this.sections,
    this.shrinkWrap = false,
    this.physics,
    this.platform,
    this.lightTheme,
    this.darkTheme,
    this.brightness,
    this.contentPadding,
    super.key,
  });

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final DevicePlatform? platform;
  final SettingsThemeData? lightTheme;
  final SettingsThemeData? darkTheme;
  final Brightness? brightness;
  final EdgeInsetsGeometry? contentPadding;
  final List<AbstractSettingsSection> sections;

  DevicePlatform get _platform =>
      platform == null || platform == DevicePlatform.device ? StaticData.platform : platform!;

  SettingsThemeData settingsThemeData(WidgetRef ref) => ThemeProvider.getTheme(
        platform: _platform,
        isLight: LiveData.isLight(ref),
      ).merge(theme: brightness == Brightness.dark ? darkTheme : lightTheme);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1024),
          child: SettingsTheme(
            themeData: settingsThemeData(ref),
            platform: _platform,
            child: ListView.builder(
              physics: physics,
              shrinkWrap: shrinkWrap,
              itemCount: sections.length,
              padding: contentPadding,
              itemBuilder: (_, index) => sections[index],
            ),
          ),
        ),
      );
}
