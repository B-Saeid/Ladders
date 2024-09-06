//
// import '../Shared/Constants/global_constants.dart';
// import '../Shared/Services/Database/Persistence/data_store.dart';
//
// class PickUpUser {
//   final String uId; /// Uniquely Identifies the User
//
//   final String userName;
//   final bool gender;
//   final String birthDay;
//
//   final String image64String; /// Profile Image as Base64String
//
//   final String phoneNumber; /// used for Authentication & Communication
//
//   final String userEmail;
//   final bool isEmailVerified;
//
//
//
//   final String? password;
//   final String? sha512;
//
//
//   final double walletBalance;
//
//   PickUpUser({
//     required this.uId,
//     required this.userName,
//     required this.gender,
//     required this.userEmail,
//     required this.isEmailVerified,
//     required this.phoneNumber,
//     this.password,
//     this.sha512,
//     this.walletBalance = 0.0,
//     this.image64String = "",
//     this.birthDay = "null",
//   });
//
//   factory PickUpUser.fromJson(Map json) {
//     return PickUpUser(
//       uId: json[mUid],
//       userName: json[mUserName],
//       gender: json[mGender],
//       userEmail: json[mUserEmail],
//       isEmailVerified: json[mIsEmailVerified],
//       phoneNumber: json[mPhoneNumber],
//       sha512: json[mSha512],
//       walletBalance: double.parse(json[mWalletBalance].toString()),
//       image64String: json[mImage64String],
//       birthDay: DateTime.tryParse(json[mBirthDay]).toString(),
//     );
//   }
//
//   PickUpUser.defaultInstance({
//     this.uId = "uid",
//     this.userName = "Your_Name",
//     this.gender = true,
//     this.userEmail = "user@email.com",
//     this.isEmailVerified = false,
//     this.phoneNumber = "Phone_Number",
//     this.password,
//     this.sha512 = "HASH",
//     this.walletBalance = 0.0,
//     this.image64String = "",
//     this.birthDay = "null",
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       mUid: uId,
//       mUserName: userName,
//       mGender: gender,
//       mUserEmail: userEmail,
//       mIsEmailVerified: isEmailVerified,
//       mPhoneNumber: phoneNumber,
//       mSha512: sha512,
//       mWalletBalance: walletBalance,
//       mImage64String: image64String,
//       mBirthDay: birthDay,
//     };
//   }
//
//   Future<void> permanentStore() async {
//     await DataStore.saveValue(key: mUid, value: uId);
//     await DataStore.saveValue(key: mUserName, value: userName);
//     await DataStore.saveValue(key: mGender, value: gender.toString());
//     await DataStore.saveValue(key: mUserEmail, value: userEmail);
//     await DataStore.saveValue(key: mIsEmailVerified, value: isEmailVerified.toString());
//     await DataStore.saveValue(key: mPhoneNumber, value: phoneNumber);
//     await DataStore.saveValue(key: mSha512, value: sha512 as String);
//     await DataStore.saveValue(key: mWalletBalance, value: walletBalance.toString());
//     await DataStore.saveValue(key: mImage64String, value: image64String.toString());
//     await DataStore.saveValue(key: mBirthDay, value: birthDay.toString());
//   }
//
//   static Future<PickUpUser> getLocalUserData() async {
//     final String uId = await DataStore.getValue(key: mUid).then((value) => value.toString());
//     final String userName = await DataStore.getValue(key: mUserName).then((value) => value.toString());
//     final bool gender = await DataStore.getValue(key: mGender).then((value) => value ==  mTrue? true : false);
//     final String userEmail = await DataStore.getValue(key: mUserEmail).then((value) => value.toString());
//     final bool isEmailVerified =
//         await DataStore.getValue(key: mIsEmailVerified).then((value) => value == mTrue ? true : false);
//     final String phoneNumber = await DataStore.getValue(key: mPhoneNumber).then((value) => value.toString());
//     final String sha512 = await DataStore.getValue(key: mSha512).then((value) => value.toString());
//     final double walletBalance = double.parse(await DataStore.getValue(key: mWalletBalance) as String);
//     final String image64String = await DataStore.getValue(key: mImage64String).then((value) => value.toString());
//     final String birthDay = await DataStore.getValue(key: mBirthDay).then((value) => value.toString());
//
//     return PickUpUser(
//       uId: uId,
//       userName: userName,
//       gender: gender,
//       userEmail: userEmail,
//       isEmailVerified: isEmailVerified,
//       phoneNumber: phoneNumber,
//       sha512: sha512,
//       walletBalance: walletBalance,
//       image64String: image64String,
//       birthDay: birthDay,
//     );
//   }
//
//   static Future<void> deleteLocalUserData() async {
//     await DataStore.deleteValue(key: mUid);
//     await DataStore.deleteValue(key: mUserName);
//     await DataStore.deleteValue(key: mGender);
//     await DataStore.deleteValue(key: mUserEmail);
//     await DataStore.deleteValue(key: mIsEmailVerified);
//     await DataStore.deleteValue(key: mPhoneNumber);
//     await DataStore.deleteValue(key: mSha512);
//     await DataStore.deleteValue(key: mWalletBalance);
//     await DataStore.deleteValue(key: mImage64String);
//     await DataStore.deleteValue(key: mBirthDay);
//   }
//
//   @override
//   String toString() {
//     // TODO: implement toString
//     return "$mUid : $uId,\n"
//         "$mUserName : $userName,\n"
//         "$mUserEmail : $userEmail,\n"
//         "$mIsEmailVerified : $isEmailVerified,\n"
//         "$mGender : $gender,\n"
//         "$mPhoneNumber :$phoneNumber,\n"
//         "$mSha512 : $sha512\n"
//         "$mWalletBalance : $walletBalance\n"
//         "$mImage64String : ${image64String.isNotEmpty ? "Exists" : image64String}\n"
//         "$mBirthDay : $birthDay";
//   }
// }
//
// // class PickUpUser {
// //   late String uId;
// //   late String userName;
// //   late String userPhoneNumber;
// //   late String userEmail;
// //   late bool isEmailVerified;
// //   late bool isPhoneNumberVerified;
// //   late String password;
// //   late String sha512;
// //
// //   PickUpUser({
// //
// //     required this.uId,
// //     required this.userName,
// //     required this.userPhoneNumber,
// //     required this.userEmail,
// //     required this.isEmailVerified,
// //     required this.isPhoneNumberVerified,
// //     required this.password,
// //     required this.sha512,
// //   });
// //
// //   PickUpUser.fromJson(Map<String, dynamic> json) {
// //     uId = json['uId'];
// //     userName = json['userName'];
// //     userPhoneNumber = json['userPhoneNumber'];
// //     userEmail = json['userEmail'];
// //     isEmailVerified = json['isEmailVerified'];
// //     isPhoneNumberVerified = json['isPhoneNumberVerified'];
// //     sha512 = json['sha512'];
// //   }
// //
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'userName': userName,
// //       'userPhoneNumber': userPhoneNumber,
// //       'userEmail': userEmail,
// //       'isEmailVerified': isEmailVerified,
// //       'sha512': sha512,
// //       'uId':uId,
// //     };
// //   }
// // }
