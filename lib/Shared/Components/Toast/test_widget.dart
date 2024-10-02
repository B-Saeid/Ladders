import 'dart:math';

import 'package:flutter/material.dart';

import '../../Constants/global_constants.dart';
import '../../Extensions/on_strings.dart';
import '../../Widgets/buttons.dart';
import 'toast.dart';

class ToastTestWidget extends StatelessWidget {
  const ToastTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testing Toasts')),
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
                              Toast.show(
                                '"regular" I am a regular customer I wait on the line',
                                priority: MyPriority.regular,
                              );
                            case MyPriority.ifEmpty:
                              Toast.showSuccess(
                                '"ifEmpty" I have autism I only show a lone',
                                priority: MyPriority.ifEmpty,
                              );
                            case MyPriority.noRepeat:
                              Toast.showSuccess(
                                '"noRepeat" I can not be repeated ${pi.toStringAsFixed(2)}',
                                priority: MyPriority.noRepeat,
                              );
                            case MyPriority.nowNoRepeat:
                              Toast.showError(
                                '"nowNoRepeat" I show now and can not be repeated',
                              );
                            case MyPriority.now:
                              Toast.showWarning(
                                '"now" Arrogantly Showing Now and continue serve the queue',
                                priority: MyPriority.now,
                              );
                            case MyPriority.replaceAll:
                              Toast.showError(
                                '"replaceAll" The Destroyer show Me and cancel any one else',
                                priority: MyPriority.replaceAll,
                              );
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
