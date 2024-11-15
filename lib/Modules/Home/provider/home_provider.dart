import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../Shared/Components/Toast/toast.dart';
import '../../../Shared/Extensions/time_package.dart';
import '../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
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

    if (second == 0 && minute == 0) {
      /// The End
      /// TODO : Play a sound effect or a voice Later on
      /// TODO : Show Success Dialogue
      return abortLadder();
    }
  }

  /// Start
  Future<void> startLadder() async {
    /// Making Sure of actual time existence
    if (second == 0 && minute == 0) return Toast.show(L10nR.tPleaseSetTotalTime());

    /// Saving for convenience
    await HiveService.storedCache.putAll({
      StoredCacheKeys.lastLadderMinute: minute,
      StoredCacheKeys.lastLadderSecond: second,
    });

    /// Setting Ui State
    setTotalState(TotalState.running);

    /// Starting the timer and inner cycle go
    timerDuration.value = Duration.zero;
    // await 1.seconds.delay;
    // await threeTwoOne();
    _go();
    _ladderTimer = Timer.periodic(1.seconds, _timerLogic);
  }

  /// Pause
  void pauseLadder() {
    _ladderTimer?.cancel();

    /// Setting Ui State
    setTotalState(TotalState.paused);

    /// Pausing the timer and inner cycle go
    timer?.cancel();
  }

  /// Resume
  void resumeLadder() {
    _ladderTimer = Timer.periodic(1.seconds, _timerLogic);

    setTotalState(TotalState.running);

    _go();
  }

  /// Abort
  void abortLadder() {
    /// Reset to previously stored values
    final int lastLadderMinute = HiveService.storedCache.get(StoredCacheKeys.lastLadderMinute);
    final int lastLadderSecond = HiveService.storedCache.get(StoredCacheKeys.lastLadderSecond);
    secondController.jumpToItem(lastLadderSecond);
    minuteController.jumpToItem(lastLadderMinute);
    setSecond(lastLadderSecond);
    setMinute(lastLadderMinute);

    /// Updating the UI State
    setTotalState(TotalState.stopped);

    /// Cancelling the timer
    _ladderTimer?.cancel();
    timer?.cancel();
    timer = null;
  }

// Future<void> threeTwoOne() async {
//   /// Todo: Have a setting for enabling it.
//   /// Todo: Implement Overlay as Vandal t* did.
//   Toast.show('Three', gravity: ToastGravity.center, priority: ToastPriority.now);
//   await 1.seconds.delay;
//   Toast.show('Two', gravity: ToastGravity.center, priority: ToastPriority.now);
//   await 1.seconds.delay;
//   Toast.show(
//     'One',
//     gravity: ToastGravity.center,
//     priority: ToastPriority.now,
//     duration: 0.5.seconds,
//   );
//   await 1.seconds.delay;
// }

  /// Inner Cycles

  LadderState ladderState = LadderState.resting;

  void setLadderState(LadderState state) {
    if (ladderState != state) {
      ladderState = state;
      notifyListeners();
    }
  }

  ValueNotifier<Duration> timerDuration = ValueNotifier(Duration.zero);

  Timer? timer;

  /// 1-150  -   1 (Fastest yet Most exhausting) 150 (Slowest But Least Consumption)
  /// Surely you can be pick a higher number while less than 1000
  /// But you will lose the visual effect of moment updates
  /// It will look like jank.
  final _updateInterval = 63.milliseconds;

  void _go() {
    setLadderState(LadderState.training);
    timer = Timer.periodic(
      _updateInterval,
      (_) => timerDuration.value += _updateInterval,
    );
  }

  void rest() {
    setLadderState(LadderState.resting);
    timer?.cancel();
    timer = Timer.periodic(
      _updateInterval,
      (_) {
        if (timerDuration.value - _updateInterval <= Duration.zero) {
          /// TODO : Play the Go sound
          timerDuration.value = Duration.zero;
          timer?.cancel();
          timer = null;
          return _go();
        }
        timerDuration.value -= _updateInterval;
      },
    );
  }

  @override
  void dispose() {
    minuteController.dispose();
    secondController.dispose();
    _ladderTimer?.cancel();
    super.dispose();
  }
}
