import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Constants/type_def.dart';
import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../Shared/Services/l10n/l10n_service.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/buttons.dart';
import '../../../Shared/Widgets/custom_animated_size.dart';
import '../../Settings/Models/mic_type_enum.dart';
import '../../Settings/Provider/setting_provider.dart';
import '../provider/home_provider.dart';
import '../utilities/Speech/speech_service.dart';
import '../utilities/enums.dart';

class StartAbortButton extends ConsumerWidget {
  const StartAbortButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalState = ref.watch(homeProvider.select((p) => p.totalState));
    final showVoiceActions = ref.watch(
      settingProvider.select((p) => p.enableVoiceActions || p.restOnlyTrigger),
    );
    return CustomAnimatedSize(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!totalState.isStopped) ...[
                _PauseResumeIcon(totalState),
                const SizedBox(width: 25),
              ],
              const Flexible(child: _StartRestButton()),
              if (!totalState.isStopped) ...[
                const SizedBox(width: 25),
                const _StopIcon(),
              ]
            ],
          ),
          if (showVoiceActions) ...[
            const SizedBox(height: 8),
            const _VoiceActionButton(),
          ],
        ],
      ),
    );
  }
}

class _VoiceActionButton extends ConsumerWidget {
  const _VoiceActionButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recognizing = ref.watch(homeProvider.select((p) => p.recognizing));
    final monitoring = ref.watch(homeProvider.select((p) => p.monitoring));
    final loading = ref.watch(homeProvider.select((p) => p.loading));
    final totalState = ref.watch(homeProvider.select((p) => p.totalState));
    final ladderState = ref.watch(homeProvider.select((p) => p.ladderState));
    final restOnly = ref.watch(settingProvider.select((p) => p.restOnlyTrigger));

    final activeInRestOnly = !monitoring || (!totalState.isPaused && ladderState.isTraining);

    return ValueListenableBuilder(
      valueListenable: SpeechService.isTTSNotifier,
      builder: (_, isTTS, __) => CustomButton(
        icon: recognizing

            /// TODO : Make it an icon data and use it in an Icon widget
            ? AdaptiveIcons.wSpeakingHead()
            : _ButtonIcon(outlined: restOnly && !activeInRestOnly),
        type: monitoring ? CustomButtonType.outlined : CustomButtonType.filled,
        onPressed: monitoring || recognizing
            ? SpeechService.dispose
            : restOnly
                ? SpeechService.startMonitoring
                : SpeechService.startSpeech,
        loadingIndicator: loading,
        // actionable: isTTS
        //     ? false
        //     : restOnly
        //         ? activeInRestOnly
        //         : true,
        child: L10nRText(
          recognizing
              ? L10nR.tSpeak
              : monitoring
                  ? restOnly
                      ? _buildRestOnlyText(ladderState, totalState)
                      : L10nR.tListening
                  : restOnly
                      ? L10nR.tMonitorRestTrigger
                      : L10nR.tVoiceAction,
        ),
      ),
    );
  }

  StringRef _buildRestOnlyText(LadderState ladder, TotalState total) {
    if (total.isStopped || ladder.isNone) return L10nR.tTimerHasNotStartedYet;
    if (total.isPaused) return L10nR.tTimerIsPaused;
    if (ladder.isResting) return L10nR.tRestAlreadyCountingDown;
    return L10nR.tListeningForRestTrigger;
  }
}

class _ButtonIcon extends ConsumerWidget {
  const _ButtonIcon({required this.outlined});

  final bool outlined;

  bool notFilled(WidgetRef ref, bool isTTS) => ref.watch(homeProvider.select(
        /// This is to say Keep the icon filled unless we are actually monitoring or recognizing
        /// if we are the icon will NOT be filled according to [outlined]
        (p) => (p.monitoring || p.recognizing) ? isTTS || outlined : false,
      ));

  @override
  Widget build(BuildContext context, WidgetRef ref) => ValueListenableBuilder(
      valueListenable: SpeechService.isTTSNotifier,
      builder: (_, isTTS, __) {
        final microphone = ref.watch(settingProvider.select((p) => p.microphone));
        return IconTheme.merge(
          data: IconThemeData(
            color: notFilled(ref, isTTS) ? LiveData.themeData(ref).disabledColor : null,
          ),
          child: (microphone?.type ?? MicType.builtIn).icon(notFilled(ref, isTTS)),
        );
      });
}

class _StopIcon extends ConsumerWidget {
  const _StopIcon();

  @override
  Widget build(BuildContext context, WidgetRef ref) => IconButton.outlined(
        onPressed: TotalState.stopped.delegateAction(ref),
        icon: Icon(
          AdaptiveIcons.stop,
          size: 24.scalable(ref),
        ),
      );
}

class _PauseResumeIcon extends ConsumerWidget {
  const _PauseResumeIcon(this.state);

  final TotalState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) => IconButton.outlined(
        onPressed: state.isRunning
            ? TotalState.paused.delegateAction(ref)
            : TotalState.running.delegateAction(ref),
        icon: Icon(
          state.isRunning ? AdaptiveIcons.pause : AdaptiveIcons.play,
          size: 24.scalable(ref),
        ),
      );
}

class _StartRestButton extends ConsumerWidget {
  const _StartRestButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(homeProvider);

    final totalState = ref.watch(homeProvider.select((p) => p.totalState));
    final ladderState = ref.watch(homeProvider.select((p) => p.ladderState));

    return CustomButton(
      onPressed: () => totalState.isStopped ? provider.startLadder() : provider.rest(),
      actionable: totalState.isStopped ? true : ladderState.isTraining && totalState.isRunning,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(totalState.isStopped ? L10nR.tSTART(ref) : L10nR.tRest(ref)),
      ),
    );
  }
}
