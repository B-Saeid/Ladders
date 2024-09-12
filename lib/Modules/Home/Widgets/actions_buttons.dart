import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/buttons.dart';
import '../../../Shared/Widgets/custom_animated_size.dart';
import '../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../provider/home_provider.dart';
import '../utilities/enums.dart';

class StartAbortButton extends ConsumerWidget {
  const StartAbortButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      Selector<({TotalState total, LadderState ladder})>(
        selector: homeProvider.select((p) => (total: p.totalState, ladder: p.ladderState)),
        builder: (_, state, __) => CustomAnimatedSize(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!state.total.isStopped) ...[
                _PauseResumeIcon(state.total),
                const SizedBox(width: 25),
              ],
              Flexible(child: _StartRestButton(state)),
              if (!state.total.isStopped) ...[
                const SizedBox(width: 25),
                const _StopIcon(),
              ]
            ],
          ),
        ),
      );
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
  const _StartRestButton(this.state);

  final ({LadderState ladder, TotalState total}) state;

  @override
  Widget build(BuildContext context, WidgetRef ref) => CustomButton(
        onPressed: state.total.isStopped ? provider(ref).startLadder : provider(ref).rest,
        actionable: state.total.isStopped ? true : state.ladder.isTraining && state.total.isRunning,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(state.total.isStopped ? L10nR.tStart(ref) : L10nR.tRest(ref)),
        ),
      );

  HomeProvider provider(WidgetRef ref) => ref.read(homeProvider);
}
