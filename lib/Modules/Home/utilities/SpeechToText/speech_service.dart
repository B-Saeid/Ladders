import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../Shared/Components/Toast/toast.dart';
import '../../../../Shared/Constants/assets_strings.dart';
import '../../../../Shared/Extensions/on_context.dart';
import '../../../../Shared/Extensions/time_package.dart';
import '../../../../Shared/Services/Database/Hive/boxes_keys/dialogues_shown_keys.dart';
import '../../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../../Shared/Services/Routing/routes_base.dart';
import '../../../../Shared/Services/l10n/assets/enums.dart';
import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Settings/Provider/setting_provider.dart';
import '../../../Settings/Sections/Voice Actions/trigger_sensitivity/tile.dart';
import '../../provider/home_provider.dart';
import '../TextToSpeech/tts_service.dart';
import '../dialogues.dart';
import '../enums.dart';
import 'helpers/permissions.dart';

part 'parts/errors.dart';
part 'parts/methods.dart';
part 'parts/recorder.dart';
part 'parts/sfx_player.dart';

abstract class SpeechService {
  static final isSupported = !(StaticData.platform.isWindows || StaticData.platform.isWeb);
  static final SpeechToText _speech = SpeechToText();

  static void logEvent(String eventDescription) {
    final eventTime = DateTime.now().toIso8601String();
    print('$eventTime $eventDescription');
  }

  static Future<bool?> initialize(BuildContext context) async {
    logEvent('Initialize');

    try {
      if (!await PermissionsHelper.check(context)) {
        print('context.mounted ${context.mounted}');
        if (context.mounted) context.read(settingProvider).setSpeechAvailable(false);
        return null;
      }

      print('-- context.mounted ${context.mounted}');
      final hasSpeech = await _speech.initialize(
        onError: _errorListener,
        onStatus: _statusListener,
        debugLogging: true,
      );

      print('hasSpeech = $hasSpeech');
      // _speech.initialize(
      //   onError: _errorListener,
      //   onStatus: _statusListener,
      //   debugLogging: true,
      // );

      if (hasSpeech) {
        await TTSService.init();
        final ok = await RoutesBase.activeContext!.read(settingProvider).updateInputDevices(
              disposeSession: false,
            );
        if (!ok) return false;
      }

      if (context.mounted) context.read(settingProvider).setSpeechAvailable(hasSpeech);
      return hasSpeech;
    } catch (e) {
      logEvent('ERROR CAUGHT WHILE INITIALIZE Speech: ${e.toString()}');
      _Methods._androidSpeechGoogleMicRequired();
      if (context.mounted) context.read(settingProvider).setSpeechAvailable(false);
      return false;
    }
  }

  static Future<void> actOnLocaleChange() async {
    /// TODO : Check if speech is available on the new locale
    final current = RoutesBase.activeContext!.read(settingProvider).localeSettings.locale!;
    print('actOnLocaleChange');
    print('current = $current');
    final localeID = SupportedLocale.fromLocale(current).speechID;
    print('localeID = $localeID');
    final locales = await _speech.locales();
    final list = locales.map((e) => '${e.name}, ${e.localeId}');
    print('locales = $list');

    TTSService.init();
  }

  static String get getLocaleID {
    // Get the list of languages installed on the supporting platform so they
    // can be displayed in the UI for selection by the user.
    // _localeNames = await _speech.locales();
    // final localeNames = await _speech.locales();
    //
    // _speech.systemLocale().then(
    //       (value) => print(
    //         'systemLocale (name) = ${value?.name}, (localeId) = ${value?.localeId}',
    //       ),
    //     );
    //

    print('========== IN getLocaleID');
    // final currentTTSLocale = RoutesBase.activeContext!.read(settingProvider).ttsLocale;
    final current = RoutesBase.activeContext!.read(settingProvider).localeSettings.locale!;
    final localeID = /*currentTTSLocale?.speechID ?? */ SupportedLocale.fromLocale(current).speechID;
    print('localeID = $localeID');

    // _currentLocaleId = '${currentLocaleSetting.languageCode}-${currentLocaleSetting.countryCode}';
    // _currentLocaleId = systemLocale?.localeId ?? '';

    return localeID;
  }

  static bool _canStartSpeech = true;

