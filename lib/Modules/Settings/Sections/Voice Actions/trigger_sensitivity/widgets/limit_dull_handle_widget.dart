part of '../tile.dart';

class _LimitDullHandle extends ConsumerWidget {
  const _LimitDullHandle(this.handleWidth, {required this.isStart});

  final double handleWidth;
  final bool isStart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentage = ref.watch(triggerPercentageProvider);
    // final start = percentage < 0;
    // final end = percentage > 1;
    // final show = start || end;
    final show = isStart ? percentage < 0 : percentage > 1;
    return AnimatedPositionedDirectional(
      top: 0.85 * handleWidth,
      start: isStart ? 0 : null,
      // start: start ? 0 : null,
      // end: !end ? 0 : null,
      end: !isStart ? 0 : null,
      duration: 400.milliseconds,
      curve: Curves.easeInOutCubicEmphasized,
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: show ? 0.5 : 0,
          duration: 500.milliseconds,
          curve: Curves.easeInOutCubicEmphasized,
          child: MyHandle(
            width: handleWidth,
            outlined: true,
          ),
        ),
      ),
    );
  }
}
