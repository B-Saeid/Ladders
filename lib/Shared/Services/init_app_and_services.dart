import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'Database/Hive/hive_service.dart';
import 'Routing/routes_base.dart';
import 'l10n/l10n_service.dart';

Future<void> initServices() async {
  Timeline.startSync('initServices including startScreenSelector');
  // final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
  // final iOS = Platform.isIOS;
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final startPath = await startPathSelector();
  FlutterNativeSplash.remove();
  Timeline.finishSync();
  RoutesBase.startLocationNotifier.value = startPath;
}

Future<String> startPathSelector() async {
  await HiveService.init();
  L10nService.init();

  // final flnLaunchDetails = await NotificationService.getFLNAppLaunchDetails();
  // if (flnLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   return await _handleAppLaunchedFromFLNPlugin(response: flnLaunchDetails!.notificationResponse);
  // } else {
  /// TODO : DO your logic to navigate the user to the proper screen

  return RootRoute.path;

  /// TODO : This [if] is To be removed

  // }
}

// Future<String> _handleAppLaunchedFromFLNPlugin({NotificationResponse? response}) async {
//   /// TODO : IMPLEMENT ME ... direct the user to the proper screen LATER ON
//   print('===================== App Launched From Tapping on FLN Plugin Notification ================ ');
//   NotificationService.testingPrint(response!);
//   // return Container();
//   return RootRoute.path;
// }
