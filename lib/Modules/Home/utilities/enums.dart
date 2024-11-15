import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Extensions/on_context.dart';
import '../../../Shared/Services/Routing/routes_base.dart';
import '../../../Shared/Services/l10n/l10n_service.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Styles/app_colors.dart';
import '../../../Shared/Widgets/buttons.dart';
import '../provider/home_provider.dart';

enum TotalState {
  stopped,
  paused,
  running;

  bool get isRunning => this == TotalState.running;

  bool get isStopped => this == TotalState.stopped;

  bool get isPaused => this == TotalState.paused;

  // String buttonTitle(WidgetRef ref) => switch (this) {
  //       TotalState.stopped => L10nR.tSTART(ref),
  //       TotalState.paused => L10nR.tResume(ref),
  //       TotalState.running => L10nR.tPause(ref),
  //     };

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
        /// This is safe as if the [homeProvider] got invalidated
        /// this would not throw an error of: ".. being used after being disposed... ",
        /// because now - since it is a closure - the VoidCallback is not a cached reference
        /// It is FRESHLY read each time the [delegateAction] is invoked
        ///
        /// learnt from the [restOnlyTrigger] bug
        TotalState.stopped => () => ref.read(homeProvider).abortLadder(),
        TotalState.paused => () => ref.read(homeProvider).pauseLadder(),
        TotalState.running => () => ref.read(homeProvider).resumeLadder(),
      };
}

enum LadderState {
  none,
  training,
  resting;

  bool get isNone => this == LadderState.none;

  bool get isTraining => this == LadderState.training;

  bool get isResting => this == LadderState.resting;

  Widget indicatingIcon(WidgetRef ref) => switch (this) {
        LadderState.none => AdaptiveIcons.wFlatBar(ref: ref),
        LadderState.training => AdaptiveIcons.wTraining(ref: ref),
        LadderState.resting => AdaptiveIcons.wResting(ref: ref),
      };

  Color? indicatingColor(WidgetRef ref) => switch (this) {
        LadderState.none => null,
        LadderState.training => AppColors.adaptiveGreen(ref),
        LadderState.resting => AppColors.adaptiveBlue(ref),
      };
}
