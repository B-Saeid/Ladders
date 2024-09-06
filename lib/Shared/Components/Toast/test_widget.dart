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
            children: ToastPriority.values
                .map(
                  (e) => Center(
                    child: CustomButton.adaptive(
                        onPressed: () {
                          switch (e) {
                            case ToastPriority.regular:
                              Toast.show('"regular" I am a regular customer I wait on the line');
                            case ToastPriority.ifEmpty:
                              Toast.showSuccess(
                                '"ifEmpty" I have autism I only show a lone',
                                priority: ToastPriority.ifEmpty,
                              );
                            case ToastPriority.noRepeat:
                              Toast.showSuccess(
                                '"noRepeat" I can not be repeated ${pi.toStringAsFixed(2)}',
                                priority: ToastPriority.noRepeat,
                              );
                            case ToastPriority.nowNoRepeat:
                              Toast.showError(
                                '"nowNoRepeat" I show now and can not be repeated',
                                priority: ToastPriority.nowNoRepeat,
                              );
                            case ToastPriority.now:
                              Toast.showWarning(
                                '"now" Arrogantly Showing Now and continue serve the queue',
                                priority: ToastPriority.now,
                              );
                            case ToastPriority.replaceAll:
                              Toast.showError(
                                '"replaceAll" The Destroyer show Me and cancel any one else',
                                priority: ToastPriority.replaceAll,
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
