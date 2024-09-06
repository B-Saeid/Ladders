// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../Shared/Constants/global_constants.dart';
//
// class NearestPoints {
//
//   final String tripId; /// Uniquely Identifies the Trip
//
//   /// The desired positions of the User
//   final LatLng origPickLatLng;
//   final LatLng origDestinationLatLng;
//
//   /// The nearest point at which the ranger will pick the user up
//   final LatLng meetingLatLng;
//   final double meetingValueKm;
//
//   /// The nearest point at which the ranger will drop the user off
//   final LatLng dropOffLatLng;
//   final double dropOffValueKm;
//
//   /// Both points are calculated after looping through the LatLng points - See Trip Slides
//
//
//
//
//
//   NearestPoints({
//     required this.tripId,
//     required this.origPickLatLng,
//     required this.meetingLatLng,
//     required this.meetingValueKm,
//     required this.origDestinationLatLng,
//     required this.dropOffLatLng,
//     required this.dropOffValueKm,
//   });
//
//   factory NearestPoints.fromJson(Map json) {
//     return NearestPoints(
//       tripId: json[mTripId],
//       origPickLatLng: LatLng.fromJson(json[mOrigPickUpLatLng])!,
//       meetingLatLng: LatLng.fromJson(json[mMeetingLatLng])!,
//       meetingValueKm: json[mMeetingValueKm],
//       origDestinationLatLng: LatLng.fromJson(json[mOrigDestinationLatLng])!,
//       dropOffLatLng: LatLng.fromJson(json[mDropOffLatLng])!,
//       dropOffValueKm: json[mDropOffValueKm],
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       mTripId: tripId,
//       mOrigPickUpLatLng: origPickLatLng.toJson(),
//       mMeetingLatLng: meetingLatLng.toJson(),
//       mMeetingValueKm: meetingValueKm,
//       mOrigDestinationLatLng: origDestinationLatLng.toJson(),
//       mDropOffLatLng: dropOffLatLng.toJson(),
//       mDropOffValueKm: dropOffValueKm,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'tripId : $tripId\n'
//         'origPickLatLng :$origPickLatLng\n'
//         'meetingLatLng : $meetingLatLng\n'
//         'meetingValueKm : $meetingValueKm\n'
//         'origDestinationLatLng : $origDestinationLatLng\n'
//         'dropOffLatLng : $dropOffLatLng\n'
//         'dropOffValueKm : $dropOffValueKm';
//   }
// }