  static Future<void> startSpeech() async {
    if (!_canStartSpeech) {
      print('====================== ignoring startSpeech =========================');
      return;
    }
    _canStartSpeech = false;
    _canDisposed = false;
    RoutesBase.activeContext!.read(homeProvider).setLoading(true);

    final ok = await initialize(RoutesBase.activeContext!);

    if (ok ?? false) {
      // compute(_listen, _currentLocaleId); // Unhandled Exception: Instance of 'SpeechToTextNotInitializedException'
      // flutterCompute(_listen, _currentLocaleId); // Dead Response
      await _listen(); // Experienced stuttering on iOS
    } else {
      _canDisposed = true;
      _canStartSpeech = true;
      RoutesBase.activeContext!.read(homeProvider).setLoading(false);
      if (ok == false) Dialogues.showSpeechNotAvailable(RoutesBase.activeContext!);
    }
  }

  static Future<void> startMonitoring() async {
    RoutesBase.activeContext!.read(homeProvider).setLoading(true);

    final ok = await RoutesBase.activeContext!.read(settingProvider).updateInputDevices(
          disposeSession: false,
        );
    if (ok) {
      final started = await _Recorder._start();
      if (started) {
        await _SfxPlayer.started();
      } else {
        await _SfxPlayer.negative();
        Toast.showError(L10nR.tToastDefaultError());
        _Recorder._canStart = true;
        RoutesBase.activeContext!.read(homeProvider).setLoading(false);
      }
    } else {
      RoutesBase.activeContext!.read(homeProvider).setLoading(false);
      await PermissionsHelper.microphoneCheck(RoutesBase.activeContext!);
    }
  }

  static Future<void> _listen() async {
    logEvent('start listening');
    // final pauseFor = int.tryParse(_pauseForController.text);
    // final listenFor = int.tryParse(_listenForController.text);
    final options = SpeechListenOptions(
      // onDevice: true,
      listenMode: ListenMode.confirmation,
      cancelOnError: true,
      partialResults: true,
      // autoPunctuation: true,
      enableHapticFeedback: true,
    );
    // Note that `listenFor` is the maximum, not the minimum, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    await _speech.listen(
      onResult: _resultListener,
      listenFor: const Duration(seconds: /*listenFor ??*/ 6),
      pauseFor: const Duration(seconds: /*pauseFor ??*/ 3),
      // localeId: id,
      localeId: getLocaleID,
      // onSoundLevelChange: _soundLevelListener,
      listenOptions: options,
    );
  }

  static bool _disposed = false;

  static Future<void> _statusListener(String status) async {
    logEvent('Received listener status: $status, listening: ${_speech.isListening}');
    final state = SpeechState.from(status);
    print('state = $state');
    _canDisposed = !(state?.availableOrListening ?? false);
    print('sat _canDisposedSpeech to be = $_canDisposed');
    if (_speech.isListening) {
      _Methods._dismissHandler = null;
      _Methods._gotIt = false;
      if (!_isTTS) _talkIncludesTTS = false;
      _disposed = false;
      await _Recorder._dispose();
      _Recorder._canStart = true;
      print(' ====================== sat _canStartRecorder to TRUE =========================');
      await _SfxPlayer.started();
      RoutesBase.activeContext!.read(homeProvider).setRecognizing(true);
    } else {
      // if (!(state?.doneOrNotListening ?? false)) return;
      if (!_disposed && (state?.isNotListening ?? false)) {
        RoutesBase.activeContext!.read(homeProvider).setLoading(true);
      }
      // _canReportStatus = false;
      // RoutesBase.activeContext!.read(homeProvider).setLoading(true);

      // print('====================== in else ======================');
      // //  await 500.milliseconds.delay;
      // // print('====================== in else delay ======================');
      // await _startRecorder();

      // // await 500.milliseconds.delay;
      // // RoutesBase.activeContext!.read(homeProvider).setRecognizing(false);
      // // // _gotIt ? await cancel() : await stop();
      // // await RecorderHelper.start();
      //
      // RoutesBase.activeContext!.read(homeProvider).setLoading(false);
      // _canReportStatus = true;
      // print(' ====================== sat _canReportStatus to true =========================');
    }
  }

  static bool setCanStartSpeech() {
    if (_disposed) {
      print('======= _disposed = $_disposed ==== ignoring setCanStart =======');
      return false;
    }
    _canStartSpeech = true;
    print(' ====================== sat _canStartSpeech to true =========================');
    return true;
  }

  static final ValueNotifier<bool> isTTSNotifier = ValueNotifier(false);

  static bool get _isTTS => isTTSNotifier.value;

  static void flagTTS(bool value) {
    // if (!_canDisposed) return false;
    isTTSNotifier.value = value;
    if (value) _talkIncludesTTS = true;
    print('=============== flagTTS = $value -------------------');
    // return true;
  }

  static void resetTTS() {
    isTTSNotifier.value = false;
    _talkIncludesTTS = false;
  }

  static bool _talkIncludesTTS = false;

  static Future<void> _resultListener(SpeechRecognitionResult result) async {
    logEvent('Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    if (_talkIncludesTTS) {
      print('====================== in if _talkIncludesTTS ======================');
      if (result.finalResult) {
        if (!_Methods._gotIt) {
          Toast.showWarning(L10nR.tNoSpeechDetected());

          await stop();
          await _Methods._startRecorder();
        }
        _talkIncludesTTS = false;
      }
    } else {
      await _Methods._handlePotentialAction(result.recognizedWords, result.finalResult);
    }
  }

  static Future<void> _errorListener(SpeechRecognitionError error) async {
    logEvent('Received error status: $error, listening: ${_speech.isListening}');
    if (_disposed) return print('======== _disposed = true ======= _ignoring _errorListener ====');

    switch (error.errorMsg) {
      case _Errors.errorNoMatch:
        Toast.showWarning(L10nR.tNoSpeechDetected());

        /// This is added since on iOS we encountered a message:
        /// 'Speech Deactivation Failed' that caused dead amplitude
        /// and it is not reported by [_errorListener]
        /// so to avoid dead amplitude we add a delay here.
        // if (StaticData.platform.isIOS) {
        //   RoutesBase.activeContext!.read(homeProvider).setLoading(true);
        //   await 0.5.seconds.delay;
        // }
        await stop();
        await _Methods._startRecorder();

      /// encountered on android 6 when Google app does not have permission
      case _Errors.errorPermission:
        await dispose();
        if (!_Methods._androidSpeechGoogleMicRequired()) Dialogues.showSpeechNotAvailable();

      /// ALSO encountered on android 6 when app cannot access the internet
      case _Errors.errorNetwork:
        await dispose();
        Dialogues.showInternetRequiredForSpeech();

      default:
        Toast.showError(L10nR.tToastDefaultError());
// await stop();
// await _Methods._startRecorder();
        await dispose();
    }
  }

