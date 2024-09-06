// part of 'android_parts.dart';
//
// const _notificationIconFileName = 'ic_onzroad_notification_icon';
//
// abstract class AndroidNSound {
//   /// TODO : Change most of these sounds to remove Ambiguity
//   /// Driver Mode
//   static const pendingBooking = 'positive_booking_ns';
//   static const cancelledBooking = 'negative_booking_ns';
//
//   /// Rider Mode
//   static const acceptedBooking = 'positive_booking_ns';
//   static const rejectedBooking = 'negative_booking_ns';
//   static const tripCancelled = 'negative_booking_ns';
//   static const tripArranged = 'trip_arranged_ns';
//
//   /// Common
//   static const standard = 'standard_ns';
//   static const important = 'standard_ns'; // TODO : change this Specifically
//   static const newMessage = 'new_message_ns';
// }
//
// abstract class AndroidNGroupKeys {
//   static const general = 'General_NG';
//
//   static const messages = 'Messages_NG';
//
//   static const bookingsFromDrivers = 'BookingsFromDrivers_NG';
//   static const bookingsFromRiders = 'BookingsFromRiders_NG';
//
//   static const fcm = 'FCM_NG';
// }
//
// class _BookingsFromDrivers {
//   _BookingsFromDrivers._();
//
//   static _BookingsFromDrivers get instance => _BookingsFromDrivers._();
//
//   factory _BookingsFromDrivers() => instance;
//
//   final id = 'bookingsFromDriversNCG';
//   final name = 'Rider Related Bookings';
//   final description = 'This group controls bookings notifications received from drivers';
// }
//
// class _BookingsFromRiders {
//   _BookingsFromRiders._();
//
//   static _BookingsFromRiders get instance => _BookingsFromRiders._();
//
//   factory _BookingsFromRiders() => instance;
//
//   final id = 'bookingsFromRidersNCG';
//   final name = 'Driver Related Bookings';
//   final description = 'This group controls bookings notifications received from riders';
// }
//
// abstract class AndroidNChannelGroups {
//   static final bookingsFromDrivers = _BookingsFromDrivers();
//   static final bookingsFromRiders = _BookingsFromRiders();
// }
