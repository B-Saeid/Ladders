// import '../Shared/Constants/global_constants.dart';
// import '../Shared/Services/Database/Persistence/data_store.dart';
//
// class Vehicle {
//
//   final int maxSeats;   /// How many seats in the vehicle - driver excluded.
//
//   final String vehicleFrontImage64String;
//   final String vehicleRearImage64String;
//   final String licenseFrontImage64String;
//   final String licenseRearImage64String;
//
//   /// These properties are extracted by the admin from the uploaded vehicle images
//   final String plateString;            /// e.g. أ ب ت 1234
//   final String vehicleType;           /// Car, Motorcycle or Others
//   final String vehicleMake;          /// Toyota Corolla
//   final int vehicleModel;           /// year of made e.g. 2020
//   final String vehicleHexColor;    /// 0xFF155000
//
//   /// This is reflects how luxurious the vehicle is and is multiplied by the ride fare.
//   final double fareFactor;  /// takes a value in [1-2] i.e. 2 would be for a classy vehicle.
//
//   Vehicle(
//       {required this.plateString,
//       required this.vehicleType,
//       required this.vehicleFrontImage64String,
//       required this.vehicleRearImage64String,
//       required this.licenseFrontImage64String,
//       required this.licenseRearImage64String,
//       required this.vehicleMake,
//       required this.vehicleModel,
//       required this.maxSeats,
//       required this.vehicleHexColor,
//       required this.fareFactor});
//
//   factory Vehicle.fromJson(Map json) {
//     return Vehicle(
//       plateString: json[mPlateString],
//       vehicleType: json[mVehicleType],
//       vehicleFrontImage64String: json[mVehicleFrontImage64String][mVehicleFrontImage64String],
//       vehicleRearImage64String: json[mVehicleRearImage64String][mVehicleRearImage64String],
//       licenseFrontImage64String: json[mLicenseFrontImage64String][mLicenseFrontImage64String],
//       licenseRearImage64String: json[mVehicleRearImage64String][mVehicleRearImage64String],
//       vehicleMake: json[mVehicleMake],
//       vehicleModel: json[mVehicleModel],
//       maxSeats: json[mMaxSeats],
//       vehicleHexColor: json[mVehicleHexColor],
//       fareFactor: double.parse(json[mFareFactor].toString()),
//     );
//   }
//
//   Vehicle.defaultInstance({
//     this.plateString = 'beep 123',
//     this.vehicleType = 'Car',
//     this.vehicleFrontImage64String = '',
//     this.vehicleRearImage64String = '',
//     this.licenseFrontImage64String = '',
//     this.licenseRearImage64String = '',
//     this.vehicleMake = 'Civic',
//     this.vehicleModel = 2000,
//     this.maxSeats = 3,
//     this.vehicleHexColor = '155000',
//     this.fareFactor = 1.0,
//   });
//
//   Map<String, Object> toMap() {
//     return {
//       mPlateString: plateString,
//       mVehicleType: vehicleType,
//       mVehicleFrontImage64String: {mVehicleFrontImage64String: vehicleFrontImage64String},
//       mVehicleRearImage64String: {mVehicleRearImage64String: vehicleRearImage64String},
//       mLicenseFrontImage64String: {mLicenseFrontImage64String: licenseFrontImage64String},
//       mLicenseRearImage64String: {mLicenseRearImage64String: licenseRearImage64String},
//       mVehicleMake: vehicleMake,
//       mVehicleModel: vehicleModel,
//       mMaxSeats: maxSeats,
//       mVehicleHexColor: vehicleHexColor,
//       mFareFactor: fareFactor,
//     };
//   }
//
//   Future<void> permanentStore() async {
//     await DataStore.saveValue(key: mPlateString, value: plateString);
//     await DataStore.saveValue(key: mVehicleType, value: vehicleType);
//     await DataStore.saveValue(key: mVehicleFrontImage64String, value: vehicleFrontImage64String);
//     await DataStore.saveValue(key: mVehicleRearImage64String, value: vehicleRearImage64String);
//     await DataStore.saveValue(key: mLicenseFrontImage64String, value: licenseFrontImage64String);
//     await DataStore.saveValue(key: mLicenseRearImage64String, value: licenseRearImage64String);
//     await DataStore.saveValue(key: mVehicleMake, value: vehicleMake);
//     await DataStore.saveValue(key: mVehicleModel, value: vehicleModel.toString());
//     await DataStore.saveValue(key: mMaxSeats, value: maxSeats.toString());
//     await DataStore.saveValue(key: mVehicleHexColor, value: vehicleHexColor.toString());
//     await DataStore.saveValue(key: mFareFactor, value: fareFactor.toString());
//   }
//
//   static Future<Vehicle> getLocalVehicleData() async {
//     final String plateString = await DataStore.getValue(key: mPlateString).then((value) => value.toString());
//     final String vehicleType = await DataStore.getValue(key: mVehicleType).then((value) => value.toString());
//     final String vehicleFrontImage64String =
//         await DataStore.getValue(key: mVehicleFrontImage64String).then((value) => value.toString());
//     final String vehicleRearImage64String =
//         await DataStore.getValue(key: mVehicleRearImage64String).then((value) => value.toString());
//     final String licenseFrontImage64String =
//         await DataStore.getValue(key: mLicenseFrontImage64String).then((value) => value.toString());
//     final String licenseRearImage64String =
//         await DataStore.getValue(key: mLicenseRearImage64String).then((value) => value.toString());
//     final String vehicleMake = await DataStore.getValue(key: mVehicleMake).then((value) => value.toString());
//     final int vehicleModel = int.parse(await DataStore.getValue(key: mVehicleModel) as String);
//     final int maxSeats = int.parse(await DataStore.getValue(key: mMaxSeats) as String);
//     final String vehicleHexColor = await DataStore.getValue(key: mVehicleHexColor).then((value) => value.toString());
//     final double fareFactor = double.parse(await DataStore.getValue(key: mFareFactor) as String);
//
//     return Vehicle(
//       plateString: plateString,
//       vehicleType: vehicleType,
//       vehicleFrontImage64String: vehicleFrontImage64String,
//       vehicleRearImage64String: vehicleRearImage64String,
//       licenseFrontImage64String: licenseFrontImage64String,
//       licenseRearImage64String: licenseRearImage64String,
//       vehicleMake: vehicleMake,
//       vehicleModel: vehicleModel,
//       maxSeats: maxSeats,
//       vehicleHexColor: vehicleHexColor,
//       fareFactor: fareFactor,
//     );
//   }
//
//   static Future<void> deleteLocalVehicleData() async {
//     await DataStore.deleteValue(key: mPlateString);
//     await DataStore.deleteValue(key: mVehicleType);
//     await DataStore.deleteValue(key: mGender);
//     await DataStore.deleteValue(key: mVehicleRearImage64String);
//     await DataStore.deleteValue(key: mLicenseFrontImage64String);
//     await DataStore.deleteValue(key: mLicenseRearImage64String);
//     await DataStore.deleteValue(key: mVehicleMake);
//     await DataStore.deleteValue(key: mVehicleModel);
//     await DataStore.deleteValue(key: mMaxSeats);
//     await DataStore.deleteValue(key: mVehicleHexColor);
//     await DataStore.deleteValue(key: mFareFactor);
//   }
//
//   @override
//   String toString() {
//     return "$mPlateString : $plateString,\n"
//         "$mVehicleType : $vehicleType,\n"
//         "$mVehicleFrontImage64String : ${vehicleFrontImage64String.isNotEmpty ? "Exists" : vehicleFrontImage64String},\n"
//         "$mVehicleRearImage64String : ${vehicleRearImage64String.isNotEmpty ? "Exists" : vehicleRearImage64String},\n"
//         "$mLicenseFrontImage64String : ${licenseFrontImage64String.isNotEmpty ? "Exists" : licenseFrontImage64String},\n"
//         "$mLicenseRearImage64String :${licenseRearImage64String.isNotEmpty ? "Exists" : licenseRearImage64String},\n"
//         "$mVehicleMake : $vehicleMake\n"
//         "$mVehicleModel : $vehicleModel\n"
//         "$mMaxSeats : $maxSeats\n"
//         "$mVehicleHexColor : $vehicleHexColor}\n"
//         "$mFareFactor : $fareFactor";
//   }
// }
