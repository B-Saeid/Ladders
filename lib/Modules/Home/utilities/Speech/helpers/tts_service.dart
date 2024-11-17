part of '../speech_service.dart';

enum TTSState {
  playing,
  stopped,
  paused,
  continued;

  bool get isPlaying => this == TTSState.playing;

  bool get isStopped => this == TTSState.stopped;

  bool get isPaused => this == TTSState.paused;

  bool get isContinued => this == TTSState.continued;
}

abstract class TTSService {
  static final FlutterTts _flutterTts = FlutterTts();

  static ValueNotifier<TTSState>? _ttsStateNotifier;

  static TTSState get ttsState => _initialized ? _ttsStateNotifier!.value : TTSState.stopped;

  static bool _initialized = false;

  static String? _localeID;

  static Future<void> _setLocaleID({bool ensure = false}) async {
    final current = SpeechService.getLocaleID;
    if (_localeID == current && !ensure) return;
    _localeID = current;
    final List languages = await _flutterTts.getLanguages;
    final match = languages.firstWhereOrNull((element) => element == current);

    print('languages = $languages');

    /// This is a work around for some languages not being matched.
    final foundLanguage = match ??
        languages.firstWhereOrNull(
          (element) => element.split('-').first == current.split('-').first,
        );

    print('foundLanguage = $foundLanguage');

    if (foundLanguage != null && await _flutterTts.isLanguageAvailable(foundLanguage)) {
      await _flutterTts.setLanguage(foundLanguage);
      RoutesBase.activeContext!.read(settingProvider).setTtsAvailable(true);
    } else {
      RoutesBase.activeContext!.read(settingProvider).setTtsAvailable(false);
      Dialogues.showSpokenContentNotAvailable();
    }
  }

  static Future<void> init({bool ensure = false}) async {
    if (_initialized) return await _setLocaleID(ensure: ensure);
    _initialized = true;

    print('++++ INITIALIZED TTS +++++');
    await _flutterTts.awaitSpeakCompletion(true);

    _ttsStateNotifier = ValueNotifier(TTSState.stopped);
    _flutterTts.setStartHandler(() => _ttsStateNotifier!.value = TTSState.playing);
    _flutterTts.setCompletionHandler(() => _ttsStateNotifier!.value = TTSState.stopped);
    _flutterTts.setCancelHandler(() => _ttsStateNotifier!.value = TTSState.stopped);
    _flutterTts.setPauseHandler(() => _ttsStateNotifier!.value = TTSState.paused);
    _flutterTts.setContinueHandler(() => _ttsStateNotifier!.value = TTSState.continued);
    _flutterTts.setErrorHandler((msg) {
      print('error occurred in TTS: $msg');
      Dialogues.showSpokenContentError();
      _ttsStateNotifier!.value = TTSState.stopped;
    });

    await _setLocaleID();

    // /// This is to warm up the TTS.
    // speak('');
    SpeechService.resetTTS();
  }

  /// TODO : ANY ARABIC talk lAZEM TE SHA KEL OH
  static Future<void> speak(String talk, {bool now = false, bool isEnd = true}) async {
    if (!RoutesBase.activeContext!.read(settingProvider).ttsAvailable) return;

    // final can =SpeechService.flagTTS(true);
    // if (!can) return;

    SpeechService.flagTTS(true);
    print('>>>>>>>>>>>>>>> talk is $talk');

    if (now) await _flutterTts.stop();

    /// This is the number of seconds to wait after the speech is completed.
    final restOnly = RoutesBase.activeContext!.read(settingProvider).restOnlyTrigger;
    final  waitAmount = restOnly ? 1 : 0.5;
    _flutterTts.speak(talk).then(
          /// This delay is To Avoid:
          ///
          /// - The notch at the end of the speech.
          /// - Early release of flagTTS while the speech is still audible i.e. can be caught by MIC.
          ///
          /// This is wierd and should be removed as we sat [_flutterTts.awaitSpeakCompletion(true)]
          /// But for now it works with this delay.
          (_) => waitAmount.seconds.delay.then(
                (_) => isEnd ? SpeechService.flagTTS(false) : null,
              ),
        );
  }

  static Future<void> dispose() async {
    _initialized = false;
    await _flutterTts.stop();
    _ttsStateNotifier?.dispose();
    _ttsStateNotifier = null;
  }
}
