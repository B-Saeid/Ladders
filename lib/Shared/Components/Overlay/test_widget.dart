import 'dart:math';

import 'package:flutter/material.dart';

import '../../Constants/global_constants.dart';
import '../../Extensions/on_strings.dart';
import '../../Extensions/time_package.dart';
import '../../Widgets/buttons.dart';
import '../Toast/toast.dart';
import 'overlay.dart';

class MyOverlayTestWidget extends StatelessWidget {
  const MyOverlayTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testing Overlays')),
      body: Center(
        child: Padding(
          padding: GlobalConstants.screensHPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: MyPriority.values
                .map(
                  (e) => Center(
                    child: CustomButton.adaptive(
                        onPressed: () {
                          switch (e) {
                            case MyPriority.regular:
                              MyOverlay.showTimed(
                                content: const Text(
                                  '"regular" I am a regular customer I wait on the line',
                                ),
                              );
                            case MyPriority.ifEmpty:
                              MyOverlay.showTimed(
                                content: const Text(
                                  '"ifEmpty" I have autism I only show a lone',
                                ),
                                priority: MyPriority.ifEmpty,
                              );
                            case MyPriority.noRepeat:
                              MyOverlay.showTimed(
                                content: Text(
                                  '"noRepeat" I can not be repeated ${pi.toStringAsFixed(2)}',
                                ),
                                priority: MyPriority.noRepeat,
                              );
                            case MyPriority.nowNoRepeat:
                              MyOverlay.showTimed(
                                content: const Text(
                                  '"nowNoRepeat" I show now and can not be repeated',
                                ),
                                priority: MyPriority.nowNoRepeat,
                              );
                            case MyPriority.now:
                              MyOverlay.showTimed(
                                content: const Text(
                                  '"now" Arrogantly Showing Now and continue serve the queue',
                                ),
                                priority: MyPriority.now,
                              );
                            case MyPriority.replaceAll:

                              final closeHandler = MyOverlay.show(
                                showCloseIcon: true,
                                content: const Text(
                                  '"replaceAll" The Destroyer show Me and cancel any one else',
                                ),
                              );

                              2.seconds.delay.then((value) {
                                // Toast.show('hapooe');
                                2.seconds.delay.then((value) {
                                  // closeHandler.call();
                                });
                              },);
                          }
                        },
                        child: e.name.upperFirstLetter.upperFirstLetter),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
