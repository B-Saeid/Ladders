// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:isolate';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../../../Models/vehicle_model.dart';
// import '../Database/Hive/hive_service.dart';
// import '../Database/Persistence/data_store.dart';
// import 'android_specific/android_parts.dart';
// import 'assets/common_parts.dart';
// import 'assets/launcher_icon_count_badge.dart';
// import 'ios_specific/ios_parts.dart';
//
// /// Scheduled Android notifications
// // Some Android OEMs have their own customised Android OS that can prevent applications from running in the background.
// // Consequently, scheduled notifications may not work when the application is in the background on certain devices
// // (e.g. by Xiaomi, Huawei). If you experience problems like this then this would be the reason why.
// // As it's a restriction imposed by the OS, this is not something that can be resolved by the plugin.
// // Some devices may have setting that lets users control which applications run in the background.
// // The steps for these can vary but it is still up to the users of your application to do given
// // it's a setting on the phone itself. The site [https://]dontkillmyapp.com provides details on how to do this for various devices.
// //
// //
// // /// Scheduled notifications and daylight saving time The notification APIs used on iOS versions older than 10
// // (aka the UILocalNotification APIs) have limited supported for time zones.
//
// /// Prepare Sound Resources for iOS
// // Custom notification sounds >>> iOS and macOS restrictions apply (e.g. supported file formats).
// //
// // The system sound facility plays custom alert sounds, so they must be in one of the following audio data formats:
// //
// //     Linear PCM
// //
// //     MA4 (IMA/ADPCM)
// //
// //     µLaw
// //
// //     aLaw
// //
// // You can package the audio data in an aiff, wav, or caf file. Sound files must be less than 30 seconds in length.
// // If the sound file is longer than 30 seconds, the system plays the default sound instead.
// //
// // You can use the afconvert command-line tool to convert sounds. For example, to convert the system sound
// // Submarine.aiff to IMA4 audio in a CAF file, use the following command in Terminal:
// //
// // afconvert /System/Library/Sounds/Submarine.aiff ~/Desktop/sub.caf -d ima4 -f caff -v
//
// /// Notification payload on iOS
// // Due to some limitations on iOS with how it treats null values in dictionaries,
// // a null notification payload is coalesced to an empty string behind the scenes on all platforms for consistency.
//
// /// If the app requires scheduling notifications with exact timings (aka exact alarms),
// //
// // there are two options since Android 14 brought about behavioural changes (see here for more details)
// //
// // T O D O : DONE! specify <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
// // and call the requestExactAlarmsPermission() exposed by the AndroidFlutterNotificationsPlugin class
// // so that the user can grant the permission via the app like so :
// //
// // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
// //     .requestExactAlarmsPermission();
// //
// // OR
// //
// // [NotRecommended] since it is not fully understood.
// // specify <uses-permission android:name="android.permission.USE_EXACT_ALARM" />.
// // Users will not be prompted to grant permission, however as per the official Android documentation
// // on the USE_EXACT_ALARM permission (refer to here and here), this requires the app to target
// // Android 13 (API level 33) or higher and could be subject to approval and auditing by the app store(s)
// // used to publish the app
// //
//
// /// Requesting permissions on Android 13 or higher
// // From Android 13 (API level 33) onwards, apps now have the ability to display a prompt where users can decide
// // if they want to grant an app permission to show notifications. For further reading on this matter read
// // https://developer.android.com/guide/topics/ui/notifiers/notification-permission.
// // To support this applications need target their application to Android 13 or higher and
// // the compile SDK version needs to be at least 33 (Android 13). For example, to target Android 13,
// // update your app's build.gradle file to have a targetSdkVersion of 33.
// // Applications can then call the following code to request the permission where the requestPermission method
// // is associated with the AndroidFlutterLocalNotificationsPlugin class (i.e. the Android implementation of the plugin)
// //
// // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
// // .requestNotificationsPermission();
//
// /// Note regarding full-screen intent
// // Note that when a full-screen intent notification actually occurs (as opposed to a heads-up notification that the system
// // may decide should occur), the plugin will act as though the user has tapped on a notification so handle those the same way
// // (e.g. onDidReceiveNotificationResponse callback) to display the appropriate page for your application.
//
// /// When Releasing
// // Make sure to follow along with close attention and update if necessary
// // https://pub.dev/packages/flutter_local_notifications#release-build-configuration
//
// /// Handling notifications whilst the app is in the foreground
// //
// // By design, iOS applications do not display notifications while the app is in the foreground unless configured to do so.
// //
// // For iOS 10+, use the presentation options to control the behaviour for when a notification is triggered
// // while the app is in the foreground. The default settings of the plugin will configure these such that a notification
// // will be displayed when the app is in the foreground.
// //
// // For older versions of iOS, you need to handle the callback as part of specifying the method
// // that should be fired to the onDidReceiveLocalNotification argument when creating an
// // instance DarwinInitializationSettings object that is passed to the function for initializing the plugin.
// //
// // example: https://pub.dev/packages/flutter_local_notifications#handling-notifications-whilst-the-app-is-in-the-foreground
// //
// // You get the idea >> however we intend to use in-app-notifications plugins such as:
// // package:  elegant_notification
// // package:  and/or in_app_notification // yes, this is its name
//
// /// Notification Actions
// //
// // [Important]
// // Notifications can now contain actions but note that on Apple's platforms, these work only on iOS 10 or newer
// // and macOS 10.14 or newer. On macOS and Linux (see Linux limitations chapter), these will only run on
// // the main isolate by calling the onDidReceiveNotificationResponse callback. On iOS and Android,
// // these will run on the main isolate by calling the onDidReceiveNotificationResponse callback if
// // the configuration has specified that the app/user interface should be shown i.e. by specifying
// // the DarwinNotificationActionOption.foreground option on iOS and the showsUserInterface property on Android.
// // If they haven't, then these actions may be selected by the user when an app is sleeping or terminated and
// // will wake up your app. However, it may not wake up the user-visible part of your App; but only the
// // part of it which runs in the background. This is done by spawning a background isolate.
// //
// // This plugin contains handlers for iOS & Android to handle these background isolate cases and will allow
// // you to specify a Dart entry point (a function). When the user selects a action, the plugin will start
// // a separate Flutter Engine which will then invoke the onDidReceiveBackgroundNotificationResponse callback
// //
// //
// // On Android you can put the actions directly in the AndroidNotificationDetails class.
// // Unlike Android iOS/macOS, notification actions need to be configured before the app is started using the initialize method
// //
// // final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
// //     // ...
// //     notificationCategories: [
// // T O D O: DONE! [important] On iOS/macOS, the notification category will define which actions are available.
// //       DarwinNotificationCategory(
// //         'demoCategory',
// //         actions: <DarwinNotificationAction>[
// //             DarwinNotificationAction.plain('id_1', 'Action 1'),
// //             DarwinNotificationAction.plain(
// //             'id_2',
// //             'Action 2',
// //             options: <DarwinNotificationActionOption>{
// //                 DarwinNotificationActionOption.destructive,
// //             },
// //             ),
// //             DarwinNotificationAction.plain(
// //             'id_3',
// //             'Action 3',
// //             options: <DarwinNotificationActionOption>{
// //                 DarwinNotificationActionOption.foreground,
// //             },
// //             ),
// //         ],
// //         options: <DarwinNotificationCategoryOption>{
// //             DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
// //         },
// //     )
// // ],
//
// /// Background Notification Clicked
// // You need to configure a top level or static method which will handle the action:
// //
// // @pragma('vm:entry-point')
// // void notificationTapBackground(NotificationResponse notificationResponse) {
// //   // handle action
// // }
// //
// // Specify this function as a parameter in the initialize method of this plugin:
// //
// //
// // await flutterLocalNotificationsPlugin.initialize(
// //     initializationSettings,
// //     onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
// //         // ...
// //     },
// //     onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
// // );
//
// /// Foreground Notification Clicked
// // The function (onDidReceiveNotificationResponse) that should fire when a notification has been tapped on via
// // the onDidReceiveNotificationResponse callback. Specifying this callback is entirely optional but here it will trigger
// // navigation to another page and display the payload associated with the notification. This callback cannot be used to
// // handle when a notification launched an app. T o d o: DONE! Use the [getNotificationAppLaunchDetails] method when the app starts if you need
// // T o d o: DONE! to handle when a notification triggering the launch for an app e.g. change the home route of the app for deep-linking.
// //
// // void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
// //     final String? payload = notificationResponse.payload;
// //     if (notificationResponse.payload != null) {
// //       debugPrint('notification payload: $payload');
// //     }
// //     await Navigator.push(
// //       context,
// //       MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
// //     );
// // }
//
// /// Understanding the differences between channelId, channelName, channelAction Strings And the integer id of the show function
// // channelId and channelName are only present in androidNotificationDetails
// // and are required from Android Oreo 8 and newer... channelId is unique for every channel i.e. if changed a new channel
// // will be created regardless of channelName ... Also Note that channelAction has two enum values :
// // [AndroidNotificationChannelAction.update] and [AndroidNotificationChannelAction.createIfNotExists]
// // The first will look for an existing channel with the id provided if not found notification will not trigger
// //
//
// /// [VERY IMPORTANT TO UNDERSTAND]
// // The integer id is common to all methods that would result in
// // a notification being shown. This is typically set to unique value per notification AS USING the same id
// // multiple times [would result in a notification being [updated]/overwritten].
// // So If you want to update a certain notification make sure you have a predefined setter for the id string value
// // for each notification and then call [NotificationService] to show it with the same id and put your updates
// // in the other parameters to your liking. UNDERSTOOD 😍!
//
// abstract class NotificationService {
//   /// Singleton
//   // NotificationService._() {}
//
//   // static final NotificationService _sharedInstance = NotificationService._();
//
//   // factory NotificationService() => _sharedInstance;
//
//   /// Properties
//   static final _pluginInstance = FlutterLocalNotificationsPlugin();
//
//   static NotificationResponse? _lastResponse;
//
//   static NotificationResponse? get lastResponse => _lastResponse;
//
//   /// TODO : Handle it later on
//   // static  StreamController<NotificationResponse?>? _selectedStreamController;
//
//   // static Stream<NotificationResponse?> get selectedStream => _selectedStreamController.stream;
//
//   static void _configureSelectedBehaviour() {
//     // _selectedStreamController ??= StreamController<NotificationResponse?>.broadcast(
//     //   onListen: () => _selectedStreamController.add(_lastResponse),
//     // );
//     // _selectNotificationStreamController.stream.listen((NotificationResponse? notificationResponse) async {
//     /// You should act upon the selected notification or the select action and perform the intended task
//     /// TODO : The following was just for testing
//     //   // await Navigator.of(context).push(MaterialPageRoute<void>(
//     //   //   builder: (BuildContext context) => SecondPage(payload),
//     //   // ));
//     // });
//   }
//
//   @pragma('vm:entry-point')
//   static Future<void> _onBackgroundNOrActionTapped(NotificationResponse notificationResponse) async {
//     /// TODO : handle background action
//     print('Background NotificationOrActionTapped called');
//     await AppBadger.checkActiveNsAndUpdate();
//     testingPrint(notificationResponse);
//   }
//
//   static Future<void> _onForegroundNOrActionTapped(NotificationResponse notificationResponse) async {
//     /// TODO : handle foreground action
//     print('onForegroundNotificationTapped called THE GENERAL ONE');
//     await AppBadger.checkActiveNsAndUpdate();
//     testingPrint(notificationResponse);
//   }
//
//   static Future<void> testingPrint(NotificationResponse notificationResponse) async {
//     switch (notificationResponse.notificationResponseType) {
//       case NotificationResponseType.selectedNotification:
//         print('Notification has been selected');
//         // _selectNotificationStream.add(notificationResponse.payload);
//         break;
//       case NotificationResponseType.selectedNotificationAction:
//         print('Action has been selected');
//         // if (notificationResponse.actionId == navigationActionId) {
//         //   _selectNotificationStream.add(notificationResponse.payload);
//         // }
//         break;
//     }
//     print('id: ${notificationResponse.id}');
//     print('actionId : ${notificationResponse.actionId}');
//     print('input : ${notificationResponse.input}');
//     print('payload : ${notificationResponse.payload}');
//   }
//
//   static Future<bool> _requestPermission() async {
//     return Platform.isAndroid
//         ? await _pluginInstance
//                 .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//
//                 /// Requests the `POST_NOTIFICATIONS` permission on Android 13 Tiramisu (API
//                 /// level 33) and newer. On older versions, it is a no-op.
//                 /// This is experienced and It is true The [show] function will not work
//                 /// until this is called on Android 13+.
//                 /// If Below 13 > [show] function will work as notification permission
//                 /// is granted automatically by the system.
//                 ?.requestNotificationsPermission() ??
//             false
//         : await _pluginInstance
//                 .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
//                 ?.requestPermissions(
//                   alert: true,
//                   badge: true,
//                   critical: true,
//                   // provisional: true,
//                   sound: true,
//                 ) ??
//             false;
//   }
//
//   /// Necessary to Insistent Notification to work since Android 14
//   static Future<bool> requestExactAlarmsPermission() async =>
//       await _pluginInstance
//           .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//
//           /// Requests the `POST_NOTIFICATIONS` permission on Android 13 Tiramisu (API
//           /// level 33) and newer. On older versions, it is a no-op. /// This is experienced and It is true.
//           /// The [show] function will not work until this is called on Android 13+ If Below 13 > [show] function
//           /// will work as notification permission is granted automatically by the system.
//           ?.requestExactAlarmsPermission() ??
//       false;
//
//   static Future<void> _createAndroidChannelsIfNotExist() async {
//     // try {
//     final alreadyExistString = await DataStore.getValue(key: DataStoreKeys.androidNChannels);
//     if (alreadyExistString == true.toString()) {
//       return;
//     }
//     final androidSpecific =
//         _pluginInstance.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//     // I think it will be null on ios
//     if (androidSpecific != null) {
//       await androidSpecific.createNotificationChannelGroup(
//         AndroidNotificationChannelGroup(
//           AndroidNChannelGroups.bookingsFromDrivers.id,
//           AndroidNChannelGroups.bookingsFromDrivers.name,
//           description: AndroidNChannelGroups.bookingsFromDrivers.description,
//         ),
//       );
//       final isUserDriver = HiveService.userVolt.get(Vehicle.mVehicles) != null;
//
//       if (isUserDriver) {
//         await androidSpecific.createNotificationChannelGroup(
//           AndroidNotificationChannelGroup(
//             AndroidNChannelGroups.bookingsFromRiders.id,
//             AndroidNChannelGroups.bookingsFromRiders.name,
//             description: AndroidNChannelGroups.bookingsFromRiders.description,
//           ),
//         );
//       }
//
//       /// TODO : After testing Do NOT create driver related channels
//       /// like pending & cancelled Bookings without checking
//       await Future.forEach(
//         AndroidNChannel.values,
//         (element) async => await androidSpecific.createNotificationChannel(element.packageChannel),
//       );
//     }
//     await DataStore.saveValue(
//       key: DataStoreKeys.androidNChannels,
//       value: true.toString(),
//     );
//     // } catch (error) {
//     //   print('error while _createAndroidNotificationChannelsIfNotExist : ${error.toString()} ');
//     // }
//   }
//
//   /// This is a MUST
//   // before showing any notification on Android AND IOS
//   // In IOS It doesn't not only  initialize the plugin It also asks
//   // FOR NOTIFICATIONS PERMISSIONS without requestNotificationsPermission()
//   // But it is put there for abstraction
//   /// TODO : See the best fit place to call this .. Note it will ask for permission on ios and some android
//   static Future<bool> initialize() async {
//     _configureSelectedBehaviour();
//     bool? allSet;
//     if (await _requestPermission()) {
//       await _createAndroidChannelsIfNotExist();
//       allSet = await _pluginInstance.initialize(
//         InitializationSettings(
//           android: AndroidN.initSettings,
//           iOS: IOSN.initSettings,
//         ),
//         onDidReceiveBackgroundNotificationResponse: _onBackgroundNOrActionTapped,
//         onDidReceiveNotificationResponse: _onForegroundNOrActionTapped,
//       );
//       await AppBadger.initLiveUpdater();
//     }
//
//     return allSet ?? false;
//   }
//
//   static Future<NotificationAppLaunchDetails?> getFLNAppLaunchDetails() async =>
//       await _pluginInstance.getNotificationAppLaunchDetails();
//
//   static Future<int> _setLastId() async {
//     final lastStoredId = await DataStore.getValue(key: DataStoreKeys.lastNotificationId);
//     // print('lastStoredNotificationId inside setLastNotificationId();  $lastStoredNotificationId');
//
//     return lastStoredId == null
//         ? await DataStore.saveValue(key: DataStoreKeys.lastNotificationId, value: 0.toString())
//             .then((value) => 0)
//         : int.parse(lastStoredId);
//   }
//
//   static int? _lastId;
//
//   static Future<int> _incrementAndSaveLastId() async {
//     _lastId ??= await _setLastId();
//     var temp = _lastId!;
//     _lastId =
//         await DataStore.saveValue(key: DataStoreKeys.lastNotificationId, value: (++temp).toString())
//             .then((value) => temp);
//     return _lastId!;
//   }
//
//   static Future<List<ActiveNotification>> get activeList async =>
//       await _pluginInstance.getActiveNotifications();
//
//   /// General Notification with bold subtitle
//   // Note you can use <b> Title </b> To make the text bold
//   // That applies to title, and body which we named subtitle
//   static Future<void> show({
//     required String title,
//     String? subtitle,
//     String? payload,
//     bool insistent = false,
//   }) async {
//     // if (!await initialize()) {
//     //   return;
//     // }
//     final details = NotificationDetails(
//       android: AndroidN.generalDetails(),
//       iOS: IOSN.generalDetails(subtitle: subtitle), // bold on ios
//     );
//
//     final id = await _incrementAndSaveLastId();
//     final body = Platform.isAndroid ? '<b>$subtitle</b>' : null; // ios doesn't use html format in here
//
//     // print(id);
//     // print(lastNotificationId);
//     insistent
//         ? _insistentShow(
//             id: id,
//             title: title,
//             subtitle: subtitle,
//             details: details,
//             payload: payload,
//             repeatEvery: RepeatEvery.fiveSeconds,
//           )
//         : await _pluginInstance.show(
//             id,
//             title,
//             body,
//             payload: payload,
//             details,
//           );
//   }
//
//   /// Messages Notifications
//   // This function should accept a Message model that contains the sender and timestamp [to be passed to atTime]
//   // alongside some id to be passed to notification id in order to stay consistent in one notification per person
//   // TODO : LATER ON
//   // Now It is just a String
//   static Future<void> showMessaging({
//     required String senderName,
//     required List<String> messages,
//     required DateTime atTime,
//     bool insistent = false,
//   }) async {
//     // if (!await initialize()) {
//     //   return;
//     // }
//     /// TODO : Change this to something more unique
//     final id = senderName.hashCode;
//     final details = NotificationDetails(
//       android: AndroidN.messagesDetails(
//         senderName: senderName,
//         messages: messages,
//         atTime: atTime,
//       ),
//       iOS: IOSN.messagesDetails(subtitle: '$senderName:'),
//     );
//
//     final title = NTemplates.newMessagesTitle(howMany: messages.length, atTime: atTime);
//     final body = Platform.isAndroid ? messages.last : NTemplates.newMessagesSubtitle(messages: messages);
//
//     insistent
//         ? await _insistentShow(
//             id: id,
//             title: title,
//             subtitle: body,
//             details: details,
//             repeatEvery: RepeatEvery.fiveSeconds,
//           )
//         : _pluginInstance.show(
//             id,
//             title,
//             body,
//             details,
//           );
//   }
//
//   /// Booking Notifications
//   // This is typically will need timestamp, rider name, booking Id and
//   // links to actions
//   // 'Show On Map'
//   // Accept
//   // Reject
//
//   static Future<void> showBooking({
//     required String name,
//     required String destination,
//     required DateTime atTime,
//     String? payload,
//     bool insistent = false,
//     FromDriverBookingState? fromDriverBookingState,
//     FromRiderBookingState? fromRiderBookingState,
//   }) async {
//     assert(
//       fromDriverBookingState != null || fromRiderBookingState != null,
//       'either fromDriverBookingState OR fromRiderBookingState must be given',
//     );
//     final title = fromDriverBookingState != null
//         ? fromDriverBookingState.notificationTitle(name)
//         : fromRiderBookingState!.notificationTitle(name);
//     final subtitle = NTemplates.to(destination: destination);
//     final notificationDetails = NotificationDetails(
//       android: fromDriverBookingState != null
//           ? AndroidN.fromDriverBookingDetails(atTime: atTime, state: fromDriverBookingState)
//           : AndroidN.fromRiderBookingDetails(atTime: atTime, state: fromRiderBookingState!),
//       iOS: fromDriverBookingState != null
//           ? IOSN.fromDriversBookingDetails(subtitle: subtitle, state: fromDriverBookingState)
//           : IOSN.fromRidersBookingDetails(subtitle: subtitle, state: fromRiderBookingState!),
//     );
//
//     final body = Platform.isAndroid ? '<b>$subtitle</b>' : null;
//     final id = title.split(' ').first.hashCode; // TODO : change this to be unique
//     insistent
//         ? await _insistentShow(
//             id: id,
//             title: title,
//             subtitle: body,
//             details: notificationDetails,
//             payload: payload,
//             repeatEvery: RepeatEvery.fiveSeconds,
//           )
//         : await _pluginInstance.show(
//             id,
//             title,
//             body,
//             notificationDetails,
//             payload: payload,
//           );
//   }
//
//   static final Set<int> _insistentIdsSet = {};
//   static final Set<InsistentNotification> _insistentSet = {};
//
//   static Timer? _insistentPeriodicTimer;
//
//   static Future<void> _insistentShow({
//     required int id,
//     required String title,
//     required String? subtitle,
//     required NotificationDetails details,
//     String? payload,
//     required RepeatEvery repeatEvery,
//   }) async {
//     // if (!await initialize()) {
//     //   return;
//     // }
//     final insistentNotification = InsistentNotification(
//       id: id,
//       title: title,
//       subtitle: subtitle,
//       notificationDetails: details,
//       payload: payload,
//       repeatEvery: repeatEvery,
//     );
//     _insistentSet.add(insistentNotification);
//     _insistentIdsSet.add(id);
//     await insistentNotification.show();
//     await insistentNotification.zonedSchedule();
//     _activePendingWatchDog();
//   }
//
//   static void _activePendingWatchDog() {
//     /// IMPORTANT TO UNDERSTAND:
//     // This timer will be instantiated only once with the first insistent notification being shown,
//     // It will run every 4 second i.e. less than the minimum duration of [RepeatEvery] in order to
//     // cover any case and it took 1 millisecond at most so we are one second safe ... It will run
//     // as long as active notifications contain an insistent one,
//     // and on every callback it will check whether active notifications contain an insistent one,
//     // if no it will go through pending notifications and cancel any insistent one that has been
//     // scheduled to be shown again
//
//     _insistentPeriodicTimer ??= Timer.periodic(
//       /*TODO: Change this according to settings*/
//       const Duration(seconds: 4),
//       (timer) async {
//         Timeline.startSync('insistentPeriodicTimer CallBack');
//         final activeInsistentIds = (await _pluginInstance.getActiveNotifications())
//             .map((e) => _insistentIdsSet.contains(e.id) ? e.id : null)
//             .nonNulls
//             .toSet();
//         print('activeInsistentNotificationIds : $activeInsistentIds');
//         final pendingInsistentIds = (await getPendingList())
//             .map((e) => _insistentIdsSet.contains(e.id) ? e.id : null)
//             .nonNulls
//             .toSet();
//
//         print('pendingInsistentNotificationsIds : $pendingInsistentIds');
//
//         if (activeInsistentIds.isEmpty) {
//           await Future.forEach(pendingInsistentIds, (element) async => await cancelBy(id: element));
//           timer.cancel();
//           _insistentPeriodicTimer = null;
//           print('Timer Cancelled');
//         } else {
//           // REMEMBER THESE TWO RULES
//           // #1 : For every insistent notification dismissed there must NOT be a pending one
//           // #2 : For every insistent notification shown there must be a pending one
//
//           final alreadyDismissedOrTapped = _insistentIdsSet.difference(activeInsistentIds);
//
//           print('alreadyDismissedOrTapped : $alreadyDismissedOrTapped');
//
//           await Future.forEach(alreadyDismissedOrTapped, (element) async => await cancelBy(id: element));
//
//           final areToBeShownAgainIds = activeInsistentIds.difference(pendingInsistentIds);
//
//           print('areToBeShownAgainIds : $areToBeShownAgainIds');
//
//           await Future.forEach(areToBeShownAgainIds, (id) async {
//             final insistentNotification = _insistentSet.firstWhere((element) => id == element.id);
//             await insistentNotification.show();
//             await insistentNotification.zonedSchedule();
//           });
//         }
//         Timeline.finishSync();
//       },
//     );
//   }
//
//   static Future<List<PendingNotificationRequest>> getPendingList() async {
//     final pendingNotifications = await _pluginInstance.pendingNotificationRequests();
//     for (var element in pendingNotifications) {
//       /// TODO : DO WHAT EVER YOU LOGIC SPECIFY
//       /// here is what you get from [element]
//       element.id;
//       element.title;
//       element.body;
//       element.payload;
//     }
//     return pendingNotifications;
//   }
//
//   static Future<void> cancelBy({required int id}) async => await _pluginInstance.cancel(id);
//
//   static Future<void> cancelAll() async => await _pluginInstance.cancelAll();
//
//   /// Back to say : >> Isolates DO NOT Share MEMORY ... AND ALL OF THE Normal CODE is stored in memory
//   /// TODO : Try Flutter_isolate Package
//   static Future<void> showOnAnotherIsolate(
//       {required String title, required String subtitle, required bool insistent}) async {
//     await Isolate.run(() async {
//       /// FULL OF EXCEPTIONS And BUGS
//       // await initialize();
//       await FlutterLocalNotificationsPlugin().initialize(InitializationSettings(
//         android: AndroidN.initSettings,
//         iOS: IOSN.initSettings,
//       ));
//       await show(
//         title: 'title From Another Isolate',
//         subtitle: 'Subtitle From Another Isolate',
//       );
//     });
//   }
//
//   /// Could be pretty good when some rider books a driver's trip
//   /// on ios we can implement the same functionality using package
//   /// just_audio_player /// T O D O :  DONE ! check out this idea
//   /// /// TODO : Later on in settings Riders can turn this off
//   /// as we intend to set it on by default under the name
//   /// for ex : loop booking notification sound.
// // Future<void> _showInsistentNotification() async {
// //   // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
// //   //if set, the audio will be repeated until the notification is cancelled or the notification window is opened.
// //   const int insistentFlag = 4;
// //   final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
// //       'your channel id', 'your channel name',
// //       channelDescription: 'your channel description',
// //       importance: Importance.max,
// //       priority: Priority.high,
// //       ticker: 'ticker',
// //       additionalFlags: Int32List.fromList(<int>[insistentFlag]));
// //   final NotificationDetails notificationDetails =
// //   NotificationDetails(android: androidNotificationDetails);
// //   await flutterLocalNotificationsPlugin
// //       .show(id++, 'insistent title', 'insistent body', notificationDetails, payload: 'item x');
// // }
// //
//
//   /// implement this functionality and tweak this to your own liking
// //   Future<void> _repeatNotification() async {
// //     const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
// //         'repeating channel id', 'repeating channel name',
// //         channelDescription: 'repeating description');
// //     const NotificationDetails notificationDetails =
// //     NotificationDetails(android: androidNotificationDetails);
// //     await flutterLocalNotificationsPlugin.periodicallyShow(
// //       id++,
// //       'repeating title',
// //       'repeating body',
// //       RepeatInterval.everyMinute,
// //       notificationDetails,
// //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
// //     );
// //   }
// //
// }
