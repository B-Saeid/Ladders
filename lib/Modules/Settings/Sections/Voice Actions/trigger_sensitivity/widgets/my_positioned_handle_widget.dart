part of '../tile.dart';

class _MyPositionedHandle extends ConsumerWidget {
  final double width;
  final double maxExtent;

  const _MyPositionedHandle({
    required this.width,
    required this.maxExtent,
  });

  bool enabled(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.enableVoiceActions || p.restOnlyTrigger),
      );

  double get stackX {
    final rb = _SensitivityGauge.stackGlobalKey.currentContext!.findRenderObject() as RenderBox;
    final stackPosition = rb.localToGlobal(Offset.zero);
    return stackPosition.dx;
  }

  // static bool dragUpdate = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // if (dragUpdate) dragUpdate = false;
    // if (!dragUpdate) {
    //   Future(
    //     () => ref.read(startMarginProvider(handleExtent).notifier).maintainPercentage(handleExtent),
    //   );
    // }
    // ref.listen(
    //   LiveData.scalePercentageSelector,
    //   (_, __) {
    //     print('====== scalePercentageSelector listen is called ');
    //     ref.read(startMarginProvider.notifier).maintainPercentage(gaugeWidth, handleWidth);
    //   },
    // );
    final textDirection = Directionality.of(context);
    // final a = ref.watch(startMarginProvider(maxExtent));
    return AnimatedPositionedDirectional(
      duration: 350.milliseconds,
      curve: Curves.easeInOutCubicEmphasized,
      top: 0.85 * width,
      // start: width - handleWidth,
      // end: 0,
      // start: 0,
      start: ref.watch(handlePositionProvider(maxExtent)),
      // start: gaugeWidth,
      // start: width - handleWidth / 2,
      // textDirection: textDirection,
      // child: GestureDetector(
      //   onTapDown: (details) {
      //     final renderBox = stackGlobalKey.currentContext!.findRenderObject() as RenderBox;
      //     final position = renderBox.localToGlobal(Offset.zero);
      //     final globalX = position.dx;
      //     print('globalX $globalX');
      //     final xg = details.globalPosition.dx;
      //     final xl = details.localPosition.dx;
      //     // final xd = details.delta.dx;
      //
      //     // print('globalPosition = $xg ');
      //     // print('localPosition = $xl ');
      //     // print('delta = $xd ');
      //     // print('globalPosition = $xg \n localPosition = $xl \n delta = $xd\n');
      //     setState(() {
      //       startMargin = xg;
      //       print('startMargin = $startMargin');
      //       // final toValue = startMargin + xl;
      //       // print('toValue = $toValue');
      //       // print('startMargin = $startMargin');
      //       // if (xl.isNegative /*i.e. from right to left*/) {
      //       //   if (textDirection.isRTL) {
      //       //     startMargin = min(width - handleWidth, xg + xl.abs());
      //       //   } else {
      //       //     startMargin = max(0, xg + xl);
      //       //   }
      //       // } else {
      //       //   if (textDirection.isLTR) {
      //       //     startMargin = min(width - handleWidth, xg + xl.abs());
      //       //   } else {
      //       //     startMargin = max(0, xg + xl);
      //       //   }
      //       // }
      //     });
      //   },
      //   onPanUpdate: (details) {
      //     final renderBox = stackGlobalKey.currentContext!.findRenderObject() as RenderBox;
      //     final position = renderBox.localToGlobal(Offset.zero);
      //     final globalX = position.dx;
      //     print('globalX $globalX');
      //     final xg = details.globalPosition.dx;
      //     final xl = details.localPosition.dx;
      //     final xd = details.delta.dx;
      //     // final xd = details.delta.dx;
      //
      //     // print('globalPosition = $xg ');
      //     // print('localPosition = $xl ');
      //     // print('delta = $xd ');
      //     // print('globalPosition = $xg \n localPosition = $xl \n delta = $xd\n');
      //     setState(() {
      //       startMargin = xg;
      //       print('startMargin = $startMargin');
      //       // final toValue = startMargin + xl;
      //       // print('toValue = $toValue');
      //       // print('startMargin = $startMargin');
      //       // if (xl.isNegative /*i.e. from right to left*/) {
      //       //   if (textDirection.isRTL) {
      //       //     startMargin = min(width - handleWidth, xg + xl.abs());
      //       //   } else {
      //       //     startMargin = max(0, xg + xl);
      //       //   }
      //       // } else {
      //       //   if (textDirection.isLTR) {
      //       //     startMargin = min(width - handleWidth, xg + xl.abs());
      //       //   } else {
      //       //     startMargin = max(0, xg + xl);
      //       //   }
      //       // }
      //     });
      //   },
      //   child: MyHandle(
      //     size: handleWidth,
      //   ),
      //
      //   // child: const SizedBox(),
      // ),
      child: GestureDetector(
        // onTap: () {
        //   final stackRenderBox = stackGlobalKey.currentContext!.findRenderObject() as RenderBox;
        //   final stackPosition = stackRenderBox.localToGlobal(Offset.zero);
        //   final stackX = stackPosition.dx;
        //   print('Stack X $stackX');
        //   final handleRenderBox = handleGlobalKey.currentContext!.findRenderObject() as RenderBox;
        //   final handlePosition = handleRenderBox.localToGlobal(Offset.zero);
        //   final handleX = handlePosition.dx;
        //   print('handle X $handleX');
        //   print('width = $width');
        //   print('gaugeWidth = $gaugeWidth');
        //   print('handleWidth = $handleWidth');
        //   print('1/2 handleWidth = ${handleWidth / 2}');
        // },
        child: Draggable(
          axis: Axis.horizontal,
          affinity: Axis.horizontal,
          onDragUpdate: (details) {
            // print('OFF ${details.globalPosition.dx}');
            final xPosition = details.globalPosition.dx - width / 2;
            print('xPosition $xPosition');
            final offset = xOffset(xPosition, stackX, textDirection);
            print('OFFSET $offset');
            print('Percentage ${offset / maxExtent}');
            ref.read(triggerPercentageProvider.notifier).state = offset / maxExtent;
          },
          onDragEnd: (details) {
            print('END ----- OFF ${details.offset.dx}');
            final offset = xOffset(details.offset.dx, stackX, textDirection);
            _setStartMargin(ref, offset);
            // ref.read(startMarginProvider(handleExtent).notifier).setPercentage(gaugeWidth, handleWidth);
          },
          // dragAnchorStrategy: pointerDragAnchorStrategy,
          childWhenDragging: MyHandle(
            width: width,
            color: AppColors.primary.withOpacity(0.5),
          ),

          /// All three tries did not work... the widget remained the same
          // maxSimultaneousDrags:
          //     ref.watch(percentageProvider) < 0 || ref.watch(percentageProvider) > 1 ? 0 : 1,
          feedback: /*ref.watch(percentageProvider) < 0 || ref.watch(percentageProvider) > 1
              ? const SizedBox()
              : */
              Opacity(
            opacity: 0.5,

            /// opacity:ref.watch(percentageProvider) < 0 || ref.watch(percentageProvider) > 1 ? 0.0 :
            /// 0.5,
            child: MyHandle(width: width),
          ),
          child: MyHandle(
            // key: handleGlobalKey,
            width: width,
            color: enabled(ref) ? null : LiveData.themeData(ref).disabledColor,
          ),
          // child: const SizedBox(),
        ),
      ),
    );
  }

  double xOffset(double globalX, double stackX, TextDirection textDirection) => switch (textDirection) {
        TextDirection.ltr => globalX - stackX,
        TextDirection.rtl => stackX + maxExtent - globalX
      };

  void _setStartMargin(WidgetRef ref, double xOffset) {
    final double newValue = max(
      0,
      min(maxExtent, xOffset),
    );
    final currentMic = ref.read(settingProvider).microphone;
    ref.read(handlePositionProvider(maxExtent).notifier).update(newValue, currentMic?.id);
    ref.read(triggerPercentageProvider.notifier).state = newValue / maxExtent;
  }
}
