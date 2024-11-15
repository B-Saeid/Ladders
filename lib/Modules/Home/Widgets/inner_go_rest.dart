import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Extensions/time_package.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/custom_animated_size.dart';
import '../../../Shared/Widgets/custom_animated_switcher.dart';
import '../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../provider/home_provider.dart';

class InnerGoRestCycles extends ConsumerWidget {
  const InnerGoRestCycles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Selector(
        selector: homeProvider.select((p) => p.totalState),
        builder: (_, totalState, child) => CustomAnimatedSize(
          child: totalState.isStopped
              ? const SizedBox()
              : Center(
                  child: Column(
                    children: [
                      const _IndicatingIcon(),
                      SizedBox(height: 20.scalable(ref, maxFactor: 2)),
                      _TimerCard(child!),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
        ),
        child: const _GoRestTimer(),
      );
}

class _TimerCard extends ConsumerWidget {
  const _TimerCard(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Selector(
        selector: homeProvider.select((p) => p.ladderState),
        builder: (_, ladderState, __) => Card.filled(
          margin: EdgeInsets.zero,
          shape: const StadiumBorder(side: BorderSide()),
          color: ladderState.indicatingColor(ref),
          child: child,
        ),
      );
}

class _IndicatingIcon extends ConsumerWidget {
  const _IndicatingIcon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ladderState = ref.watch(homeProvider.select((p) => p.ladderState));
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 20.scalable(ref, maxFactor: 2),
      child: CustomAnimatedSwitcher(
        child: SizedBox(
          ///  TODO : IMPORTANT TO NOTE
          ///  This is the first time to use keys in a very plausible and convenient way
          ///  https://youtu.be/2W7POjFb88g?t=58
          key: ValueKey(ladderState),
          child: ladderState.indicatingIcon(ref),
        ),
      ),
    );
  }
}

class _GoRestTimer extends ConsumerWidget {
  const _GoRestTimer();

  @override
  Widget build(BuildContext context, WidgetRef ref) => LayoutBuilder(
        builder: (context, constraints) {
          final hPadding = 30.scalable(ref, maxValue: 50);
          final freeWidth = constraints.maxWidth - hPadding * 2;
          final textStyle = LiveData.textTheme(ref).displaySmall!.copyWith(letterSpacing: 2);
          final twoDigitMaxWidth = '00'.getWidth(textStyle).scalable(
                ref,
                maxValue: (freeWidth / 20) * 6,
              );
          final colonWidth = ':'.getWidth(textStyle).scalable(
                ref,
                maxValue: freeWidth / 20,
              );
          return Container(
            height: min(60.scalable(ref), freeWidth / 2.5),
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            child: ValueListenableBuilder(
              valueListenable: ref.read(homeProvider).timerDuration,
              builder: (_, value, __) {
                final (minute, second, moment) = value.nMMnSSnFF;
                return Row(
                  textDirection: TextDirection.ltr,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    twoDigits(twoDigitMaxWidth, minute, textStyle),
                    colon(colonWidth, textStyle),
                    twoDigits(twoDigitMaxWidth, second, textStyle),
                    colon(colonWidth, textStyle),
                    twoDigits(twoDigitMaxWidth, moment, textStyle),
                  ],
                );
              },
            ),
          );
        },
      );

  SizedBox twoDigits(double twoDigitMaxWidth, String digits, TextStyle style) => SizedBox(
        width: twoDigitMaxWidth,
        child: FittedBox(child: Text(digits, style: style)),
      );

  SizedBox colon(double colonWidth, TextStyle style) => SizedBox(
        width: colonWidth,
        child: FittedBox(child: Text(':', style: style)),
      );
}
