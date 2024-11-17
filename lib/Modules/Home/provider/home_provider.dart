import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../Shared/Components/Toast/toast.dart';
import '../../../Shared/Extensions/on_context.dart';
import '../../../Shared/Extensions/time_package.dart';
import '../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../Shared/Services/Routing/routes_base.dart';
import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../Settings/Provider/setting_provider.dart';
import '../Widgets/count_before_start.dart';
import '../utilities/Speech/helpers/spoken_phrases.dart';
import '../utilities/Speech/speech_service.dart';
import '../utilities/enums.dart';

final homeProvider = ChangeNotifierProvider((_) => HomeProvider._());

class HomeProvider extends ChangeNotifier {
  HomeProvider._();

  /// Total Timer Top Cycle
  final FixedExtentScrollController minuteController = FixedExtentScrollController();
  final FixedExtentScrollController secondController = FixedExtentScrollController();

  TotalState totalState = TotalState.stopped;

  static int get storedMin => HiveService.storedCache.get(StoredCacheKeys.lastLadderMinute) ?? 0;

  static int get storedSec => HiveService.storedCache.get(StoredCacheKeys.lastLadderSecond) ?? 0;

  void setTotalState(TotalState state) {
    if (totalState != state) {
      /// Important to keep the screen on while the timer is running or paused
      state.isStopped ? WakelockPlus.disable() : WakelockPlus.enable();

      totalState = state;
      notifyListeners();
    }
  }

  int minute = storedMin;

  void setMinute(int value) {
    if (minute == value) return;
    minute = value;
    notifyListeners();
  }

  int second = storedSec;

  void setSecond(int value) {
    if (second == value) return;
    second = value;
    notifyListeners();
  }

  final _stopwatch = Stopwatch();
  Timer? _ladderTimer;

  void refreshPositions() {
    minuteController.jumpToItem(minute);
    secondController.jumpToItem(second);
  }

  /// Main Logic to run the timer and animate the wheels
  void _timerLogic() {
    final totalDuration = Duration(minutes: storedMin, seconds: storedSec);
    final lapsed = _stopwatch.elapsed;
    final shouldBeCurrent = totalDuration - lapsed;

    final shouldBeCurrentNNN = shouldBeCurrent.nHHnMMnSS;
    if (shouldBeCurrent.isNegative) {
      abortLadder();

      /// TODO : Play a sound effect or a voice Later on
      //     final shouldSave = await Dialogues.showLadderFinishSuccess();
      //     if (shouldSave ?? false) {
      //       /// TODO : Implement Saving of results and CREATE THEM ^^
      //     }
      return;
    }

    if (second != shouldBeCurrentNNN.$3 + 1) {
      second = shouldBeCurrentNNN.$3 + 1;
      second == 59
          ? secondController.jumpToItem(59)
          : secondController.animateToItem(
              second == 60 ? 0 : second,
              duration: 800.milliseconds,
              curve: Curves.easeInOutCubicEmphasized,
            );
    }

    if (second != 60 && minute != shouldBeCurrentNNN.$2) {
      minute = shouldBeCurrentNNN.$2;
      minuteController.animateToItem(
        minute,
        duration: 800.milliseconds,
        curve: Curves.easeInOutCubicEmphasized,
      );
    }

    _whetherToRemindWithEnd();
  }

  bool _saidLastRound = false;

  void _whetherToRemindWithEnd() {
    if (!RoutesBase.activeContext!.read(settingProvider).enableNearEndReminder) return;

    if (_saidLastRound) return;

    final currentDuration = Duration(minutes: minute, seconds: second).inSeconds;
    final value = RoutesBase.activeContext!.read(settingProvider).nearEndReminderValue;
    final totalDuration = Duration(minutes: storedMin, seconds: storedSec);

    /// Return If:
    ///   Still Counting Down and currentTimer is more than nearEndReminderValue,
    ///   or total Timer Duration is less than nearEndReminderValue.
    if (currentDuration > value || totalDuration.inSeconds < value) return;

    TTSService.speak(L10nSC.tSecondsRemainingTillEnd(value));
    _saidLastRound = true;
  }

  Timer? _halfTimer;
  bool _halfReminded = false;

  void _halfReminderLogic() {
    if (!RoutesBase.activeContext!.read(settingProvider).halfTotalTimeReminder || _halfReminded) return;

    final totalDuration = Duration(minutes: storedMin, seconds: storedSec);

    /// We use [.ceil] here to trigger speak just a little earlier
    /// so that the utterance is played while the half time is precisely reached.
    /// if we use [.floor] or [.round] then the utterance will be played just a little later.
    ///
    /// we have here an error of at most 1 milliSecond
    final halfDuration = Duration(milliseconds: (totalDuration.inMilliseconds / 2).ceil());
    final remainingTillHalfTime = halfDuration - _stopwatch.elapsed;

    _halfTimer?.cancel();
    _halfTimer = Timer(
      remainingTillHalfTime,
      () {
        _halfReminded = true;
        TTSService.speak(L10nSC.tHalfTotalTime());
      },
    );
  }