// static double minSoundLevel = 50000;
// static double maxSoundLevel = -50000;
//
// static void _soundLevelListener(double level) {
//   minSoundLevel = min(minSoundLevel, level);
//   maxSoundLevel = max(maxSoundLevel, level);
//   // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
// }

  static Future<void> cancel() async {
    logEvent('cancel');
    await _speech.cancel();
  }

  static Future<void> stop() async {
    RoutesBase.activeContext!.read(homeProvider).setLoading(true);
    logEvent('stop');
    await _speech.stop();
    await _SfxPlayer.negative();
  }

  static Future<void> dispose() async {
    final restOnly = RoutesBase.activeContext!.read(settingProvider).restOnlyTrigger;
    restOnly ? await _restOnlyDispose() : await _dispose();

    await _SfxPlayer.dispose();
    await TTSService.dispose();
  }

  static Future<void> _restOnlyDispose() async {
    logEvent('===================== called _restOnlyDispose =====================');
    RoutesBase.activeContext!.read(homeProvider).setLoading(true);
    await _Recorder._dispose();
    await _SfxPlayer.negative();
    RoutesBase.activeContext!.read(homeProvider).setMonitoring(false);
    _Recorder._canStart = true;
  }

  static bool _canDisposed = true;
  static bool _waitedDispose = false;

  static Future<void> _dispose() async {
    logEvent('===================== called Disposed Speech =====================');
    _disposed = true;
    _Methods._gotIt = true;
    _canStartSpeech = false;
    if (!_canDisposed) {
      // Toast.showWarning(
      //   L10nR.tRetryingToStopRecognition(),
      //   priority: MyPriority.nowNoRepeat,
      // );
      RoutesBase.activeContext!.read(homeProvider).setLoading(true);
      return 200.milliseconds.delay.then((_) {
        _waitedDispose = true;
        return dispose();
      });
    }
    await _Recorder._dispose(ensuring: true);
    await stop();
    RoutesBase.activeContext!.read(homeProvider).setMonitoring(false);
    if (_waitedDispose) {
      Toast.show(L10nR.tRecognitionStopped());
      _waitedDispose = false;
    }

    // _Methods._displayText.dispose();

    print(' ====================== 1 sec delay =========================');
    1.seconds.delay.then((_) {
      _canStartSpeech = true;
      _talkIncludesTTS = false;
      _Recorder._canStart = true;
      print(' ======= sat _canStartSpeech to true From dispose after 1 seconds ===============');
    });
  }
}
