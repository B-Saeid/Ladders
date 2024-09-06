// import '../Shared/Constants/global_constants.dart';
// import '../Shared/Services/Database/Persistence/data_store.dart';
//
// class Ranger {
//   final String uId; /// Uniquely Identifies the Driver
//
//   final String rangerName;
//   final bool gender;
//   final String birthDay;
//
//   final String image64String; /// Profile Image as Base64String
//
//   final String phoneNumber; /// used for Authentication & Communication
//
//   final String rangerEmail;
//   final bool isEmailVerified;
//
//   final bool official; /// false until approved by the admin
//
//   final String? password;
//   final String? sha512;
//
//   /// Upcoming Features
//   final double walletBalance;
//   final double totalEarnings;
//   final double dueMoney;
//   final String accountStatus;
//
//   Ranger({
//     required this.uId,
//     required this.rangerName,
//     required this.gender,
//     required this.rangerEmail,
//     required this.isEmailVerified,
//     required this.phoneNumber,
//     this.password,
//     this.sha512,
//     this.walletBalance = 0.0,
//     this.image64String = "",
//     this.birthDay = "null",
//     this.official = false,
//     this.totalEarnings = 0.0,
//     this.dueMoney = 0.0,
//     this.accountStatus = mActiveAccountStatus,
//   });
//
//   factory Ranger.fromJson(Map json) {
//     return Ranger(
//       uId: json[mUid],
//       rangerName: json[mDriverName],
//       gender: json[mGender],
//       rangerEmail: json[mDriverEmail],
//       isEmailVerified: json[mIsEmailVerified],
//       phoneNumber: json[mPhoneNumber],
//       sha512: json[mSha512],
//       walletBalance: double.parse(json[mWalletBalance].toString()),
//       image64String: json[mImage64String],
//       birthDay: DateTime.tryParse(json[mBirthDay]).toString(),
//       official: json[mOfficial],
//       totalEarnings: double.parse(json[mTotalEarnings].toString()),
//       dueMoney: double.parse(json[mDueMoney].toString()),
//       accountStatus: json[mAccountStatus],
//     );
//   }
//
//   Ranger.defaultInstance({
//     this.uId = mUid,
//     this.rangerName = mDriverName,
//     this.gender = true,
//     this.rangerEmail = mDriverEmail,
//     this.isEmailVerified = false,
//     this.phoneNumber = mPhoneNumber,
//     this.password,
//     this.sha512 = mSha512,
//     this.walletBalance = 0.0,
//     this.image64String = "",
//     this.birthDay = 'null',
//     this.official = false,
//     this.dueMoney = 0.0,
//     this.totalEarnings = 0.0,
//     this.accountStatus = mDeactivatedAccountStatus,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       mUid: uId,
//       mDriverName: rangerName,
//       mGender: gender,
//       mDriverEmail: rangerEmail,
//       mIsEmailVerified: isEmailVerified,
//       mPhoneNumber: phoneNumber,
//       mSha512: sha512,
//       mWalletBalance: walletBalance,
//       mImage64String: image64String,
//       mBirthDay: birthDay,
//       mOfficial: official,
//       mTotalEarnings: totalEarnings,
//       mDueMoney: dueMoney,
//       mAccountStatus: accountStatus
//     };
//   }
//
//   Future<void> permanentStore() async {
//     await DataStore.saveValue(key: mUid, value: uId);
//     await DataStore.saveValue(key: mDriverName, value: rangerName);
//     await DataStore.saveValue(key: mGender, value: gender.toString());
//     await DataStore.saveValue(key: mDriverEmail, value: rangerEmail);
//     await DataStore.saveValue(key: mIsEmailVerified, value: isEmailVerified.toString());
//     await DataStore.saveValue(key: mPhoneNumber, value: phoneNumber);
//     await DataStore.saveValue(key: mSha512, value: sha512 as String);
//     await DataStore.saveValue(key: mWalletBalance, value: walletBalance.toString());
//     await DataStore.saveValue(key: mImage64String, value: image64String.toString());
//     await DataStore.saveValue(key: mBirthDay, value: birthDay.toString());
//     await DataStore.saveValue(key: mOfficial, value: official.toString());
//     await DataStore.saveValue(key: mTotalEarnings, value: totalEarnings.toString());
//     await DataStore.saveValue(key: mDueMoney, value: dueMoney.toString());
//     await DataStore.saveValue(key: mAccountStatus, value: accountStatus.toString());
//   }
//
//   static Future<Ranger> getLocalRangerData() async {
//     final String uId = await DataStore.getValue(key: mUid).then((value) => value.toString());
//     final String rangerName = await DataStore.getValue(key: mDriverName).then((value) => value.toString());
//     final bool gender = await DataStore.getValue(key: mGender).then((value) => value == mTrue ? true : false);
//     final String rangerEmail = await DataStore.getValue(key: mDriverEmail).then((value) => value.toString());
//     final bool isEmailVerified =
//     await DataStore.getValue(key: mIsEmailVerified).then((value) => value == mTrue ? true : false);
//     final String phoneNumber = await DataStore.getValue(key: mPhoneNumber).then((value) => value.toString());
//     final String sha512 = await DataStore.getValue(key: mSha512).then((value) => value.toString());
//     final double walletBalance = double.parse(await DataStore.getValue(key: mWalletBalance) as String);
//     final String image64String = await DataStore.getValue(key: mImage64String).then((value) => value.toString());
//     final String birthDay = await DataStore.getValue(key: mBirthDay).then((value) => value.toString());
//     final bool official = await DataStore.getValue(key: mOfficial).then((value) => value == mTrue ? true : false);
//     final double totalEarnings = double.parse(await DataStore.getValue(key: mTotalEarnings) as String);
//     final double dueMoney = double.parse(await DataStore.getValue(key: mDueMoney) as String);
//     final String accountStatus = await DataStore.getValue(key: mAccountStatus).then((value) => value.toString());
//
//     return Ranger(
//       uId: uId,
//       rangerName: rangerName,
//       gender: gender,
//       rangerEmail: rangerEmail,
//       isEmailVerified: isEmailVerified,
//       phoneNumber: phoneNumber,
//       sha512: sha512,
//       walletBalance: walletBalance,
//       image64String: image64String,
//       birthDay: birthDay,
//       official: official,
//       totalEarnings: totalEarnings,
//       dueMoney: dueMoney,
//       accountStatus: accountStatus,
//     );
//   }
//
//   static Future<void> deleteLocalRangerData() async {
//     await DataStore.deleteValue(key: mUid);
//     await DataStore.deleteValue(key: mDriverName);
//     await DataStore.deleteValue(key: mGender);
//     await DataStore.deleteValue(key: mDriverEmail);
//     await DataStore.deleteValue(key: mIsEmailVerified);
//     await DataStore.deleteValue(key: mPhoneNumber);
//     await DataStore.deleteValue(key: mSha512);
//     await DataStore.deleteValue(key: mWalletBalance);
//     await DataStore.deleteValue(key: mImage64String);
//     await DataStore.deleteValue(key: mBirthDay);
//     await DataStore.deleteValue(key: mTotalEarnings);
//     await DataStore.deleteValue(key: mDueMoney);
//     await DataStore.deleteValue(key: mAccountStatus);
//   }
//
//   @override
//   String toString() {
//     // TODO: implement toString
//     return "$mUid : $uId,\n"
//         "$mDriverName : $rangerName,\n"
//         "$mDriverEmail : $rangerEmail,\n"
//         "$mIsEmailVerified : $isEmailVerified,\n"
//         "$mGender : $gender,\n"
//         "$mPhoneNumber :$phoneNumber,\n"
//         "$mSha512 : $sha512\n"
//         "$mWalletBalance : $walletBalance\n"
//         "$mImage64String : ${image64String.isNotEmpty ? "Exists" : image64String}\n"
//         "$mBirthDay : $birthDay\n"
//         "$mTotalEarnings : $totalEarnings\n"
//         "$mDueMoney : $dueMoney\n"
//         "$mAccountStatus : $accountStatus";
//   }
// }
//
// // import '../Shared/Constants/global_constants.dart';
// // import '../Shared/Persistence/data_store.dart';
// //
// // class Ranger {
// //   final String uId;
// //   final String rangerName;
// //   final bool gender;
// //   final String rangerEmail;
// //   final bool isEmailVerified;
// //   final String phoneNumber;
// //   final String? password;
// //   final String? sha512;
// //   final double walletBalance;
// //   final String image64String;
// //   final String birthDay;
// //   final bool official;
// //
// //   Ranger({
// //     required this.uId,
// //     required this.rangerName,
// //     required this.gender,
// //     required this.rangerEmail,
// //     required this.isEmailVerified,
// //     required this.phoneNumber,
// //     this.password,
// //     this.sha512,
// //     this.walletBalance = 0.0,
// //     this.image64String = "",
// //     this.birthDay = "null",
// //     required this.official,
// //   });
// //
// //   factory Ranger.fromJson(Map json) {
// //     return Ranger(
// //       uId: json[mUid],
// //       rangerName: json[mRangerName],
// //       gender: json[mGender],
// //       rangerEmail: json[mRangerEmail],
// //       isEmailVerified: json[mIsEmailVerified],
// //       phoneNumber: json[mPhoneNumber],
// //       sha512: json[mSha512],
// //       walletBalance: double.parse(json[mWalletBalance].toString()),
// //       image64String: json[mImage64String],
// //       birthDay: DateTime.tryParse(json[mBirthDay]).toString(),
// //       official: json[mOfficial]
// //     );
// //   }
// //
// //   Ranger.defaultInstance({
// //     this.uId = "uid",
// //     this.rangerName = "Your_Name",
// //     this.gender = true,
// //     this.rangerEmail = "ranger@email.com",
// //     this.isEmailVerified = false,
// //     this.phoneNumber = "Phone_Number",
// //     this.password,
// //     this.sha512 = "HASH",
// //     this.walletBalance = 0.0,
// //     this.image64String = "",
// //     this.birthDay = "null",
// //     this.official = false,
// //   });
// //
// //   Map<String, dynamic> toMap() {
// //     return {
// //       mUid: uId,
// //       mRangerName: rangerName,
// //       mGender: gender,
// //       mRangerEmail: rangerEmail,
// //       mIsEmailVerified: isEmailVerified,
// //       mPhoneNumber: phoneNumber,
// //       mSha512: sha512,
// //       mWalletBalance: walletBalance,
// //       mImage64String: image64String,
// //       mBirthDay: birthDay,
// //       mOfficial: official,
// //     };
// //   }
// //
// //   Future<void> permanentStore() async {
// //     await DataStore.saveValue(key: mUid, value: uId);
// //     await DataStore.saveValue(key: mRangerName, value: rangerName);
// //     await DataStore.saveValue(key: mGender, value: gender.toString());
// //     await DataStore.saveValue(key: mRangerEmail, value: rangerEmail);
// //     await DataStore.saveValue(key: mIsEmailVerified, value: isEmailVerified.toString());
// //     await DataStore.saveValue(key: mPhoneNumber, value: phoneNumber);
// //     await DataStore.saveValue(key: mSha512, value: sha512 as String);
// //     await DataStore.saveValue(key: mWalletBalance, value: walletBalance.toString());
// //     await DataStore.saveValue(key: mImage64String, value: image64String.toString());
// //     await DataStore.saveValue(key: mBirthDay, value: birthDay.toString());
// //     await DataStore.saveValue(key: mOfficial, value: official.toString());
// //   }
// //
// //   static Future<Ranger> getLocalRangerData() async {
// //     final String uId = await DataStore.getValue(key: mUid).then((value) => value.toString());
// //     final String rangerName = await DataStore.getValue(key: mRangerName).then((value) => value.toString());
// //     final bool gender = await DataStore.getValue(key: mGender).then((value) => value == mTrue ? true : false);
// //     final String rangerEmail = await DataStore.getValue(key: mRangerEmail).then((value) => value.toString());
// //     final bool isEmailVerified =
// //         await DataStore.getValue(key: mIsEmailVerified).then((value) => value == mTrue ? true : false);
// //     final String phoneNumber = await DataStore.getValue(key: mPhoneNumber).then((value) => value.toString());
// //     final String sha512 = await DataStore.getValue(key: mSha512).then((value) => value.toString());
// //     final double walletBalance = double.parse(await DataStore.getValue(key: mWalletBalance) as String);
// //     final String image64String = await DataStore.getValue(key: mImage64String).then((value) => value.toString());
// //     final String birthDay = await DataStore.getValue(key: mBirthDay).then((value) => value.toString());
// //     final bool official = await DataStore.getValue(key: mOfficial).then((value) => value == mTrue ? true : false);
// //
// //     return Ranger(
// //       uId: uId,
// //       rangerName: rangerName,
// //       gender: gender,
// //       rangerEmail: rangerEmail,
// //       isEmailVerified: isEmailVerified,
// //       phoneNumber: phoneNumber,
// //       sha512: sha512,
// //       walletBalance: walletBalance,
// //       image64String: image64String,
// //       birthDay: birthDay,
// //       official: official,
// //     );
// //   }
// //
// //   static Future<void> deleteLocalUserData() async {
// //     await DataStore.deleteValue(key: mUid);
// //     await DataStore.deleteValue(key: mRangerName);
// //     await DataStore.deleteValue(key: mGender);
// //     await DataStore.deleteValue(key: mRangerEmail);
// //     await DataStore.deleteValue(key: mIsEmailVerified);
// //     await DataStore.deleteValue(key: mPhoneNumber);
// //     await DataStore.deleteValue(key: mSha512);
// //     await DataStore.deleteValue(key: mWalletBalance);
// //     await DataStore.deleteValue(key: mImage64String);
// //     await DataStore.deleteValue(key: mBirthDay);
// //   }
// //
// //   @override
// //   String toString() {
// //     // TODO: implement toString
// //     return "$mUid : $uId,\n"
// //         "$mRangerName : $rangerName,\n"
// //         "$mRangerEmail : $rangerEmail,\n"
// //         "$mIsEmailVerified : $isEmailVerified,\n"
// //         "$mGender : $gender,\n"
// //         "$mPhoneNumber :$phoneNumber,\n"
// //         "$mSha512 : $sha512\n"
// //         "$mWalletBalance : $walletBalance\n"
// //         "$mImage64String : ${image64String.isNotEmpty ? "Exists" : image64String}\n"
// //         "$mBirthDay : $birthDay";
// //   }
// // }
// //
// // // class PickUpUser {
// // //   late String uId;
// // //   late String userName;
// // //   late String userPhoneNumber;
// // //   late String userEmail;
// // //   late bool isEmailVerified;
// // //   late bool isPhoneNumberVerified;
// // //   late String password;
// // //   late String sha512;
// // //
// // //   PickUpUser({
// // //
// // //     required this.uId,
// // //     required this.userName,
// // //     required this.userPhoneNumber,
// // //     required this.userEmail,
// // //     required this.isEmailVerified,
// // //     required this.isPhoneNumberVerified,
// // //     required this.password,
// // //     required this.sha512,
// // //   });
// // //
// // //   PickUpUser.fromJson(Map<String, dynamic> json) {
// // //     uId = json['uId'];
// // //     userName = json['userName'];
// // //     userPhoneNumber = json['userPhoneNumber'];
// // //     userEmail = json['userEmail'];
// // //     isEmailVerified = json['isEmailVerified'];
// // //     isPhoneNumberVerified = json['isPhoneNumberVerified'];
// // //     sha512 = json['sha512'];
// // //   }
// // //
// // //   Map<String, dynamic> toMap() {
// // //     return {
// // //       'userName': userName,
// // //       'userPhoneNumber': userPhoneNumber,
// // //       'userEmail': userEmail,
// // //       'isEmailVerified': isEmailVerified,
// // //       'sha512': sha512,
// // //       'uId':uId,
// // //     };
// // //   }
// // // }
