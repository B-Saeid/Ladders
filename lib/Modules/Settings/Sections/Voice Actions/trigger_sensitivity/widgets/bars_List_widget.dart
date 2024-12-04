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
    final partsList = SensitivityConstants._accumulatedPercentageList.map(
      (e) => e * numberOfBars.round(),
    );
    final firstPart = partsList.elementAt(0);
    final reasonablePart = partsList.elementAt(1);
    final b4lastPart = partsList.elementAt(2);

    final Color baseColor;

    if (index <= firstPart) {
      baseColor = Colors.grey;
    } else if (index > firstPart && index < reasonablePart) {
      baseColor = Colors.blue;
    } else if (index >= reasonablePart && index < b4lastPart) {
      baseColor = Colors.lightGreen;
    } else {
      baseColor = Colors.lime;
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
