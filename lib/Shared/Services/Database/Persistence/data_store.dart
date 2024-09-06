// import 'dart:async';
//
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// export 'data_store_keys.dart';
//
// /// This class is versatile and can be used in any project that needs to store encrypted key-value pairs
// abstract class DataStore {
//   // DataStore._privateConstructor() {}
//
//   // static final DataStore _sharedInstance = DataStore._privateConstructor();
//
//   // factory DataStore() => _sharedInstance;
//
//   static late final FlutterSecureStorage _storage;
//
//   static late final StreamController<Map<String, String>> _securedDataStreamController;
//
//   static Map<String, String> _allValues = {};
//
//   static Map<String, String> get allValues => _allValues;
//
//   static bool _initialized = false;
//
//   // Initialize
//   static void _initialize() {
//     AndroidOptions getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);
//     IOSOptions getIOSOptions() => const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
//     _storage = FlutterSecureStorage(aOptions: getAndroidOptions(), iOptions: getIOSOptions());
//     _securedDataStreamController =
//         StreamController.broadcast(onListen: () => _securedDataStreamController.add(_allValues));
//     _initialized = true;
//   }
//
//   static void _ensureInitialized() => _initialized ? null : _initialize();
//
//   // Write value
//   static Future<void> saveValue({required String key, required String value}) async {
//     _ensureInitialized();
//     if (_allValues[key] == value) {
//       return;
//     } else {
//       await _storage.write(key: key, value: value);
//     }
//     await _updateCache();
//   }
//
//   // Read value
//   static Future<String?> getValue({required String key}) async {
//     _ensureInitialized();
//     return _allValues[key] ?? await _storage.read(key: key);
//   }
//
//   // Read all values
//   static Future<Map<String, String>> getAllValues() async {
//     _ensureInitialized();
//     return await _storage.readAll();
//   }
//
//   // Delete value
//   static Future<bool> deleteValue({required String key}) async {
//     _ensureInitialized();
//     final value = await getValue(key: key);
//     if (value == null) {
//       return false;
//     } else {
//       await _storage.delete(key: key);
//       await _updateCache();
//       return true;
//     }
//   }
//
//   // Delete all values
//   static Future<void> deleteAllValues() async {
//     _ensureInitialized();
//     await _storage.deleteAll();
//     await _updateCache();
//   }
//
//   // Updating cached values and add its state to the stream controller
//   static Future<void> _updateCache() async {
//     _allValues = await getAllValues();
//     _securedDataStreamController.add(_allValues);
//   }
//
//   /// Todo : Should be called when app is closed or terminated
//   static Future<void> shutdown() async {
//     _ensureInitialized();
//     await _securedDataStreamController.close();
//   }
// }