  /// Start
  void startLadder({bool voiced = false}) => switch (totalState) {
        TotalState.stopped => _startLadder(voiced),
        TotalState.running => TTSService.speak(L10nSC.tTimerIsAlreadyRunning()),
        TotalState.paused => TTSService.speak(L10nSC.tAlreadyStartedTryResume())
      };

  void _startLadder(bool voiced) {
    /// Making Sure of actual time existence
    if (minute == 0 && second == 0) {
      return voiced
          ? TTSService.speak(L10nSC.tPleaseSetTotalTime())
          : Toast.show(L10nR.tPleaseSetTotalTime());
    }

    /// Saving for convenience
    HiveService.storedCache.putAll({
      StoredCacheKeys.lastLadderMinute: minute,
      StoredCacheKeys.lastLadderSecond: second,
    });

    /// Setting Ui State
    setTotalState(TotalState.running);

    /// Starting the timer and inner cycle go
    innerTimerNotifier.value = Duration.zero;
    countBeforeStart(
      then: () {
        _stopwatch.start();
        _ladderTimer ??= Timer.periodic(_updateInterval, (_) => _timerLogic());
        _go();
        _halfReminderLogic();
      },
      voiced: voiced,
    );
  }

  void countBeforeStart({required VoidCallback then, bool voiced = false}) {
    /// T o d o: DONE Have a setting for enabling it.

    final shouldCount = RoutesBase.activeContext!.read(settingProvider).enableStartCount;
    if (!shouldCount) {
      then();
      voiced ? TTSService.speak(L10nSC.tTimerStarted()) : null;
      return;
    }

    /// T o d o :DONE  Implement Overlay as Vandal t* did. EVEN Better
    final count = RoutesBase.activeContext!.read(settingProvider).startCount;
    final notifier = ValueNotifier(count);

    MyOverlay.showTimed(
        content: CountBeforeStart(notifier, voiced),
        showCloseIcon: count > 3,
        duration: count.seconds,
        onDismiss: (userDismiss) {
          print('userDismiss $userDismiss');
          userDismiss ? setTotalState(TotalState.stopped) : then();
          CountBeforeStart.timer?.cancel();
          CountBeforeStart.timer = null;
          SpeechService.resetTTS();
          notifier.dispose();
        });
  }

  /// Pause
  bool _pausedOnRest = false;

  void pauseLadder({bool voiced = false}) => switch (totalState) {
        TotalState.running => _pauseLadder(voiced),
        TotalState.stopped => TTSService.speak(L10nSC.tTimerHasNotStartedYet()),
        TotalState.paused => TTSService.speak(L10nSC.tTimerIsAlreadyPaused())
      };

  void _pauseLadder(bool voiced) {
    _stopwatch.stop();
    _halfTimer?.cancel();
    _ladderTimer!.cancel();
    _ladderTimer = null;

    /// Pausing the timer and inner cycle go
    _innerTimer?.cancel();
    _innerTimer = null;
    _pausedOnRest = ladderState.isResting;

    /// Setting Ui State
    setTotalState(TotalState.paused);
    setLadderState(LadderState.none);

    if (voiced) TTSService.speak(L10nSC.tTimerPaused());
  }

  /// Resume
  void resumeLadder({bool voiced = false}) => switch (totalState) {
        TotalState.paused => _resumeLadder(voiced),
        TotalState.running => TTSService.speak(L10nSC.tTimerIsAlreadyRunning()),
        TotalState.stopped => TTSService.speak(L10nSC.tTimerHasNotStartedYet()),
      };

  void _resumeLadder(bool voiced) {
    _stopwatch.start();
    _ladderTimer ??= Timer.periodic(_updateInterval, (_) => _timerLogic());
    _pausedOnRest ? _rest(false, fromResume: true) : _go();

    /// Half time reminder TIMER
    _halfReminderLogic();

    /// Setting Ui State
    setTotalState(TotalState.running);

    if (voiced) TTSService.speak(L10nSC.tTimerResumed());
  }

  /// Abort
  void abortLadder() {
    /// Updating the UI State
    setTotalState(TotalState.stopped);
    setLadderState(LadderState.none);

    /// Cancelling timers and and resetting the stopwatch
    _stopwatch.reset();
    _stopwatch.stop();

    _ladderTimer?.cancel();
    _ladderTimer = null;

    _halfTimer?.cancel();
    _halfReminded = false;

    _innerTimer?.cancel();
    _innerTimer = null;

    _saidLastRound = false;

    /// Reset to previously stored values
    setSecond(storedSec);
    setMinute(storedMin);
    secondController.jumpToItem(second);
    minuteController.jumpToItem(minute);

    if (monitoring || recognizing) SpeechService.dispose();
  }

