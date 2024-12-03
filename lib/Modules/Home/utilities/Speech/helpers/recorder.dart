part of '../speech_service.dart';

abstract class Recorder {
  @protected
  static AudioRecorder? _recorder;

  static StreamSubscription<Amplitude>? _amplitudeSub;

  // static Future<InputDevice?> _checkExistence(InputDevice? device) async {
  //   if (device == null) return null;
  //
  //   final devicesList = await _recorder!.listInputDevices();
  //   if (devicesList.contains(device)) return device;
  //   inputDevice = null;
  //   return null;
  // }

  static InputDevice? get _inputDevice =>
      RoutesBase.activeContext!.read(settingProvider).microphone?.inputDevice;

  // static int _repeatCount = 0;

  static bool _canStart = true;
  static final _interval = 200.milliseconds;

  static Future<bool> _start() async {
    try {
      SpeechService.logEvent('CALLED start recording');
      if (!_canStart || _disposing) {
        // print('_repeatCount > 0 ==== ignoring recording start =====================');
        print(
          '==== CANT start recording ======== ignoring recording start ======== '
          '_disposing $_disposing ============',
        );
        return !_disposing;
      }
      _canStart = false;
      print('=================== sat _canStartRecorder to FALSE =====================');

      if (await _recorder?.isRecording() ?? false) {
        print('already recording ==== ignoring recording start ====================');
        return true;
      }

      /// Dispose of previous recorder if any, This is to prevent
      /// multiple simultaneous recorders which can leak memory.
      await _dispose();

      // if (_repeatCount > 0) {
      //   print(' ====================== ignoring recording start');
      //   return false;
      // }

      /// Initializing Recorder and start recording
      _recorder = AudioRecorder();
      print('===================== Initialized Recorder and inputDevice $_inputDevice');
      // _repeatCount = 0;
      // final input = await _checkExistence(inputDevice);
      _recorder!.startStream(
        RecordConfig(
          /// According to the package documentation:
          /// https://pub.dev/packages/record#stream
          encoder: AudioEncoder.pcm16bits,
          device: _inputDevice,
        ),
      );

      /// Acting on amplitude change
      await _amplitudeSub?.cancel();
      _firstCall = true;

      _lastAmpReads.clear();
      // _liveMic = false;

      _amplitudeSub = _recorder!.onAmplitudeChanged(_interval).distinct(
        /// IN HERE: we are using [.distinct] in a really Distinct way.
        ///
        /// We could have used the [previous] and [next] arguments
        /// and if they are equal, we throw an error that will be caught in [_onErrorHandler].
        ///
        /// But since we need to detect if the amplitude is dead or not
        /// based on the last bunch of amplitude readings,
        /// we had to improvise a little bit.
        ///
        /// We used here [previous] rather [next] just to act proactively.
        ///
        (previous, _) {
          final dead = _checkForDeadStream(previous);
          if (dead) throw 'Amplitude is dead';
          return false; // i.e. not equal so accept it
        },
      ).listen(
        _onAmplitudeChanged,
        onError: _onErrorHandler,
      );
      // _canStartRecord = true;
      // print(' ====================== sat _canRecord to true =========================');
      return true;
    } catch (e, s) {
      print('Error in start recording $e with trace $s');
      return false;
    }
  }

  /// This is to detect whether amplitude is not dead
  // static bool _liveMic = false;
  static final List<double> _lastAmpReads = [];

  static bool _checkForDeadStream(Amplitude event) {
    // RoutesBase.activeContext!.read(homeProvider).setLoading(true);
    final current = event.current.abs();
    // print('Amplitude : $current');

    final maxLength = 1.seconds.inMilliseconds ~/ _interval.inMilliseconds;
    if (_lastAmpReads.length < maxLength) {
      print('Added to list');
      _lastAmpReads.add(current);
      return false;
    } else if (_lastAmpReads.toSet().length == 1 && _lastAmpReads.sum != 0) {
      return true;
      // print('Amplitude is dead');
      // await _onErrorHandler();
    } else {
      _lastAmpReads.clear();
      print('-- List cleared');
      return false;
      // final can = SpeechService.setCanStart();
      // if (can) {
      //   print('====================== in IF can ======================');
      //   _liveMic = true;
      //   RoutesBase.activeContext!.read(homeProvider).setRecognizing(false);
      // } else {
      //   print('====================== in else can & cancelling ======================');
      //   await _amplitudeSub?.cancel();
      // }
    }
  }

  static bool _firstCall = true;

