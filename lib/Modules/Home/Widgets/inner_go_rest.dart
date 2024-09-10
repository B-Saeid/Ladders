import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Extensions/time_package.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Styles/app_colors.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/custom_animated_size.dart';
import '../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../provider/home_provider.dart';

class InnerGoRestCycles extends ConsumerWidget {
  const InnerGoRestCycles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Selector(
        selector: homeProvider.select((p) => (total: p.totalState, ladder: p.ladderState)),
        builder: (_, state, child) => CustomAnimatedSize(
          child: state.total.isStopped
              ? const SizedBox()
              : Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20.scalable(ref, maxPercentage: 2),
                        child: state.total.isPaused
                            ? AdaptiveIcons.wFlatBar(ref: ref)
                            : state.ladder.isTraining
                                ? AdaptiveIcons.wTraining(ref: ref)
                                : AdaptiveIcons.wResting(ref: ref),
                      ),
                      SizedBox(height: 20.scalable(ref, maxPercentage: 2)),
                      Card.filled(
                        margin: EdgeInsets.zero,
                        shape: const StadiumBorder(side: BorderSide()),
                        color: state.ladder.isTraining ? AppColors.adaptiveBlue(ref) : null,
                        child: child!,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
        ),
        child: const _GoRestTimer(),
      );
}

class _GoRestTimer extends ConsumerWidget {
  const _GoRestTimer();

  @override
  Widget build(BuildContext context, WidgetRef ref) => LayoutBuilder(builder: (context, constraints) {
        final hPadding = 30.scalable(ref, maxValue: 50);
        final freeWidth = constraints.maxWidth - hPadding * 2;
        final twoDigitMaxWidth = _calculateWidth('00').scalable(
          ref,
          maxValue: (freeWidth / 20) * 6,
        );
        final colonWidth = _calculateWidth(':').scalable(
          ref,
          maxValue: freeWidth / 20,
        );
        return Container(
          height: min(60.scalable(ref), freeWidth / 2.5),
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          child: ValueListenableBuilder(
            valueListenable: ref.read(homeProvider).timerDuration,
            builder: (_, value, __) {
              final (mintue, second, moment) = value.nMMnSSnFF;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: twoDigitMaxWidth,
                    child: FittedBox(
                      child: Text(
                        mintue,
                        style: LiveData.textTheme(ref).displaySmall!.copyWith(letterSpacing: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: colonWidth,
                    child: FittedBox(
                      child: Text(
                        ':',
                        style: LiveData.textTheme(ref).displaySmall!.copyWith(letterSpacing: 2),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: twoDigitMaxWidth,
                    child: FittedBox(
                      child: Text(
                        second,
                        style: LiveData.textTheme(ref).displaySmall!.copyWith(letterSpacing: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: colonWidth,
                    child: FittedBox(
                      child: Text(
                        ':',
                        style: LiveData.textTheme(ref).displaySmall!.copyWith(letterSpacing: 2),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: twoDigitMaxWidth,
                    child: FittedBox(
                      child: Text(
                        moment,
                        style: LiveData.textTheme(ref).displaySmall!.copyWith(letterSpacing: 2),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      });

  static double _calculateWidth(String value) {
    final textSpan = TextSpan(
      text: value,
      style: StaticData.textTheme.displaySmall!.copyWith(letterSpacing: 2),
    );
    final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
    return tp.width;
  }
}
