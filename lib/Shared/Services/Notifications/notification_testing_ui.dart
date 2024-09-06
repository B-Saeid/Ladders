// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../Widgets/text_container.dart';
// import '../Database/Hive/hive_service.dart';
// import '../Time/time_service.dart';
// import 'assets/common_parts.dart';
// import 'assets/launcher_icon_count_badge.dart';
// import 'notification_service.dart';
//
// class TestingNotification extends StatefulWidget {
//   const TestingNotification({super.key});
//
//   @override
//   State<TestingNotification> createState() => _TestingNotificationState();
// }
//
// class _TestingNotificationState extends State<TestingNotification> {
//   bool notificationsIsInitialized = false;
//   List<String> messages = [
//     'I was Busy',
//     'Please leave a message next time long text long text long text long text',
//   ];
//   bool? isAppBadgerSupported;
//
//   bool scheduledPermission = false;
//   bool isAndroidApi34Above = (HiveService.androidInfo?.sdkVersion ?? 0) >= 34;
//
//   bool get api34CheckPermission => isAndroidApi34Above ? scheduledPermission : true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: const Text('Notification TESTING'),
//         actions: [
//           TextContainer(
//             onTap: () => context.pushNamed('fcm'),
//             child: const Text('FCM Page'),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     final temp = await NotificationService.initialize();
//                     setState(() => notificationsIsInitialized = temp);
//                   },
//                   child: const Text('Initialize Notification'),
//                 ),
//                 Chip(label: Text('On: $notificationsIsInitialized')),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async => await NotificationService.show(
//                     title: 'New Message',
//                     subtitle: 'Ahmed: Hello World',
//                   ),
//                   child: const Text('Notification'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await NotificationService.showMessaging(
//                       messages: messages,
//                       senderName: 'Hassan',
//                       atTime: TimeService.online.now ?? DateTime.now(),
//                     );
//                   },
//                   child: const Text('Messaging Notification'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async => setState(() => messages.add('Hi')),
//                   child: const Text('Add Hi TO Messages'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async => await NotificationService.cancelBy(id: 'Hassan'.hashCode),
//                   child: const Text('Cancel Messaging Notification'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final temp = await AppBadger.checkIfSupportedOnDevice();
//                     setState(() => isAppBadgerSupported = temp);
//                   },
//                   child: const Text('Check If App Badge is supported On Device'),
//                 ),
//                 Chip(label: Text('App Badger Supported: $isAppBadgerSupported')),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async => await NotificationService.showBooking(
//                     name: 'Ahmed',
//                     destination: 'Cairo',
//                     fromDriverBookingState: FromDriverBookingState.accepted,
//                     atTime: TimeService.online.now ?? DateTime.now(),
//                   ),
//                   child: const Text('Driver Accepting Booking'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async => await NotificationService.showBooking(
//                     name: 'Ahmed',
//                     destination: 'Alexandria',
//                     fromDriverBookingState: FromDriverBookingState.rejected,
//                     atTime: TimeService.online.now ?? DateTime.now(),
//                   ),
//                   child: const Text('Driver Rejecting Booking'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async => await NotificationService.showBooking(
//                     name: 'Ahmed',
//                     destination: 'Alexandria',
//                     fromDriverBookingState: FromDriverBookingState.wholeTripCancelled,
//                     atTime: TimeService.online.now ?? DateTime.now(),
//                   ),
//                   child: const Text('Driver Cancelling Whole Trip Bookings'),
//                 ),
//                 const SizedBox(height: 25),
//
//                 ElevatedButton(
//                   onPressed: () async => await NotificationService.showBooking(
//                     name: 'Samy',
//                     destination: 'Alexandria',
//                     fromRiderBookingState: FromRiderBookingState.pending,
//                     atTime: DateTime.now(),
//                   ),
//                   child: const Text('Show Booking Of A passenger'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async => await NotificationService.showBooking(
//                     name: 'Samy',
//                     destination: 'Alexandria',
//                     fromRiderBookingState: FromRiderBookingState.cancelled,
//                     atTime: DateTime.now(),
//                   ),
//                   child: const Text('Show Passenger Cancelling Booking'),
//                 ),
//                 const SizedBox(height: 25),
//
//                 /// INSISTENT NOTIFICATION
//                 const Divider(),
//                 const Chip(label: Text('Insistent Notifications')),
//                 const SizedBox(height: 25),
//                 if (isAndroidApi34Above) ...[
//                   ElevatedButton(
//                     onPressed: () async {
//                       final temp = await NotificationService.requestExactAlarmsPermission();
//                       setState(() => scheduledPermission = temp);
//                     },
//
//                     /// TODO : If  isAndroidApi34Above
//                     /// Should Tell the user this before enabling insistent notification:
//                     /// This feature requires the app to utilize exact alarms
//                     /// and schedule time-sensitive actions. This lets the app run in the background,
//                     /// which may use more battery.
//                     /// THIS IS SAID ON SCHEDULING EXACT ALARMS screen on the device settings
//                     child: const Text(
//                       '(API 34+)\nRequest Schedule Exact Alarm\n(More battery usage)',
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   TextContainer(child: Text('(API 34+) Scheduled Permission: $scheduledPermission')),
//                   const SizedBox(height: 25),
//                 ],
//                 ElevatedButton(
//                   onPressed: !api34CheckPermission
//                       ? null
//                       : () async => await NotificationService.show(
//                             title: 'New Insistent Message',
//                             subtitle: 'Insistent Ahmed: Hello World',
//                             insistent: true,
//                           ),
//                   child: const Text('Insistent Notification'),
//                 ),
//
//                 const SizedBox(height: 25),
//
//                 ElevatedButton(
//                   onPressed: !api34CheckPermission
//                       ? null
//                       : () async {
//                           await NotificationService.showMessaging(
//                             senderName: 'Ahmed',
//                             messages: messages.followedBy(['Insistent Message']).toList(),
//                             insistent: true,
//                             atTime: TimeService.online.now ?? DateTime.now(),
//                           );
//                         },
//                   child: const Text('Insistent Messaging Notification'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async => setState(() => messages.add('Hi')),
//                   child: const Text('Add Hi TO Messages'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () async => await NotificationService.cancelBy(id: 'Ahmed'.hashCode),
//                   child: const Text('Cancel Insistent Messaging Notification'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: !api34CheckPermission
//                       ? null
//                       : () async => await NotificationService.showBooking(
//                             name: 'Ahmed',
//                             destination: 'Cairo',
//                             fromDriverBookingState: FromDriverBookingState.accepted,
//                             insistent: true,
//                             atTime: TimeService.online.now ?? DateTime.now(),
//                           ),
//                   child: const Text('Insistent Driver Accepting Booking'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: !api34CheckPermission
//                       ? null
//                       : () async => await NotificationService.showBooking(
//                             name: 'Ahmed',
//                             destination: 'Alexandria',
//                             insistent: true,
//                             fromDriverBookingState: FromDriverBookingState.rejected,
//                             atTime: TimeService.online.now ?? DateTime.now(),
//                           ),
//                   child: const Text('Insistent Driver Rejecting Booking'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: !api34CheckPermission
//                       ? null
//                       : () async => await NotificationService.showBooking(
//                             name: 'Ahmed',
//                             destination: 'Alexandria',
//                             fromDriverBookingState: FromDriverBookingState.wholeTripCancelled,
//                             insistent: true,
//                             atTime: TimeService.online.now ?? DateTime.now(),
//                           ),
//                   child: const Text('Insistent Driver Cancelling Whole Trip Bookings'),
//                 ),
//                 const SizedBox(height: 25),
//
//                 ElevatedButton(
//                   onPressed: !api34CheckPermission
//                       ? null
//                       : () async => await NotificationService.showBooking(
//                             name: 'Samy',
//                             destination: 'Alexandria',
//                             insistent: true,
//                             fromRiderBookingState: FromRiderBookingState.pending,
//                             atTime: DateTime.now(),
//                           ),
//                   child: const Text('Show Insistent Booking Of A passenger'),
//                 ),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: !api34CheckPermission
//                       ? null
//                       : () async => await NotificationService.showBooking(
//                             name: 'Samy',
//                             destination: 'Alexandria',
//                             insistent: true,
//                             fromRiderBookingState: FromRiderBookingState.cancelled,
//                             atTime: DateTime.now(),
//                           ),
//                   child: const Text('Show Insistent Passenger Cancelling Booking'),
//                 ),
//                 ElevatedButton(
//                   onPressed: !api34CheckPermission
//                       ? null
//                       : () async => Future.delayed(
//                             const Duration(seconds: 5),
//                             () async => await NotificationService.show(
//                               title: 'Delayed 5 SECONDS',
//                               subtitle: 'Ha-poo!',
//                               insistent: true,
//                             ),
//                           ),
//                   child: const Text('Insistent Notification After 4 Seconds'),
//                 ),
//                 const SizedBox(height: 40),
//
//                 /// Showing Notification On Another Isolate
//                 const Divider(),
//                 const Chip(label: Text('Another Isolate Notifications')),
//                 const SizedBox(height: 25),
//                 const ElevatedButton(
//                   onPressed:
//                       null /*() async => await NotificationService.showOnAnotherIsolate(
//                     title: 'New Insistent Message',
//                     subtitle: 'Insistent Ahmed: Hello World',
//                     insistent: true,
//                   )*/
//                   ,
//                   child: Text('Another Isolate Notification'),
//                 ),
//                 const SizedBox(height: 25),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
