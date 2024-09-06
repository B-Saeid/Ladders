// part of 'android_parts.dart';
//
// abstract class AndroidN {
//   static const initSettings = AndroidInitializationSettings(_notificationIconFileName);
//
//   /// Android exactAlarmPermission request TODO :  LOOK at it LATER for Android 14 and above
// // pluginInstance.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
// //      ?.requestExactAlarmsPermission();
//
//   static AndroidNotificationDetails generalDetails() => const MyAndroidNDetails().packageClass();
//
//   static AndroidNotificationDetails messagesDetails({
//     required String senderName,
//     required List<String> messages,
//     required DateTime atTime,
//   }) =>
//       MyAndroidNDetails.messages(
//         messages: messages,
//         atTime: atTime,
//         senderName: senderName,
//       ).packageClass();
//
//   static AndroidNotificationDetails fromDriverBookingDetails({
//     required DateTime atTime,
//     required FromDriverBookingState state,
//   }) =>
//       MyAndroidNDetails.bookingFromDriver(
//         atTime: atTime,
//         fromDriverBookingState: state,
//       ).packageClass();
//
//   static AndroidNotificationDetails fromRiderBookingDetails({
//     required DateTime atTime,
//     required FromRiderBookingState state,
//   }) =>
//       MyAndroidNDetails.bookingFromRider(
//         atTime: atTime,
//         fromRiderBookingState: state,
//       ).packageClass();
// }
