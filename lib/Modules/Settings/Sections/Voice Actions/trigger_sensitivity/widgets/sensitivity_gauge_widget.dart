part of '../tile.dart';

class _SensitivityGauge extends ConsumerWidget {
  const _SensitivityGauge();

  static final stackGlobalKey = GlobalKey();

  bool barsList(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.useBarsList),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) => LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // print('width = $width');
          final barsHeight = 35.scalable(ref, maxFactor: 1.5);
          final stackHeight = 70.scalable(ref, maxFactor: 1.5);
          final handleWidth = 28.scalable(ref, maxFactor: 1.5);
          final gaugeWidth = width - handleWidth / 2;
          return SizedBox(
            width: width,
            height: stackHeight,
            child: Stack(
              key: stackGlobalKey,
              alignment: AlignmentDirectional.topStart,
              children: [
                if (barsList(ref))
                  _BarsListWidget(
                    height: barsHeight,
                    width: gaugeWidth,
                  )
                else
                  _GradientBoxWidget(
                    height: barsHeight,
                    width: gaugeWidth,
                  ),

                /// This [handleWidth / 2] is To have the tip of the handle
                /// point to the last bar.
                _MyPositionedHandle(
                  width: handleWidth,
                  maxExtent: gaugeWidth - handleWidth / 2,
                ),
                _LimitDullHandle(handleWidth, isStart: true),
                _LimitDullHandle(handleWidth, isStart: false),
              ],
            ),
          );
        },
      );
}