  static Future<void> _onAmplitudeChanged(Amplitude event) async {
    // if (!_liveMic) return await _checkForDeadStream(event);
    // if (!RoutesBase.activeContext!.read(homeProvider).monitoring) return await _onErrorHandler();
    if (_firstCall) await _handleFirstRun();

    // amplitudeNotifier.value = event;
    print('------------------------------');
    // print('current Amplitude : ${event.current.toStringAsFixed(2)}');
    print('current Amplitude : ${event.current}');
    // print('MAX Amplitude : ${event.max.toStringAsFixed(2)}');
    // print('------------------------------');
    // print('max Amplitude : ${event.max}');
    // print('max ABS Amplitude : ${event.max.abs()}');
    final amplitude = event.current;
    final from0ToMax = max(0, amplitude + SensitivityConstants.maxDBValue);
    final double triggerPercentage = HiveService.settings.get(_inputDevice!.id) ?? 0.8;
    final currentPercentage = from0ToMax / SensitivityConstants.maxDBValue;
    if (SpeechService._isTTS) {
      print('===== IGNORING AMPLITUDE IN TTS MODE ----------');

      /// T O D O  DONE! : Have a setting for sensitivity instead of this hard-coded value
    } else if (currentPercentage >= triggerPercentage /*|| _repeatCount > 0*/) {
      print('====================== in IF current >= ${triggerPercentage.toStringAsFixed(2)}');
      await _handleAmpRaise();
    }
  }

  static Future<void> _handleAmpRaise() async {
    final restOnly = RoutesBase.activeContext!.read(settingProvider).restOnlyTrigger;
    if (restOnly) {
      final total = RoutesBase.activeContext!.read(homeProvider).totalState;
      final ladder = RoutesBase.activeContext!.read(homeProvider).ladderState;
      final activeWhenRestOnly = total.isRunning && ladder.isTraining;
      if (activeWhenRestOnly) VoiceAction.rest.function();
    } else {
      await _dispose();
      await SpeechService.startSpeech();
    }
  }

  static Future<void> _handleFirstRun() async {
    _firstCall = false;
    final restOnly = RoutesBase.activeContext!.read(settingProvider).restOnlyTrigger;

    if (restOnly) {
      RoutesBase.activeContext!.read(homeProvider).setMonitoring(true);
    } else {
      final can = SpeechService.setCanStartSpeech();
      if (can) {
        print('====================== in IF can ======================');
        RoutesBase.activeContext!.read(homeProvider).setRecognizing(false);
      } else {
        print('====================== in else can & cancelling ======================');
        await _amplitudeSub?.cancel();
      }
    }
  }

  static Future<void> _onErrorHandler([dynamic error]) async {
    if (error != null) print('Error in _onErrorHandler: $error');
    Toast.showError(L10nR.tToastDefaultError());
    await SpeechService.dispose();
  }

  static bool _disposing = false;

  static Future<void> _dispose({bool ensuring = false}) async {
    print('===================== called Disposed Recorder =====================');
    // _canStart = false;
    // print('=================== sat _canStartRecorder to FALSE =====================');
    print('ensuring = $ensuring');
    final recorderIsNull = _recorder == null;
    print('recorder ${recorderIsNull ? '= null' : 'exists'}');
    print('_disposing = $_disposing');
    if (ensuring) {
      print('===================== scheduled a Disposed call =====================');
      1.5.seconds.delay.then((_) => _dispose());
    }
    if (_disposing) {
      print('===================== Can not continue ALREADY _disposing ============');
      return;
    }
    _disposing = true;
    print('=================== sat _disposing to TRUE =====================');
    // print('_repeatCount = $_repeatCount');
    // try {
    await _amplitudeSub?.cancel();
    await _recorder?.cancel();
    await _recorder?.dispose();
    _recorder = null;
    if (!recorderIsNull) print('===================== Disposed Recorder =====================');
    _disposing = false;
    print('=================== sat _disposing to FALSE =====================');

    // _ensuringDisposeLogic(recorderIsNull, ensuring);
    // } catch (e) {
    //   print('--- Error in dispose: $e');
    // }
  }

// static void _ensuringDisposeLogic(recorderIsNull, bool ensuring) {
//   if (!recorderIsNull) {
//     print('===================== Disposed Recorder =====================');
//     _repeatCount = -1;
//   } else if (ensuring && _repeatCount >= 0) {
//     print('===================== ensuring && _repeatCount >= 0 =====================');
//     _repeatCount++;
//     _repeatCount > 5 ? _repeatCount = 0 : Timer(0.5.seconds, () => dispose(ensuring: true));
//   } else {
//     print('ensuring = $ensuring');
//     print('===================== resetting _repeatCount =====================');
//     _repeatCount = 0;
//   }
// }
}
