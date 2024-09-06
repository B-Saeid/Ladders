// import 'dart:async';
//
// import 'package:flutter_app_badger/flutter_app_badger.dart';
//
// import '../../Database/Persistence/data_store.dart';
// import '../notification_service.dart';
//
// class AppBadger {
//   AppBadger._();
//
//   static Timer? _everySecTimer;
//
//   static bool isSupported = false;
//
//   static Future<void> initLiveUpdater() async {
//     if (await checkIfSupportedOnDevice()) {
//       /// The ??= guard against memory leaks of creating multiple timers
//       _everySecTimer ??=
//           Timer.periodic(const Duration(seconds: 1), (_) async => await checkActiveNsAndUpdate());
//     }
//   }
//
//   static bool? allSet;
//
//   static Future<void> checkActiveNsAndUpdate() async {
//     /// this extra check on [isSupported] is because this function can be called without calling [initializeLiveUpdater]
//     /// to update the badge on purpose for ex: when app is in background
//     if (isSupported) {
//       allSet ??= await NotificationService.initialize();
//       if (allSet ?? false) {
//         final currentlyActiveList = await NotificationService.activeList;
//         if (currentlyActiveList.isNotEmpty) {
//           await _set(to: currentlyActiveList.length);
//         } else {
//           await _remove();
//         }
//       }
//     }
//   }
//
//   static void disposeLiveUpdater() => _everySecTimer?.cancel();
//
//   static Future<bool> checkIfSupportedOnDevice() async {
//     final boolString = await DataStore.getValue(key: DataStoreKeys.appBadgerSupported);
//     if (boolString != null) {
//       isSupported = bool.parse(boolString);
//     } else {
//       isSupported = await FlutterAppBadger.isAppBadgeSupported();
//       await DataStore.saveValue(key: DataStoreKeys.appBadgerSupported, value: isSupported.toString());
//     }
//     return isSupported;
//   }
//
//   static Future<void> _set({required int to}) async => await FlutterAppBadger.updateBadgeCount(to);
//
//   static Future<void> _remove() async => await FlutterAppBadger.removeBadge();
//
//   /// TODO : Add it to the dispose list of classes right after runApp may be.
//   static void dispose() {
//     disposeLiveUpdater();
//   }
// }
