part of '../speech_service.dart';

abstract class _Methods {
  static final _isAndroid = StaticData.platform.isAndroid;

  static bool _androidSpeechGoogleMicRequired() {
    final shownBefore = HiveService.storedCache.get(DialoguesKeys.androidSpeechGoogleMic);
    if (_isAndroid && shownBefore == null) {
      /// TODO : put a setting to reset all dialogues cache
      HiveService.storedCache.put(DialoguesKeys.androidSpeechGoogleMic, true);
      Dialogues.showAndroidGoogleMicRequired();
      return true;
    }
    return false;
  }

  static Future<void> _startRecorder() async {
    if (SpeechService._disposed) {
      print('==== SpeechService is _disposed ===== ignoring _startRecorder =======');
      return;
    }
    final started = await Recorder._start();

    if (!started) {
      Toast.showError(L10nR.tToastDefaultError());
      await SpeechService.dispose();
    }
  }

  /// This is a flag to avoid multiple calls to _handlePotentialAction per recognition session
  static bool _gotIt = false;

  static final ValueNotifier<String> _displayText = ValueNotifier('');
  static VoidCallback? _dismissHandler;

  static Future<void> _handlePotentialAction(
    String wordsString,
    bool isFinal,
  ) async {
    if (_gotIt) {
      print('========================= _ignoring _handlePotentialAction =========');
      return;
    }
    if (_dismissHandler == null) {
      _dismissHandler ??= Toast.showLive(_displayText, duration: 5.seconds);
      5.seconds.delay.then((_) => _dismissHandler = null);
    }
    _displayText.value = wordsString.toLowerCase();
    final recognizedAction = VoiceAction.fromText(_displayText.value, SpeechService.getLocaleID);
    _gotIt = recognizedAction != null;
    print('recognizedAction = $recognizedAction');
    // _isHandled = wordsString.split(' ').length == 1 && wordsString.split(' ').first.length > 3;

    if (_gotIt) {
      await SpeechService.cancel();

      Toast.showSuccess(recognizedAction!.word);
      await recognizedAction.function.call();
      // _dismissHandler?.call();
      // print('---- Called _dismissHandler?.call();');

      await _Methods._startRecorder();
    } else if (isFinal) {
      await SpeechService.stop();

      // _dismissHandler?.call();
      Toast.showWarning(
        L10nR.tNotAKnownCommand(),
        priority: MyPriority.nowNoRepeat,
      );
      TTSService.speak(L10nSC.tNotAKnownCommand());
      print('-============================= AFTER NOT KNOWN COMMAND ===============================-');
      await _Methods._startRecorder();
    }
    // if (_intendedStop) return;
    // await _startRecordRoutine();
  }
}
