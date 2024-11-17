import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';

class MyWheel extends ConsumerWidget {
  final int min;
  final int max;
  final void Function(int) action;
  final FixedExtentScrollController controller;
  final bool actOnlyOnScrollEnd;

  const MyWheel({
    super.key,
    required this.min,
    required this.max,
    required this.action,
    required this.controller,
    this.actOnlyOnScrollEnd = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          /// This if you want to ONLY setStartCount when scroll end
          if (actOnlyOnScrollEnd) {
            if (notification is ScrollEndNotification) {
              final x = notification.metrics;
              if (x is FixedExtentMetrics) action(x.itemIndex + min);

              /// Alternatively you can use the controller
              // ref.read(settingProvider).setStartCount(controller.selectedItem + min)
            }
          }

          return true;
        },
        child: SizedBox(
          height: 200.scalable(ref, maxFactor: 2, allowBelow: false),
          child: CupertinoPicker(
            selectionOverlay: Stack(
              alignment: Alignment.center,
              children: [
                const CupertinoPickerDefaultSelectionOverlay(),
                Container(
                  padding: EdgeInsetsDirectional.only(
                    start: 100.scalable(
                      ref,
                      maxValue: LiveData.deviceWidth(ref) * 0.6,
                    ),
                  ),
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    L10nR.tSec(ref),
                    style: LiveData.textTheme(ref).titleLarge,
                  ),
                )
              ],
            ),
            itemExtent: 40.scalable(ref),
            scrollController: controller,

            /// This will setStartCount during scrolls and during ballistic flings.
            /// which makes your app feels more responsive.
            onSelectedItemChanged: actOnlyOnScrollEnd ? null : (value) => action(value + min),
            children: List.generate(
              max - min + 1,
              (index) => Center(
                child: Text(
                  (index + min).toString(),
                  style: LiveData.textTheme(ref).titleLarge!,
                ),
              ),
            ),
          ),
        ),
      );
}
