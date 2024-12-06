import 'package:flutter/material.dart';

import '../../../../../Shared/Extensions/on_context.dart';
import '../../../../../Shared/Services/Database/Hive/boxes_keys/dialogues_shown_keys.dart';
import '../../../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../../../Shared/Services/Permission/permissions_service.dart';
import '../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../../Settings/Sections/all_tiles.dart';
import '../speech_service.dart';

abstract class PermissionsHelper {
  static final _isMacOS = StaticData.platform.isMacOS;
  static final _isAndroid = StaticData.platform.isAndroid;

  static Future<bool> microphoneCheck(BuildContext context) async {
    /// Since macOS is not supported yet by PermissionHandler package
    /// and speech recognition package only checks speech permission effectively.
    ///
    /// Though it requests microphone permission in [initialize] BUT IT runs either it is granted or not
    /// SO we manually check if the user has already granted the microphone permission
    /// using the record package which supports macOS

    final bool microphoneOK;
    if (_isMacOS) {
      microphoneOK = await _macOSCraftedMicPermission(context);
    } else {
      microphoneOK = await PermissionsService.routine(
        context: context,
        permission: MyPermission.microphone,
      );
    }
    return microphoneOK;
  }

  static Future<bool> _macOSCraftedMicPermission(BuildContext context) async {
    final bool microphoneOK;
    final shownBefore = HiveService.storedCache.get(DialoguesKeys.macOSCraftedMicrophone);
    final recorder = context.read(recorderProvider);

    /// This if block is executed in two cases :
    ///   - in the app first run after
    ///     - installation
    ///     - database is cleared
    if (shownBefore == null) {
      microphoneOK = await PermissionsService.showPreRequestDialogue(
        context,
        MyPermission.microphone,
        requestMethod: recorder.hasPermission,
      );
      await HiveService.storedCache.put(DialoguesKeys.macOSCraftedMicrophone, true);
    } else {
      microphoneOK = await recorder.hasPermission();
    }

    /// Display the go to setting dialogue if microphone is denied
    ///
    /// Note: we are on macOS i.e. when the permission is denied once
    /// the system doesn't show the dialogue again .. the user has to go to settings
    if (!microphoneOK && context.mounted) {
      PermissionsService.showGoToSetting(
        context,
        MyPermission.microphone,
      );
    }

    return microphoneOK;
  }

  static Future<bool> speechCheck(BuildContext context) async {
    final bool speechOK;
    if (_isMacOS) {
      speechOK = true; // handled in initialize
    } else {
      speechOK = await PermissionsService.routine(
        context: context,
        permission: MyPermission.speech,
      );
    }

    return speechOK;
  }

  static Future<bool> check(BuildContext context) async {
    SpeechService.logEvent('PermissionCheck');

    /// ON ANDROID - we experienced that speech is permanently denied
    /// when microphone permission is not granted
    ///
    /// so we start with checking microphone permission
    if (_isAndroid) {
      final microphoneOK = await microphoneCheck(context);
      print('AFTER microphoneOK context.mounted ${context.mounted}');
      if (!microphoneOK || !context.mounted) return false;

      final speechOK = await speechCheck(context);
      return speechOK;
    } else {
      /// TODO : Write down why you use this order in other than Android
      final speechOK = await speechCheck(context);
      print('AFTER speechOK context.mounted ${context.mounted}');
      if (!speechOK || !context.mounted) return false;

      final microphoneOK = await microphoneCheck(context);
      return microphoneOK;
    }
  }
}
