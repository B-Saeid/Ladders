import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';


export 'boxes_keys/stored_cache_keys.dart';

part 'boxes_keys/settings_keys.dart';
part 'constants.dart';
part 'device_info_model.dart';

abstract class HiveService {
  static const String _subdirectory = r'appconfigdata';

  // static late final Box userVolt;
  static late final Box settings;
  static late final Box storedCache;
  static late final Box _deviceInfo;
  static final AndroidInfo? androidInfo = Platform.isAndroid ? AndroidInfo() : null;
  static final IOSInfo? iosInfo = Platform.isIOS ? IOSInfo() : null;

  static Future<void> init() async {
    await Hive.initFlutter(_subdirectory);
    // userVolt = await _openUserVoltBox();
    settings = await Hive.openBox(_HiveBoxesNames.settings);
    storedCache = await Hive.openBox(_HiveBoxesNames.storedCache);
    _deviceInfo = await Hive.openBox(_HiveBoxesNames.deviceInfo);
    await _setDeviceInfoBox();
  }


  static bool _deviceInfoSet = false;

  static Future<void> _setDeviceInfoBox() async {
    if (!_deviceInfoSet) {
      _deviceInfoSet = true;
      if (_deviceInfo.isEmpty) {
        if (Platform.isAndroid) {
          final info = await DeviceInfoPlugin().androidInfo;
          await androidInfo!._setInfoFromPlugin(info);
        } else {
          final info = await DeviceInfoPlugin().iosInfo;
          await iosInfo!._setInfoFromPlugin(info);
        }
      } else {
        Platform.isAndroid
            ? androidInfo!._setInfoFromBox(_deviceInfo)
            : iosInfo!._setInfoFromBox(_deviceInfo);
      }
    }
  }

  /// TODO : Should be called in the top app dispose method
  static Future<void> closeAllBoxes() async => await Hive.close();
}
