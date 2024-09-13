part of 'hive_service.dart';

class AndroidInfo {
  AndroidInfo._();

  static AndroidInfo get _instance => AndroidInfo._();

  factory AndroidInfo() => _instance;

  /// Example : Android 7 Nougat has [sdkVersion] of 24 and Android 14 >> 34 and so on.
  late final int sdkVersion;

  void _setInfoFromBox(Box info) {
    sdkVersion = info.get(_AndroidInfoKeys.sdk);
  }

  /// This is done only in the very first run of the app
  /// or any time it is reinstalled or any time appData is cleared .. U get the idea !
  Future<void> _setInfoFromPlugin(AndroidDeviceInfo info) async {
    sdkVersion = info.version.sdkInt;
    await HiveService._deviceInfo.put(_AndroidInfoKeys.sdk, sdkVersion);
  }
}

class IOSInfo {
  IOSInfo._();

  static IOSInfo get _instance => IOSInfo._();

  factory IOSInfo() => _instance;

  /// TODO: Complete These Two Methods when you need to access any thing related to ios Device info

  // void _setInfoFromBox(Box deviceInfo) {}
  //
  // Future<void> _setInfoFromPlugin(IosDeviceInfo info) async {}
}
