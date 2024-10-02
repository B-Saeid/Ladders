import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Styles/app_colors.dart';
import '../../Utilities/SessionData/session_data.dart';
import '../../Widgets/riverpod_helper_widgets.dart';
import '../Overlay/overlay.dart';

export '../Overlay/overlay.dart';

part 'parts/enum.dart';
part 'parts/message_wrapper.dart';

abstract class Toast {
  static VoidCallback? _show({
    required Object message,
    required Duration duration,
    required MyGravity gravity,
    required _ToastState toastState,
    required bool ignorePointer,
    required bool dismissOnTap,
    required MyPriority priority,
  }) {
    try {
      return MyOverlay.showTimed(
        id: message.hashCode,
        child: _MessageWrapper(toastState, message),
        duration: duration,
        gravity: gravity,
        ignorePointer: ignorePointer,
        dismissOnTap: dismissOnTap,
        priority: priority,
      );
      // }
    } catch (error, stackTrace) {
      print(
        '===== TOAST ^ & & & & ^ ERROR ====== ${error.toString()}\n'
        'With Trace >> : $stackTrace',
      );
      return null;
    }
  }

  /// [showLive] is used to show a live value of text as updates on toast
  /// using a ValueNotifier<String> as the message instead of String.
  ///
  /// It's useful when you want to show to the user continuous updates.
  ///
  /// We primarily implemented it to show a live value of recognized text from user speech.
  static VoidCallback? showLive(
    ValueNotifier<String> message, {
    Duration duration = const Duration(minutes: 1),
    MyGravity gravity = MyGravity.bottomSafe,
    bool ignorePointer = false,
    bool dismissOnTap = false,
    MyPriority priority = MyPriority.now,
  }) =>
      _show(
        message: message,
        duration: duration,
        gravity: gravity,
        toastState: _ToastState.regular,
        ignorePointer: ignorePointer,
        dismissOnTap: dismissOnTap,
        priority: priority,
      );

  static void show(
    String message, {
    Duration duration = const Duration(seconds: 2),
    MyGravity gravity = MyGravity.bottomSafe,
    bool ignorePointer = false,
    bool dismissOnTap = true,
    MyPriority priority = MyPriority.nowNoRepeat,
  }) =>
      _show(
          message: message,
          duration: duration,
          gravity: gravity,
          toastState: _ToastState.regular,
          ignorePointer: ignorePointer,
          dismissOnTap: dismissOnTap,
          priority: priority);

  static void showWarning(
    String message, {
    Duration duration = const Duration(seconds: 3),
    MyGravity gravity = MyGravity.bottomSafe,
    bool ignorePointer = false,
    bool dismissOnTap = true,
    MyPriority priority = MyPriority.now,
  }) =>
      _show(
        message: message,
        duration: duration,
        gravity: gravity,
        toastState: _ToastState.warning,
        ignorePointer: ignorePointer,
        dismissOnTap: dismissOnTap,
        priority: priority,
      );

  static void showError(
    String message, {
    Duration duration = const Duration(seconds: 3),
    MyGravity gravity = MyGravity.bottomSafe,
    bool ignorePointer = false,
    bool dismissOnTap = true,
    MyPriority priority = MyPriority.now,
  }) =>
      _show(
        message: message,
        duration: duration,
        gravity: gravity,
        toastState: _ToastState.error,
        ignorePointer: ignorePointer,
        dismissOnTap: dismissOnTap,
        priority: priority,
      );

  static void showSuccess(
    String message, {
    Duration duration = const Duration(seconds: 2),
    MyGravity gravity = MyGravity.bottomSafe,
    bool ignorePointer = false,
    bool dismissOnTap = true,
    MyPriority priority = MyPriority.nowNoRepeat,
  }) =>
      _show(
        message: message,
        duration: duration,
        gravity: gravity,
        toastState: _ToastState.success,
        ignorePointer: ignorePointer,
        dismissOnTap: dismissOnTap,
        priority: priority,
      );
}
