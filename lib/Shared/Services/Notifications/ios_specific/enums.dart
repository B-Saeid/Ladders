// part of 'ios_parts.dart';
//
// enum IOSNCategory {
//   /// Common
//   general,
//   // in iOS no silent notification as far as know for now that is silent
//   // except for provisional and we are not implementing it at the moment
//   // gentle,
//   messages,
//   important,
//
//   /// Driver Mode
//   acceptedBookings,
//   rejectedBookings,
//   cancelledTrips,
//   arrangedTrips,
//
//   /// Rider Mode
//   pendingBookings,
//   cancelledBookings;
//
//   InterruptionLevel get interruptionLevel => switch (this) {
//         IOSNCategory.general => InterruptionLevel.active,
//         _ => InterruptionLevel.critical,
//         // Just note later on when u use "timeSensitive" is not good for the request it needs "time-sensitive"
//       };
//
//   // double get priorityForSorting => switch (this) {
//   //       IOSNCategory.general => 0.5,
//   //       IOSNCategory.messages => 0.8,
//   //       IOSNCategory.important => 1.0,
//   //       IOSNCategory.acceptedBookings => 0.9,
//   //       IOSNCategory.rejectedBookings => 0.7,
//   //       IOSNCategory.cancelledTrips => 1.0,
//   //       IOSNCategory.arrangedTrips => 0.9,
//   //       IOSNCategory.pendingBookings => 1.0,
//   //       IOSNCategory.cancelledBookings => 0.7,
//   //     };
//
//   List<DarwinNotificationAction> get actions => switch (this) {
//         IOSNCategory.messages => [
//             DarwinNotificationAction.plain(
//               NActions.markAsReadId,
//               NActions.markAsReadTitle,
//               options: {DarwinNotificationActionOption.authenticationRequired},
//             ),
//
//             /// Super Detail_y lovely line __ SWEET
//             if (HiveService.userVolt.get(Vehicle.mVehicles) != null) ...[
//               /// i.e if user is a driver >> include these actions in a messages notification
//               DarwinNotificationAction.plain(
//                 NActions.fiveMinETAId,
//                 NActions.fiveMinETATitle,
//                 options: {DarwinNotificationActionOption.authenticationRequired},
//               ),
//               DarwinNotificationAction.plain(
//                 NActions.tenToFifteenMinETAId,
//                 NActions.tenToFifteenMinETATitle,
//                 options: {DarwinNotificationActionOption.authenticationRequired},
//               ),
//             ]
//           ],
//         IOSNCategory.pendingBookings => [
//             /// Show on map
//             DarwinNotificationAction.plain(
//               NActions.showBookingOnMapId,
//               NActions.showBookingOnMapTitle,
//               options: {
//                 DarwinNotificationActionOption.authenticationRequired,
//                 DarwinNotificationActionOption.foreground,
//               },
//             ),
//
//             /// Accept
//             DarwinNotificationAction.plain(
//               NActions.acceptBookingId,
//               NActions.acceptBookingTitle,
//               options: {DarwinNotificationActionOption.authenticationRequired},
//             ),
//
//             /// Reject
//             DarwinNotificationAction.plain(
//               NActions.rejectBookingId,
//               NActions.rejectBookingTitle,
//               options: {
//                 DarwinNotificationActionOption.authenticationRequired,
//                 DarwinNotificationActionOption.destructive,
//               },
//             ),
//           ],
//         IOSNCategory.cancelledBookings => [
//             /// Dismiss
//             DarwinNotificationAction.plain(
//               NActions.dismissBookingId,
//               NActions.dismissBookingTitle,
//             ),
//           ],
//         _ => [],
//       };
//
//   Set<DarwinNotificationCategoryOption> get options => switch (this) {
//         IOSNCategory.general => {},
//         IOSNCategory.messages => {
//             DarwinNotificationCategoryOption.allowInCarPlay,
//             DarwinNotificationCategoryOption.allowAnnouncement,
//             DarwinNotificationCategoryOption.customDismissAction,
//           },
//         _ => {
//             DarwinNotificationCategoryOption.allowInCarPlay,
//             DarwinNotificationCategoryOption.allowAnnouncement,
//           },
//       };
//
//   String get soundFileName => switch (this) {
//         IOSNCategory.general => IOSNSound.standard,
//         IOSNCategory.messages => IOSNSound.newMessage,
//         IOSNCategory.important => IOSNSound.important,
//         IOSNCategory.acceptedBookings => IOSNSound.acceptedBooking,
//         IOSNCategory.rejectedBookings => IOSNSound.rejectedBooking,
//         IOSNCategory.cancelledTrips => IOSNSound.tripCancelled,
//         IOSNCategory.arrangedTrips => IOSNSound.tripArranged,
//         IOSNCategory.pendingBookings => IOSNSound.pendingBooking,
//         IOSNCategory.cancelledBookings => IOSNSound.cancelledBooking,
//       };
//
//   DarwinNotificationCategory get packageCategory => DarwinNotificationCategory(
//         name,
//         actions: actions,
//         options: options,
//       );
//
//   // String get camelCasedName => name.upperFirstLetter();
// }
