// part of 'ios_parts.dart';
//
// abstract class IOSN {
//   static Future<void> onIOS10MinusForegroundN(
//     int id,
//     String? title,
//     String? body,
//     String? payload,
//   ) async {
//     print('onIOS10MinusForegroundNotification called');
//
//     /// In here we are supposed to use in-app-notifications plugins
//   }
//
//   static final initSettings = DarwinInitializationSettings(
//     requestCriticalPermission: true,
//     onDidReceiveLocalNotification: onIOS10MinusForegroundN,
//     notificationCategories: IOSNCategory.values.map((e) => e.packageCategory).toList(),
//   );
//
//   static DarwinNotificationDetails generalDetails({String? subtitle}) => DarwinNotificationDetails(
//         // attachments: [DarwinNotificationAttachment("filePath",identifier: "IDD")],
//         categoryIdentifier: IOSNCategory.general.name,
//         interruptionLevel: IOSNCategory.general.interruptionLevel,
//         sound: IOSNSound.standard,
//         threadIdentifier: IOSNCategory.general.name,
//         subtitle: subtitle,
//       );
//
//   static DarwinNotificationDetails messagesDetails({String? subtitle}) => DarwinNotificationDetails(
//         // attachments: [DarwinNotificationAttachment("filePath",identifier: "IDD")],
//         categoryIdentifier: IOSNCategory.messages.name,
//         interruptionLevel: IOSNCategory.messages.interruptionLevel,
//         sound: IOSNCategory.messages.soundFileName,
//         threadIdentifier: IOSNCategory.messages.name,
//         subtitle: subtitle,
//       );
//
//   static DarwinNotificationDetails fromDriversBookingDetails({
//     String? subtitle,
//     required FromDriverBookingState state,
//   }) =>
//       DarwinNotificationDetails(
//         // attachments: [DarwinNotificationAttachment("filePath",identifier: "IDD")],
//         categoryIdentifier: state.iosNCategory.name,
//         interruptionLevel: state.iosNCategory.interruptionLevel,
//         sound: state.iosNCategory.soundFileName,
//         threadIdentifier: state.iosNCategory.name,
//         subtitle: subtitle,
//       );
//
//   static DarwinNotificationDetails fromRidersBookingDetails({
//     String? subtitle,
//     required FromRiderBookingState state,
//   }) =>
//       DarwinNotificationDetails(
//         // attachments: [DarwinNotificationAttachment("filePath",identifier: "IDD")],
//         categoryIdentifier: state.iosNCategory.name,
//         interruptionLevel: state.iosNCategory.interruptionLevel,
//         sound: state.iosNCategory.soundFileName,
//         threadIdentifier: state.iosNCategory.name,
//         subtitle: subtitle,
//       );
// }
//
// // DarwinNotificationCategory(
// //   'The only Category',
// //   actions: <DarwinNotificationAction>[
// //     DarwinNotificationAction.text(
// //       'canTypeTextActionID',
// //       'TITLE..destructive',
// //       buttonTitle: 'Send >>>',
// //       placeholder: 'Type Any thing',
// //       options: <DarwinNotificationActionOption>{DarwinNotificationActionOption.authenticationRequired},
// //     ),
// //     DarwinNotificationAction.plain(
// //       'id_1',
// //       'Action 1...foreground',
// //       options: <DarwinNotificationActionOption>{DarwinNotificationActionOption.foreground},
// //     ),
// //     DarwinNotificationAction.plain(
// //       'noOptionsSpecifiedForThisActionId',
// //       'I think It will only dismiss the notification',
// //     ),
// //     DarwinNotificationAction.plain(
// //       'id_2',
// //       'Title...destructive',
// //       options: <DarwinNotificationActionOption>{DarwinNotificationActionOption.destructive},
// //     ),
// //   ],
// //   options: <DarwinNotificationCategoryOption>{
// //     DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
// //     DarwinNotificationCategoryOption.customDismissAction
// //
// //     /// TODO: SUPER SUPER IMPORTANT to be taken into consideration
// //     /// Todo: You should have a notification category for live mode and set the [allowInCarPlay] option in it
// //     /// So that you achieve something really deep that will be a merit to your app.
// //     ///
// //     /// Allow CarPlay to display notifications of this type.
// //     ///
// //     /// Corresponds to [`UNNotificationCategoryOptions.allowInCarPlay`](https://developer.apple.com/documentation/usernotifications/unnotificationcategoryoptions/1649281-allowincarplay).
// //     // DarwinNotificationCategoryOption.allowInCarPlay,
// //   },
// // )
