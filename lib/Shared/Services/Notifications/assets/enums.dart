// part of 'common_parts.dart';
//
// enum RepeatEvery {
//   fiveSeconds,
//   tenSeconds,
//   fifteenSeconds,
//   thirtySeconds,
//   minute,
//   twoMinutes,
//   fiveMinutes;
//
//   /// TODO : Are to be added to a list of duration in notification Settings like so
//   /// TODO : SHOULD BE under advanced section in notification settings
//   /// Repeat Notification Every:  (dropdown) menu
//   /// Readable Strings of RepeatEvery Enum
//   String get readableString => switch (this) {
//         RepeatEvery.fiveSeconds => L10nR.fiveSeconds,
//         RepeatEvery.tenSeconds => L10nR.tenSeconds,
//         RepeatEvery.fifteenSeconds => L10nR.fifteenSeconds,
//         RepeatEvery.thirtySeconds => L10nR.thirtySeconds,
//         RepeatEvery.minute => L10nR.minute,
//         RepeatEvery.twoMinutes => L10nR.twoMinutes,
//         RepeatEvery.fiveMinutes => L10nR.fiveMinutes,
//       };
//
//   Duration get duration {
//     switch (this) {
//       case RepeatEvery.fiveSeconds:
//         return 5.seconds;
//       case RepeatEvery.tenSeconds:
//         return const Duration(seconds: 10);
//       case RepeatEvery.fifteenSeconds:
//         return const Duration(seconds: 15);
//       case RepeatEvery.thirtySeconds:
//         return const Duration(seconds: 30);
//       case RepeatEvery.minute:
//         return const Duration(minutes: 1);
//       case RepeatEvery.twoMinutes:
//         return const Duration(minutes: 2);
//       case RepeatEvery.fiveMinutes:
//         return const Duration(minutes: 5);
//     }
//   }
// }
//
// enum FromDriverBookingState {
//   accepted,
//   rejected,
//   wholeTripCancelled;
//
//   IOSNCategory get iosNCategory => switch (this) {
//         FromDriverBookingState.accepted => IOSNCategory.acceptedBookings,
//         FromDriverBookingState.rejected => IOSNCategory.rejectedBookings,
//         FromDriverBookingState.wholeTripCancelled => IOSNCategory.cancelledTrips,
//       };
//
//   AndroidNChannel get androidNChannel => switch (this) {
//         FromDriverBookingState.accepted => AndroidNChannel.acceptedBookings,
//         FromDriverBookingState.rejected => AndroidNChannel.rejectedBookings,
//         FromDriverBookingState.wholeTripCancelled => AndroidNChannel.cancelledTrips,
//       };
//
//   String notificationTitle(String driverName) => switch (this) {
//         FromDriverBookingState.accepted => '$driverName accepted your booking',
//         FromDriverBookingState.rejected => '$driverName rejected your booking',
//         FromDriverBookingState.wholeTripCancelled => '$driverName has cancelled the trip',
//       };
// }
//
// enum FromRiderBookingState {
//   pending,
//   cancelled;
//
//   IOSNCategory get iosNCategory => switch (this) {
//         FromRiderBookingState.pending => IOSNCategory.pendingBookings,
//         FromRiderBookingState.cancelled => IOSNCategory.cancelledBookings,
//       };
//
//   AndroidNChannel get androidNChannel => switch (this) {
//         FromRiderBookingState.pending => AndroidNChannel.pendingBookings,
//         FromRiderBookingState.cancelled => AndroidNChannel.cancelledBookings,
//       };
//
//   String notificationTitle(String riderName) => switch (this) {
//         FromRiderBookingState.pending => '$riderName: New Pending Booking',
//         FromRiderBookingState.cancelled => '$riderName has cancelled the booking',
//       };
// }
