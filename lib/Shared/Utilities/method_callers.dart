/// May be Later ... it does not work
// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// import '../Extensions/time_package.dart';
//
// abstract class MethodCaller {
//   static var _retryFallBack = 0;
//   static const _retryIncrement = 2;
//
//   static Future<bool> tryThis(VoidCallback methodCallback) async {
//     try {
//       methodCallback();
//       return true;
//     } catch (error, stackTrace) {
//       print('Error occurred in tryThis call ${error.toString()} with stackTrace $stackTrace');
//       return false;
//     }
//   }
//
//   static Future<bool> retryOnHandshake(VoidCallback methodCallback, {int retryAttempts = 1}) async {
//     try {
//       methodCallback();
//       return true;
//     } on HandshakeException catch (e, s) {
//       print('HandshakeException Occurred in $s');
//
//       if (_retryFallBack < _retryIncrement * retryAttempts) {
//         _retryFallBack += _retryIncrement;
//         print('retrying after a $_retryFallBack s ....... ');
//         await _retryFallBack.seconds.delay;
//         return retryOnHandshake(methodCallback, retryAttempts: retryAttempts);
//       }
//       print('retrying is OVER and _retryFallBack = $_retryFallBack s');
//       return false;
//     } catch (error, stackTrace) {
//       print('Error occurred in tryThis call ${error.toString()} with stackTrace $stackTrace');
//       return false;
//     }
//   }
// }
