//
//
// import '../Shared/Constants/global_constants.dart';
// import '../Shared/Constants/session_data.dart';
// import 'nearest_points_model.dart';
// import 'rider_model.dart';
//
// class Booking {
//   final String tripId; /// Uniquely Identifies a trip
//
//   /// Booking Inner Objects
//   final PickUpUser passenger;
//   final NearestPoints nearestPoints;
//
//   final String bookingUserKey;    /// This is what stored as a foreign key to later get the user.
//   final String specialKey;        /// This is the driver (Ranger) foreign key
//
//   final String rideDistanceText;  // distance travelled on board
//   final int bookedSeats;          // number of seats needed by the passenger
//   final int rideFare;             // Distance Fare * the vehicle Fare Factor
//   final String bookedAt;          // time stamp of the booking
//
//   /// See next Slides
//   String tripState;
//   String rangerStatus;
//   String userStatus;
//
//   Booking(
//       {required this.tripId,
//         required this.passenger,
//         required this.bookingUserKey,
//         required this.specialKey,
//         required this.rideDistanceText,
//         required this.bookedSeats,
//         required this.rideFare,
//         required this.nearestPoints,
//         required this.bookedAt,
//         this.tripState = mTripStateBooked,
//         this.rangerStatus = mNotAwareRangerStatus,
//         this.userStatus = mWaitingUserStatus,});
//
//   factory Booking.fromJsonInPickUp({required Map json}) {
//     return Booking(
//       tripId: json[mTripId],
//       passenger: kModel!,
//       bookingUserKey: json[mBookingUserKey],
//       specialKey: json[mSpecialKey],
//       rideDistanceText: json[mRideDistanceText],
//       bookedSeats: json[mBookedSeats],
//       rideFare: json[mRideFare],
//       nearestPoints: NearestPoints.fromJson(json[mNearestPoints]),
//       bookedAt: json[mBookedAt],
//       tripState: json[mTripState],
//       rangerStatus: json[mRangerStatus],
//       userStatus: json[mUserStatus],
//     );
//   }
//
//   // factory Booking.fromJsonInRanger({required Map bookingJson,required Map passengerJson}) {
//   //   return Booking(
//   //     tripId: bookingJson[mTripId],
//   //     passenger: PickUpUser.fromJson(passengerJson),
//   //     bookingUserKey: bookingJson[mBookingUserKey],
//   //     specialKey: bookingJson[mSpecialKey],
//   //     rideDistanceText: bookingJson[mRideDistanceText],
//   //     bookedSeats: bookingJson[mBookedSeats],
//   //     rideFare: bookingJson[mRideFare],
//   //     nearestPoints: NearestPoints.fromJson(bookingJson[mNearestPoints]),
//   //     bookedAt: bookingJson[mBookedAt],
//   //     tripState: bookingJson[mTripState],
//   //     rangerStatus: bookingJson[mRangerStatus],
//   //     userStatus: bookingJson[mUserStatus],
//   //   );
//   // }
//
//
//   Map<String, dynamic> toMap() {
//     return {
//       mTripId: tripId,
//       mBookingUserKey: bookingUserKey,
//       mSpecialKey: specialKey,
//       mRideDistanceText: rideDistanceText,
//       mBookedSeats: bookedSeats,
//       mRideFare: rideFare,
//       mNearestPoints: nearestPoints.toMap(),
//       mBookedAt: bookedAt,
//       mTripState: tripState,
//       mRangerStatus: rangerStatus,
//       mUserStatus: userStatus,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'tripId : $tripId\n'
//         'passenger : ${passenger.toString()}\n'
//         'bookingUserKey : $bookingUserKey\n'
//         'specialKey : $specialKey\n'
//         'rideDistanceText : $rideDistanceText\n'
//         'bookedSeats : $bookedSeats\n'
//         'rideFare : $rideFare\n'
//         'nearestPoints : ${nearestPoints.toString()}\n'
//         'bookedAt : $bookedAt\n'
//         'tripState : $tripState\n'
//         'rangerStatus : $rangerStatus\n'
//         'userStatus : $userStatus';
//   }
// }
