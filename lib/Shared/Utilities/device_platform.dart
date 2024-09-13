import 'dart:io';

import 'package:flutter/foundation.dart';

enum DevicePlatform {
  /// Android: <https://www.android.com/>
  android,

  /// Fuchsia: <https://fuchsia.dev/fuchsia-src/concepts>
  fuchsia,

  /// iOS: <https://www.apple.com/ios/>
  iOS,

  /// Linux: <https://www.linux.org>
  linux,

  /// macOS: <https://www.apple.com/macos>
  macOS,

  /// Windows: <https://www.windows.com>
  windows,

  /// Web
  web,

  /// Use this to specify you want to use the default device platform
  device;

  bool get isAndroid => this == DevicePlatform.android;

  bool get isFuchsia => this == DevicePlatform.fuchsia;

  bool get isIOS => this == DevicePlatform.iOS;

  bool get isApple => [DevicePlatform.iOS, DevicePlatform.macOS].contains(this);

  bool get isLinux => this == DevicePlatform.linux;

  bool get isMacOS => this == DevicePlatform.macOS;

  bool get isWindows => this == DevicePlatform.windows;

  bool get isWeb => this == DevicePlatform.web;

  static DevicePlatform from(TargetPlatform targetPlatform) {
    if (kIsWeb) return DevicePlatform.web;

    switch (targetPlatform) {
      case TargetPlatform.android:
        return DevicePlatform.android;
      case TargetPlatform.fuchsia:
        return DevicePlatform.fuchsia;
      case TargetPlatform.iOS:
        return DevicePlatform.iOS;
      case TargetPlatform.linux:
        return DevicePlatform.linux;
      case TargetPlatform.macOS:
        return DevicePlatform.macOS;
      case TargetPlatform.windows:
        return DevicePlatform.windows;
    }
  }

  static DevicePlatform get fromIO {
    if (kIsWeb) return DevicePlatform.web;
    if (Platform.isLinux) return DevicePlatform.linux;
    if (Platform.isMacOS) return DevicePlatform.macOS;
    if (Platform.isWindows) return DevicePlatform.windows;
    if (Platform.isAndroid) return DevicePlatform.android;
    if (Platform.isIOS) return DevicePlatform.iOS;
    if (Platform.isFuchsia) return DevicePlatform.fuchsia;
    return DevicePlatform.device;
  }
}