  /// Inner Cycles

  LadderState ladderState = LadderState.none;

  void setLadderState(LadderState state) {
    if (ladderState == state) return;
    ladderState = state;
    notifyListeners();
  }

  ValueNotifier<Duration> innerTimerNotifier = ValueNotifier(Duration.zero);

  Timer? _innerTimer;

  /// 1-150  -   1 (Fastest yet Most exhausting) 150 (Slowest But Least Consumption)
  /// Surely you can be pick a higher number while less than 1000
  /// But you will lose the visual effect of moment updates
  /// It will look like jank.
  final _updateInterval = 63.milliseconds;

  /// GO
  void _go() {
    if (_innerTimer != null) return;

    setLadderState(LadderState.training);

    _saidReady = false;

    /// This is to update right away for the first time
    /// without _updateInterval timer delay - Meticulous ^^.
    innerTimerNotifier.value += _updateInterval;

    _innerTimer ??= Timer.periodic(
      _updateInterval,
      (_) => innerTimerNotifier.value += _updateInterval,
    );
  }

  /// REST
  void rest({bool voiced = false}) => switch (totalState) {
        TotalState.running => _rest(voiced),
        TotalState.stopped => TTSService.speak(L10nSC.tTimerHasNotStartedYet()),
        TotalState.paused => TTSService.speak(L10nSC.tTimerIsPausedTrySayingResume()),
      };

  late Duration _totalRest;

  void _rest(bool voiced, {bool fromResume = false}) {
    if (ladderState.isResting) {
      TTSService.speak(L10nSC.tRestAlreadyCountingDown());
      return;
    }

    final minutes = innerTimerNotifier.value.nHHnMMnSS.$2;
    final seconds = innerTimerNotifier.value.nHHnMMnSS.$3;

    if (minutes == 0 && seconds == 0 && !fromResume) return;

    setLadderState(LadderState.resting);
    _innerTimer?.cancel();
    // if (voiced) {
    TTSService.speak(
      // L10nR.tRestFor() + // TODO : LATER ON set this to be on if it is first rest
      // that is done after you keep track of rest and training periods
      L10nSC.tRestTime(minutes, seconds),
    );
    // }
    _totalRest = innerTimerNotifier.value;
    _innerTimer = Timer.periodic(_updateInterval, _restLogic);
  }

  void _restLogic(_) {
    if (innerTimerNotifier.value - _updateInterval > Duration.zero) {
      _whetherToSayReady();
      innerTimerNotifier.value -= _updateInterval;
    } else {
      _whetherToSayGo();
      innerTimerNotifier.value = Duration.zero;
      _innerTimer?.cancel();
      _innerTimer = null;
      _go();
    }
  }

  bool _saidReady = false;

  void _whetherToSayReady() {
    if (!RoutesBase.activeContext!.read(settingProvider).enableReadyB4Go) return;

    final duration = RoutesBase.activeContext!.read(settingProvider).readyB4Go.seconds;

    final currentDuration = innerTimerNotifier.value;

    /// Return if any of the following:
    ///   counting down have not yet reached duration,
    ///   already said ready,
    ///   rest time is less than duration.
    if (currentDuration > duration || _saidReady || _totalRest < duration) return;

    _saidReady = true; // Flag to say ready only once per rest
    TTSService.speak(L10nSC.tGetReady(), now: true);
  }

  void _whetherToSayGo() {
    if (!RoutesBase.activeContext!.read(settingProvider).sayGoWhenRestIsOver) return;
    TTSService.speak(L10nSC.tGo(), now: true);
  }

  /// End INNER CYCLES

  bool loading = false;

  void setLoading(bool value) {
    if (loading == value) return;
    loading = value;
    notifyListeners();
  }

  bool monitoring = false;

  void setMonitoring(bool value) {
    monitoring = value;
    if (!monitoring) recognizing = false;
    loading = false;
    // monitoring ? AudioSessionService.listenOnDeviceChanges() : AudioSessionService.dispose();
    notifyListeners();
  }

  bool recognizing = false;

  void setRecognizing(bool value) {
    if (recognizing == value) return;
    loading = false;
    recognizing = value;
    monitoring = !recognizing;
    notifyListeners();
  }

  @override
  void dispose() {
    minuteController.dispose();
    secondController.dispose();
    _ladderTimer?.cancel();
    _ladderTimer = null;
    _innerTimer?.cancel();
    _innerTimer = null;
    super.dispose();
  }
}
