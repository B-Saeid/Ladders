import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void setTotalState(TotalState state) {
    if (totalState != state) {
      totalState = state;
      notifyListeners();
    }
  }

  int minute = 0;

  void setMinute(int value) {
    if (minute != value) {
      minute = value;
      notifyListeners();
    }
  }

  int second = 0;

  void setSecond(int value) {
    if (second != value) {
      second = value;
      notifyListeners();
    }
  }

  Timer? _ladderTimer;

  /// Main Logic to run the timer and animate the wheels
  void _timerLogic(_) {
    if (second == 0) {
      secondController.jumpToItem(59);
      second = 59;
      minuteController.animateToItem(
        --minute,
        duration: 300.milliseconds,
        curve: Curves.easeInOutCubicEmphasized,
      );
    } else {
      secondController.animateToItem(
        --second,
        duration: 300.milliseconds,
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
    if (second == 0 && minute == 0) return Toast.show(L10nR.tPleaseDetermineLadderTime());

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
