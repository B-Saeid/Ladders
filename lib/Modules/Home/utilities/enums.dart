import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Extensions/on_context.dart';
import '../../../Shared/Services/Routing/routes_base.dart';
import '../../../Shared/Services/l10n/l10n_service.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Styles/app_colors.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/buttons.dart';
import '../provider/home_provider.dart';
import 'TextToSpeech/spoken_phrases.dart';

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

enum SpeechState {
  /// Encountered when speech recognition has become
  /// available right after calling the initialize method
  /// usually when the user has just opened the app.
  available,

  /// when speech recognition begins after calling the listen method.
  listening,

  /// when speech recognition is no longer listening to the microphone
  /// after a timeout, cancel or stop call.
  notListening,

  /// when all results have been delivered.
  done;

  bool get isListening => this == SpeechState.listening;

  bool get isNotListening => this == SpeechState.notListening;

  bool get isDone => this == SpeechState.done;

  bool get doneOrNotListening => [SpeechState.done, SpeechState.notListening].contains(this);

  bool get availableOrListening => [SpeechState.available, SpeechState.listening].contains(this);

  static SpeechState? from(String string) => SpeechState.values.firstWhereOrNull(
        (element) => element.name == string,
      );
}

enum VoiceAction {
  start,
  rest,
  pause,
  resume;

  static VoiceAction? fromText(String text, String speechID) => VoiceAction.values.firstWhereOrNull(
        (action) => action._alternates(speechID).any(
              (alternate) => text.contains(alternate),
            ),
      );

  List<String> _alternates(String speechID) {
    final supportedLocale = SupportedLocale.fromSpeechID(speechID);
    return switch (this) {
      VoiceAction.start => switch (supportedLocale) {
          SupportedLocale.ar => ['ابدأ', 'بدء', 'ابدا', 'إبدأ', 'أبدا', 'أبدأ'],
          SupportedLocale.en => ['start'],
        },
      VoiceAction.pause => switch (supportedLocale) {
          SupportedLocale.ar => ['توقف', 'ايقاف', 'إيقاف', 'وقف'],
          SupportedLocale.en => ['pause'],
        },
      VoiceAction.rest => switch (supportedLocale) {
          SupportedLocale.ar => ['راحة'],
          SupportedLocale.en => ['rest', 'breast', 'wrist', 'press'],
        },
      VoiceAction.resume => switch (supportedLocale) {
          SupportedLocale.ar => ['أكمل', 'اكمل', 'إكمل'],
          SupportedLocale.en => ['resume'],
        },
    };
  }

  String get word => switch (this) {
        VoiceAction.start => L10nR.tSTART(),
        VoiceAction.pause => L10nR.tPAUSE(),
        VoiceAction.rest => L10nR.tREST(),
        VoiceAction.resume => L10nR.tRESUME(),
      };

  String get spokenWord => switch (this) {
        VoiceAction.start => L10nSC.tSTART(),
        VoiceAction.pause => L10nSC.tPAUSE(),
        VoiceAction.rest => L10nSC.tREST(),
        VoiceAction.resume => L10nSC.tRESUME(),
      };

  String get description => switch (this) {
        VoiceAction.start => L10nR.tStartDescription(),
        VoiceAction.pause => L10nR.tPauseDescription(),
        VoiceAction.rest => L10nR.tRestDescription(),
        VoiceAction.resume => L10nR.tResumeDescription(),
      };

  Widget icon(WidgetRef ref) {
    final size = 32.scalable(
      ref,
      maxFactor: 1.7,
    );
    return switch (this) {
      VoiceAction.start => AdaptiveIcons.wTraining(size: size),
      VoiceAction.rest => AdaptiveIcons.wResting(size: size),
      VoiceAction.pause => Icon(AdaptiveIcons.pause, size: size),
      VoiceAction.resume => AdaptiveIcons.wFlatBar(size: size),
    };
  }

  Function get function {
    final provider = RoutesBase.activeContext!.read(homeProvider);
    return switch (this) {
      VoiceAction.start => () => provider.startLadder(voiced: true),
      VoiceAction.pause => () => provider.pauseLadder(voiced: true),
      VoiceAction.rest => () => provider.rest(voiced: true),
      VoiceAction.resume => () => provider.resumeLadder(voiced: true),
    };
  }
}
