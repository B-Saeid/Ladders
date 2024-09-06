// part of 'common_parts.dart';
//
// class InsistentNotification {
//   final int id;
//   final String title;
//   final String? subtitle;
//   final NotificationDetails notificationDetails;
//   final String? payload;
//   final RepeatEvery repeatEvery;
//
//   InsistentNotification({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//     required this.notificationDetails,
//     required this.payload,
//     required this.repeatEvery,
//   });
//
//   Future<void> show() async => await FlutterLocalNotificationsPlugin().show(
//         id,
//         title,
//         subtitle,
//         notificationDetails,
//         payload: payload,
//       );
//
//   Future<void> zonedSchedule() async {
//     await FlutterLocalNotificationsPlugin().zonedSchedule(
//       id,
//       title,
//       subtitle,
//       tz.TZDateTime.now(tz.UTC).add(repeatEvery.duration),
//       notificationDetails,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       payload: payload,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
//
//   @override
//   String toString() {
//     return 'id: $id\n'
//         'title: $title\n'
//         'subtitle: $subtitle\n'
//         'notificationDetails: $notificationDetails\n'
//         'payload: $payload\n'
//         'repeatEvery: $repeatEvery';
//   }
// }
