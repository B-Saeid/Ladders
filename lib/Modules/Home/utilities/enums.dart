import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Widgets/buttons.dart';
import '../provider/home_provider.dart';

enum TotalState {
  stopped,
  paused,
  running;

  bool get isRunning => this == TotalState.running;

  bool get isStopped => this == TotalState.stopped;
  bool get isPaused => this == TotalState.paused;

  String buttonTitle(WidgetRef ref) => switch (this) {
        TotalState.stopped => L10nR.tStart(ref),
        TotalState.paused => L10nR.tResume(ref),
        TotalState.running => L10nR.tPause(ref),
      };

  // Color? buttonColor(WidgetRef ref) => switch (this) {
  //       TotalState.stopped => AppColors.adaptiveGreen(ref),
  //       TotalState.running => null,
  //     };
  //
  CustomButtonType get buttonType => switch (this) {
        TotalState.stopped => CustomButtonType.filled,
        _ => CustomButtonType.outlined,
      };

  VoidCallback delegateAction(WidgetRef ref) => switch (this) {
        TotalState.stopped => ref.read(homeProvider).abortLadder,
        TotalState.paused => ref.read(homeProvider).pauseLadder,
        TotalState.running => ref.read(homeProvider).resumeLadder,
      };
}

enum LadderState {
  training,
  resting;

  bool get isTraining => this == LadderState.training;
}
