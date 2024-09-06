// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../Shared/Constants/global_constants.dart';
//
// class RouteDetails {
//   final String durationText;
//   final int durationMinutes;
//   final String distanceText;
//   final int distanceMeters;
//   final String encodedPoints;
//   final LatLng pickUpLatLng;
//   final LatLng destinationLatLng;
//   List<LatLng> pointsLatLngList;
//   String readablePickUpLocation;
//   String readableDestinationLocation;
//
//   RouteDetails(
//       {required this.durationText,
//       required this.durationMinutes,
//       required this.distanceText,
//       required this.distanceMeters,
//       required this.encodedPoints,
//       required this.pickUpLatLng,
//       required this.destinationLatLng,
//       this.pointsLatLngList = const [],
//       this.readablePickUpLocation = '',
//       this.readableDestinationLocation = ''});
//
//   RouteDetails.defaultInstance(
//       {this.durationText = '0 min',
//       this.durationMinutes = 0,
//       this.distanceText = '0.0 km',
//       this.distanceMeters = 0,
//       this.encodedPoints = '',
//       this.pickUpLatLng = const LatLng(0.0, 0.0),
//       this.destinationLatLng = const LatLng(0.0, 0.0),
//       this.pointsLatLngList = const [],
//       this.readablePickUpLocation = '',
//       this.readableDestinationLocation = ''});
//
//   Map<String, dynamic> toMap() {
//     return {
//       mDurationText: durationText,
//       mDurationMinutes: durationMinutes,
//       mDistanceText: distanceText,
//       mDistanceMeters: distanceMeters,
//       mEncodedPoints: encodedPoints,
//       mPickUpLatLng: pickUpLatLng.toJson(),
//       mDestinationLatLng: destinationLatLng.toJson(),
//       // mPickUpLatLng: {mPickUpLatitude: pickUpLatLng.latitude, mPickUpLongitude: pickUpLatLng.longitude},
//       // mDestinationLatLng: {mDestinationLatitude: destinationLatLng.latitude, mDestinationLongitude: destinationLatLng.longitude},
//       mPointsLatLngList: pointsLatLngList.map((e) => e.toJson()).toList(),
//       mReadablePickUpLocation: readablePickUpLocation,
//       mReadableDestinationLocation: readableDestinationLocation
//     };
//   }
//
//   factory RouteDetails.fromJson(Map json) {
//     return RouteDetails(
//       durationText: json[mDurationText],
//       durationMinutes: json[mDurationMinutes],
//       distanceText: json[mDistanceText],
//       distanceMeters: json[mDistanceMeters],
//       encodedPoints: json[mEncodedPoints],
//       pickUpLatLng: LatLng.fromJson(json[mPickUpLatLng])!,
//       destinationLatLng: LatLng.fromJson(json[mDestinationLatLng])!,
//       // pickUpLatLng: LatLng(json[mPickUpLatLng][mPickUpLatitude], json[mPickUpLatLng][mPickUpLongitude]),
//       // destinationLatLng: LatLng(json[mEndLatLng][mEndLatitude], json[mEndLatLng][mEndLongitude]),
//       pointsLatLngList: pointsLatLngListFromJson(json[mPointsLatLngList]),
//       readablePickUpLocation: json[mReadablePickUpLocation],
//       readableDestinationLocation: json[mReadableDestinationLocation],
//     );
//   }
//
//   factory RouteDetails.rangerTripFromJson(Map json) {
//       return RouteDetails(
//         durationText: json[mDurationText],
//         durationMinutes: json[mDurationMinutes],
//         distanceText: json[mDistanceText],
//         distanceMeters: json[mDistanceMeters],
//         encodedPoints: json[mEncodedPoints],
//         pickUpLatLng: LatLng.fromJson(json[mStartLatLng])!,
//         destinationLatLng: LatLng.fromJson(json[mEndLatLng])!,
//         // startLatLng: LatLng(json[mStartLatLng][mStartLatitude], json[mStartLatLng][mStartLongitude]),
//         // endLatLng: LatLng(json[mEndLatLng][mEndLatitude], json[mEndLatLng][mEndLongitude]),
//         pointsLatLngList: pointsLatLngListFromJson(json),
//         readablePickUpLocation: json[mReadableStartLocation],
//         readableDestinationLocation: json[mReadableEndLocation],
//       );
//   }
//
//   static List<LatLng> pointsLatLngListFromJson(Map json) {
//     List latLngListFromDatabase = json[mPointsLatLngList];
//     List<LatLng> temp = [];
//     temp.add(LatLng.fromJson(json[mStartLatLng])!);
//     for (var latLngJson in latLngListFromDatabase){
//       temp.add(LatLng.fromJson(latLngJson)!);
//     }
//     temp.add(LatLng.fromJson(json[mEndLatLng])!);
//     return temp;
//   }
//
//   @override
//   String toString() {
//     return "$mDurationText : $durationText,\n"
//         "$mDurationMinutes : $durationMinutes,\n"
//         "$mDistanceText : $distanceText,\n"
//         "$mDistanceMeters : $distanceMeters,\n"
//         "$mEncodedPoints : $encodedPoints,\n"
//         "$mPickUpLatLng :$pickUpLatLng,\n"
//         "$mDestinationLatLng : $destinationLatLng\n"
//         "$mPointsLatLngList : $pointsLatLngList\n"
//         "$mReadablePickUpLocation : $readablePickUpLocation\n"
//         "$mReadableDestinationLocation : $readableDestinationLocation";
//   }
// }
