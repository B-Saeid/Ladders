import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Extensions/time_package.dart';
import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Extensions/on_num.dart';
import '../../../Shared/Services/l10n/l10n_service.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/custom_animated_size.dart';
import '../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../../Shared/Widgets/scale_controlled_text.dart';
import '../../../Shared/Widgets/text_container.dart';
import '../provider/home_provider.dart';
import '../utilities/enums.dart';

class LadderTimerScrollWheels extends ConsumerWidget {
  const LadderTimerScrollWheels({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const _SetTotalTimeText(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 350.scalable(ref, maxValue: 500),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            children: [
              Flexible(child: _ZeroTo59Wheel(isMinute: true)),
              _PaddedColon(),
              Flexible(child: _ZeroTo59Wheel(isMinute: false)),
            ],
          ),
        ),
      ],
    );
  }
}

class _Unit extends ConsumerWidget {
  const _Unit(this.isMinute);

  final bool isMinute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = LiveData.textTheme(ref).titleLarge!;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: ScaleControlledText(
        isMinute ? L10nR.tMin(ref) : L10nR.tSec(ref),
        style: style,
        maxPercentage: 2,
        sizeWrapString: _getLarger(ref, style),
      ),
    );
  }

  String _getLarger(WidgetRef ref, TextStyle style) {
    final minuteStringWidth = L10nR.tMin(ref).getWidth(style);
    final secondStringWidth = L10nR.tSec(ref).getWidth(style);
    return minuteStringWidth < secondStringWidth ? L10nR.tSec(ref) : L10nR.tMin(ref);
  }
}

class _SetTotalTimeText extends ConsumerWidget {
  const _SetTotalTimeText();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Selector(
        selector: homeProvider.select((value) => value.totalState.isStopped),
        builder: (_, isStopped, child) => CustomAnimatedSize(
          child: isStopped ? child! : const SizedBox(),
        ),
        child: TextContainer(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: FittedBox(
            child: Text(
              L10nR.tSetTotalTime(ref),
              style: LiveData.textTheme(ref).titleLarge,
            ),
          ),
        ),
      );
}

class _ZeroTo59Wheel extends ConsumerWidget {
  const _ZeroTo59Wheel({required this.isMinute});

  final bool isMinute;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Selector<TotalState>(
        selector: homeProvider.select((p) => p.totalState),
        builder: (_, state, child) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 3,
              child: ListWheelScrollView.useDelegate(
                physics: state.isStopped
                    ? const FixedExtentScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                controller: isMinute
                    ? ref.read(homeProvider).minuteController
                    : ref.read(homeProvider).secondController,
                diameterRatio: 0.6,
                itemExtent: _itemExtent(ref),
                useMagnifier: true,
                overAndUnderCenterOpacity: 0.3,
                magnification: 1.15,
                onSelectedItemChanged:

                    /// Solved By calling [refreshPositions] whenever a scale occurs
                    /// i.e. when [_itemExtent] is called
                    isMinute
                        ? (index) => ref.read(homeProvider).setMinute(index)
                        : (index) => ref.read(homeProvider).setSecond(index),

                /// Super SWEET [ListWheelChildLoopingListDelegate]
                /// instead of plain [children] of ListWheelScrollView()
                childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                    60,
                    (index) => _Item(
                      index,
                      isMinute: isMinute,
                      stopped: state.isStopped,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(flex: 2, child: child!),
          ],
        ),
        child: _Unit(isMinute),
      );

  double _itemExtent(WidgetRef ref) {
    Future(ref.read(homeProvider).refreshPositions);
    return 50.scalable(
      ref,
      allowBelow: false,
      maxPercentage: 2,
    );
  }
}

class _Item extends ConsumerWidget {
  const _Item(this.index, {required this.isMinute, required this.stopped});

  final int index;
  final bool isMinute;
  final bool stopped;

  @override
  Widget build(BuildContext context, WidgetRef ref) => AnimatedContainer(
        duration: 400.milliseconds,
        curve: Curves.easeInOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        child: FittedBox(
          child: Text(
            index.padLeftSingles,
            textAlign: TextAlign.center,
            style: LiveData.textTheme(ref).displaySmall,
          ),
        ),
      );
}

class _PaddedColon extends ConsumerWidget {
  const _PaddedColon();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ScaleControlledText(
          ':',
          style: LiveData.textTheme(ref).displaySmall,
          maxPercentage: 1.5,
        ),
      );
}
