import 'package:permission_handler/permission_handler.dart';

import '../../Extensions/on_strings.dart';
import '../l10n/assets/l10n_resources.dart';

/// We aim in this service for a couple of goals:
///   >>> First: To Conceal the original package within the service.
///   >>> Second: To make it a reusable permission interface in any mobile app.
enum MyPermission {
  camera,
  location,
  locationWhenInUse,
  locationAlways,
  notification,
  microphone,
  photos,
  scheduleExactAlarm,
  sensors,
  sensorsAlways,
  storage,
  videos;

  String get readableName => switch (this) {
        MyPermission.locationAlways => L10nR.tLocationAlwaysReadableName,
        _ => name.upperFirstLetter
      };

  String get reason => switch (this) {
        MyPermission.camera => L10nR.tCameraReason,
        MyPermission.microphone => L10nR.tMicrophoneReason,
        MyPermission.photos => L10nR.tPhotosReason,
        MyPermission.storage => L10nR.tPhotosReason,
        MyPermission.location => throw UnimplementedError(),
        MyPermission.locationWhenInUse => throw UnimplementedError(),
        MyPermission.locationAlways => L10nR.tLocationAlwaysReason,
        MyPermission.notification => throw UnimplementedError(),
        MyPermission.scheduleExactAlarm => throw UnimplementedError(),
        MyPermission.sensors => throw UnimplementedError(),
        MyPermission.sensorsAlways => throw UnimplementedError(),
        MyPermission.videos => throw UnimplementedError(),
      };

  static List<MyPermissionStatus> _fullOrNothing = [MyPermissionStatus.granted];
  static List<MyPermissionStatus> _canBeLimited = [
    MyPermissionStatus.granted,
    MyPermissionStatus.limited
  ];
  static List<MyPermissionStatus> _rareToSettingsStatuses = [
    MyPermissionStatus.denied,
    MyPermissionStatus.permanentlyDenied,
  ];

  // static List<MyPermissionStatus> _canBeProvisional = [MyPermissionStatus.granted,MyPermissionStatus.provisional];
  List<MyPermissionStatus> get acceptableStatuses => switch (this) {
        MyPermission.camera => _fullOrNothing,
        MyPermission.location => _fullOrNothing,
        MyPermission.locationWhenInUse => _fullOrNothing,
        MyPermission.locationAlways => _fullOrNothing,
        MyPermission.notification => _fullOrNothing,
        MyPermission.microphone => _fullOrNothing,
        MyPermission.photos => _canBeLimited,
        MyPermission.videos => _canBeLimited,
        MyPermission.storage => _fullOrNothing,
        MyPermission.scheduleExactAlarm => throw UnimplementedError(),
        MyPermission.sensors => throw UnimplementedError(),
        MyPermission.sensorsAlways => throw UnimplementedError(),
      };

  List<MyPermissionStatus> get toSettingsStatuses => switch (this) {
        MyPermission.locationAlways => _rareToSettingsStatuses, // this is added by experience
        _ => [MyPermissionStatus.permanentlyDenied]
      };

  Permission get packagePermission =>
      // This element.toString() == 'Permission.$name' .. >> Because Permission is a class not an enum
      Permission.values.firstWhere((element) => element.toString() == 'Permission.$name');
}

enum MyPermissionStatus {
  /// The user denied access to the requested feature, permission needs to be
  /// asked first.
  denied,

  /// The user granted access to the requested feature.
  granted,

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  ///
  /// *Only supported on iOS.*
  restricted,

  /// The user has authorized this application for limited access. So far this
  /// is only relevant for the Photo Library picker.
  ///
  /// *Only supported on iOS (iOS14+).*
  limited,

  /// Permission to the requested feature is permanently denied, the permission
  /// dialog will not be shown when requesting this permission. The user may
  /// still change the permission status in the settings.
  ///
  /// *On Android:*
  /// Android 11+ (API 30+): whether the user denied the permission for a second
  /// time.
  /// Below Android 11 (API 30): whether the user denied access to the requested
  /// feature and selected to never again show a request.
  ///
  /// *On iOS:*
  /// If the user has denied access to the requested feature.
  permanentlyDenied,

  /// The application is provisionally authorized to post non-interruptive user
  /// notifications.
  ///
  /// *Only supported on iOS (iOS12+).*
  provisional,
}

/// All available permissions - You can add what you need above in [MyPermission]
//     calendar,
//     camera,
//     contacts,
//     location,
//     locationAlways,
//     locationWhenInUse,
//     mediaLibrary,
//     microphone,
//     phone,
//     photos,
//     photosAddOnly,
//     reminders,
//     sensors,
//     sms,
//     speech,
//     storage,
//     ignoreBatteryOptimizations,
//     notification,
//     accessMediaLocation,
//     activityRecognition,
//     unknown,
//     bluetooth,
//     manageExternalStorage,
//     systemAlertWindow,
//     requestInstallPackages,
//     appTrackingTransparency,
//     criticalAlerts,
//     accessNotificationPolicy,
//     bluetoothScan,
//     bluetoothAdvertise,
//     bluetoothConnect,
//     nearbyWifiDevices,
//     videos,
//     audio,
//     scheduleExactAlarm,
//     sensorsAlways,
//     calendarWriteOnly,
//     calendarFullAccess,
