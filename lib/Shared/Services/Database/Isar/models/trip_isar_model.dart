// import 'package:pick_up/Models/booking_model.dart';
//
// import '../Shared/Constants/global_constants.dart';
// import 'driver_model.dart';
// import 'route_model.dart';
// import 'vehicle_model.dart';
//
// class Trip {
//   final String tripId; /// Uniquely Identifies the Trip
//
//   /// Trip inner Objects
//   final Ranger ranger;        /// Not Stored in every trip in the database
//   final Vehicle vehicle;      /// Not Stored in every trip in the database
//   final RouteDetails routeDetails;
//
//   /// ranger identifying Key - USED TO GET THE RANGER AND THE VEHICLE
//   final String specialKey;
//   final String appointment;   /// When will the ranger start the trip (time stamp)
//   int availableSeats;         /// Cannot be < vehicle max seats but not greater.
//   String tripState;           /// See Booking Slides
//
//   List<Booking?>? bookings;   /// List of Users Bookings Objects
//
//   Trip({
//     required this.tripId,
//     required this.ranger,
//     required this.vehicle,
//     required this.routeDetails,
//     required this.specialKey,
//     required this.appointment,
//     required this.availableSeats,
//     this.bookings,
//     required this.tripState,
//   });
//
//   factory Trip.fromJsonInPickUp({required Map tripJson, required Map rangerJson, required Map vehicleJson}) {
//     List<Booking?>? bookings;
//     Map? allBookingsMap = tripJson[mBookings];
//     if (allBookingsMap != null) {
//       bookings = [];
//       allBookingsMap.forEach((key, value) {
//         if (![mCancelledUserStatus, mDeletedUserStatus, mHistoryUserStatus].contains(value[mUserStatus])) {
//           bookings!.add(Booking.fromJsonInPickUp(json: value));
//         }
//       });
//     }
//
//     return Trip(
//       tripId: tripJson[mTripId],
//       ranger: Ranger.fromJson(rangerJson),
//       vehicle: Vehicle.fromJson(vehicleJson),
//       routeDetails: RouteDetails.rangerTripFromJson(tripJson[mRouteDetails]),
//       specialKey: tripJson[mSpecialKey],
//       appointment: tripJson[mAppointment],
//       availableSeats: tripJson[mAvailableSeats],
//       bookings: bookings,
//       tripState: tripJson[mTripState],
//     );
//   }
//
//   // factory Trip.fromJsonInRanger({required Map tripJson, required Map allPassengersJson}) {
//   //   List<Booking?>? bookings;
//   //   Map? allBookingsMap = tripJson[mBookings];
//   //   if (allBookingsMap != null) {
//   //     bookings = [];
//   //     allBookingsMap.forEach((key, value) {
//   //       Map bookingJson = value;
//   //       String passengerUserKey = bookingJson[mBookingUserKey];
//   //       bookings!.add(Booking.fromJsonInRanger(
//   //           bookingJson: bookingJson, passengerJson: allPassengersJson[passengerUserKey]));
//   //     });
//   //   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       mTripId: tripId,
//
//       /// As Vehicles and Rangers are stored separately we use the specialKey
//       /// as a foreign key to retrieve both Ranger and Vehicle objects of the Trip
//       mSpecialKey: specialKey,
//
//       mRouteDetails: routeDetails.toMap(),
//       mAppointment: appointment,
//       mAvailableSeats: availableSeats,
//       mTripState: tripState
//     };
//   }
//
//   @override
//   String toString() {
//     return "$mTripId : $tripId\n"
//         "$mRanger : ${ranger.toString()},\n"
//         "$mVehicle : ${vehicle.toString()},\n"
//         "$mRouteDetails : ${routeDetails.toString()},\n"
//         "$mSpecialKey : $specialKey\n"
//         "$mAppointment : $appointment,\n"
//         "$mAvailableSeats : $availableSeats\n"
//         "$mBookings : $bookings\n"
//         "$mTripState : $tripState";
//   }
// }
