import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Extensions/time_package.dart';
import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Widgets/text_container.dart';
import '../../../Shared/Extensions/on_num.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/custom_animated_size.dart';
import '../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../provider/home_provider.dart';
import '../utilities/enums.dart';

class LadderTimerScrollWheels extends ConsumerWidget {
  const LadderTimerScrollWheels({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const _SetTotalTimeText(),
        SizedBox(
          height: 300.scalable(ref, maxValue: 450),
          width: 250.scalable(ref, maxValue: 400),
          child: const Row(
            children: [
              Expanded(child: _ZeroTo59Wheel(isMinute: true)),
              _PaddedColon(),
              Expanded(child: _ZeroTo59Wheel(isMinute: false)),
            ],
          ),
        ),
      ],
    );
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
        builder: (_, state, __) => ListWheelScrollView.useDelegate(
          physics:
              state.isStopped ? const FixedExtentScrollPhysics() : const NeverScrollableScrollPhysics(),
          controller: isMinute
              ? ref.read(homeProvider).minuteController
              : ref.read(homeProvider).secondController,
          diameterRatio: 0.6,
          itemExtent: _itemExtent(ref),
          onSelectedItemChanged:

              /// This [state.isStopped] condition is added to fix an illusive bug:
              /// when text scale is CHANGED while the timer is running or paused
              /// i.e. when the wheel is set to [NeverScrollableScrollPhysics]
              /// the onSelectedItemChanged gets called as the wheel naturally
              /// centers/select another item since the [_itemExtent] is responsive.
              ///
              /// Another solution [Bad One] is to set itemExtent with a constant value
              state.isStopped
                  ? isMinute
                      ? (index) => ref.read(homeProvider).setMinute(index)
                      : (index) => ref.read(homeProvider).setSecond(index)
                  : null,

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
      );

  double _itemExtent(WidgetRef ref) => 50.scalable(
        ref,
        allowBelow: false,
        maxPercentage: 2,
      );
}

class _Item extends ConsumerWidget {
  const _Item(this.index, {required this.isMinute, required this.stopped});

  final int index;
  final bool isMinute;
  final bool stopped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelected = ref.watch(homeProvider.select(
      (value) => isMinute ? value.minute : value.second,
    ));
    return AnimatedContainer(
      duration: 400.milliseconds,
      curve: Curves.easeInOutCubic,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: stopped
          ? ShapeDecoration(
              color:
                  currentSelected == index ? LiveData.themeData(ref).colorScheme.inversePrimary : null,
              shape: const StadiumBorder(),
            )
          : null,
      child: FittedBox(
        child: Text(
          index.padLeftSingles,
          textAlign: TextAlign.center,
          style: LiveData.textTheme(ref).displaySmall,
        ),
      ),
    );
  }
}

class _PaddedColon extends ConsumerWidget {
  const _PaddedColon();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          ':',
          style: LiveData.textTheme(ref).displaySmall,
        ),
      );
}
