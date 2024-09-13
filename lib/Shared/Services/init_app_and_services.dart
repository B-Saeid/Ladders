import 'dart:developer';

import 'package:flutter/material.dart';

import 'Database/Hive/hive_service.dart';
import 'Routing/routes_base.dart';

Future<void> initServices() async {
  Timeline.startSync('initServices including startScreenSelector');
  // final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
  // final iOS = Platform.isIOS;
  WidgetsFlutterBinding.ensureInitialized();

  /// TODO : Later implement this when you design logo
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final startPath = await startPathSelector();
  // FlutterNativeSplash.remove();
  // Timeline.finishSync();
  RoutesBase.startLocationNotifier.value = startPath;
}

Future<String> startPathSelector() async {
  await HiveService.init();

  // final flnLaunchDetails = await NotificationService.getFLNAppLaunchDetails();
  // if (flnLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   return await _handleAppLaunchedFromFLNPlugin(response: flnLaunchDetails!.notificationResponse);
  // } else {

  return RootRoute.path;
}

// Future<String> _handleAppLaunchedFromFLNPlugin({NotificationResponse? response}) async {
//   /// TODO : IMPLEMENT ME ... direct the user to the proper screen LATER ON
//   print('===================== App Launched From Tapping on FLN Plugin Notification ================ ');
//   NotificationService.testingPrint(response!);
//   // return Container();
//   return RootRoute.path;
// }
