part of '../tile.dart';

class _BarsListWidget extends ConsumerWidget {
  final double height;
  final double width;

  const _BarsListWidget({
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemExtent = 8.scalable(ref, maxValue: 12);
    final length = width ~/ itemExtent;

    return SizedBox.fromSize(
      size: Size.fromHeight(height),
      child: ListView(
        scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.symmetric(horizontal: handleWidth/2),
        itemExtent: itemExtent,
        children: List.generate(
          length,
          (index) => Container(
            // margin: const EdgeInsetsDirectional.symmetric(horizontal: 0.6),
            decoration: ShapeDecoration(
              shape: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.1,
                  // color: color(index, length),
                ),
              ),
              color: handleColor(
                ref,
                index: index,
                numberOfBars: length,
              ),
            ),
            // duration: 50.milliseconds,
          ),
        ),
      ),
    );
  }

  Color handleColor(
    WidgetRef ref, {
    required int index,
    required int numberOfBars,
  }) {
    final micInput = ref.watch(amplitudeStreamProvider);
    final disabledColor = LiveData.themeData(ref).disabledColor;
    return micInput.when(
      data: (data) {
        if (data == null) return disabledColor;
        final amplitude = data + SensitivityConstants.maxDBValue;
        return /*amplitude == -1
          ? Colors.grey.withOpacity(0.2)
          :*/
            color(
          amplitude,
          index,
          numberOfBars,
        );
      },
      error: (error, stackTrace) {
        print('error $error with $stackTrace');
        return disabledColor;
      },
      loading: () => Colors.green,
    );
  }

  Color color(double amplitude, int index, int numberOfBars) {
    // 20 , 35 , 20 , 15 , 10
    /// These are the END POINTS of the parts
    final firstPart = (0.2 * numberOfBars).floor(); // 20 %
    final secondPart = ((0.2 + 0.35) * numberOfBars).floor(); // 55 %
    final reasonablePart = ((0.2 + 0.35 + 0.2) * numberOfBars).round(); // 75 %
    final b4lastPart = ((0.2 + 0.35 + 0.2 + 0.15) * numberOfBars).floor(); // 90 %

    final Color baseColor;

    if (index <= firstPart) {
      baseColor = Colors.grey;
    } else if (index > firstPart && index < secondPart) {
      baseColor = Colors.blue;
    } else if (index >= secondPart && index < reasonablePart) {
      baseColor = Colors.lightGreen;
    } else if (index >= reasonablePart && index <= b4lastPart) {
      baseColor = Colors.lime;
    } else {
      baseColor = Colors.red;
    }

    final barDBShare = SensitivityConstants.maxDBValue / numberOfBars;

    return baseColor.withOpacity(
      amplitude >= (index + 1) * barDBShare ? 0.9 : 0.1,
    );

    // print('_micInput $_micInput');
    // switch (_micInput) {
    //   case >= -80 && < -60 when index <= firstQuarter:
    //     return baseColor.withOpacity(0.6);
    //   case >= -60 && < -20 when index > firstQuarter && index < lastQuarter:
    //     return baseColor.withOpacity(0.6);
    //   case >= -20 && <= 0 when index >= lastQuarter:
    //     return baseColor.withOpacity(0.6);
    //   default:
    //     return baseColor.withOpacity(0.2);
    // }
    /*if (index >= lastQuarter)*/
  }
}
