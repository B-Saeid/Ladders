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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DevicePlatform platform;
    if (this.platform == null || this.platform == DevicePlatform.device) {
      platform = StaticData.platform;
    } else {
      platform = this.platform!;
    }

    final isLight = LiveData.isLight(ref);

    final themeData = ThemeProvider.getTheme(
      platform: platform,
      isLight: isLight,
    ).merge(theme: brightness == Brightness.dark ? darkTheme : lightTheme);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 810),
      child: SettingsTheme(
        themeData: themeData,
        platform: platform,
        child: ListView.builder(
          physics: physics,
          shrinkWrap: shrinkWrap,
          itemCount: sections.length,
          padding: contentPadding ?? calculateDefaultPadding(platform),
          itemBuilder: (BuildContext context, int index) {
            return sections[index];
          },
        ),
      ),
    );
  }

  EdgeInsets calculateDefaultPadding(DevicePlatform platform) {
    switch (platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
        return const EdgeInsets.only(top: 0);
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return const EdgeInsets.symmetric(vertical: 20);
      case DevicePlatform.web:
        return EdgeInsets.zero;
      case DevicePlatform.device:
        throw Exception(
          'You can\'t use the DevicePlatform.device in this context. '
          'Incorrect platform: SettingsList.calculateDefaultPadding',
        );
    }
  }
}
