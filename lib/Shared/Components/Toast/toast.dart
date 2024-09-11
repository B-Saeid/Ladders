import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Extensions/time_package.dart';
import '../../Services/Routing/routes_base.dart';
import '../../Styles/app_colors.dart';
import '../../Utilities/SessionData/session_data.dart';
import '../../Widgets/riverpod_helper_widgets.dart';

part 'package.dart';

abstract class Toast {
  static Widget _buildChild(_ToastState toastState, String message) => LayoutBuilder(
        builder: (context, constraints) {
          return RefWidget(
            (ref) => Container(
              constraints: constraints,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              decoration: ShapeDecoration(
                color: toastState.color(ref),
                shape: const StadiumBorder(),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  message,
                  style: LiveData.textTheme(ref).bodyMedium!.copyWith(
                        /// Here we use hard coded color as we know the background color form the sate
                        /// so we know what will look good regardless of theme being dark or light
                        color: toastState == _ToastState.warning
                            ? Colors.black
                            : LiveData.isLight(ref) && toastState == _ToastState.regular
                                ? Colors.black
                                : Colors.white,
                      ),
                ),
              ),
            ),
          );
        },
      );

  static void _show({
    required String message,
    required Duration duration,
    required ToastGravity gravity,
    required _ToastState toastState,
    required ignorePointer,
    required dismissOnTap,
    required ToastPriority priority,
  }) {
    try {
      _ToastPackage.showToast(
        id: message.hashCode,
        child: _buildChild(toastState, message),
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
    }
  }

  static void show(
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastGravity gravity = ToastGravity.bottomSafe,
    bool ignorePointer = false,
    bool dismissOnTap = true,
    ToastPriority priority = ToastPriority.regular,
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
    ToastGravity gravity = ToastGravity.bottomSafe,
    bool ignorePointer = false,
    bool dismissOnTap = true,
    ToastPriority priority = ToastPriority.now,
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
    ToastGravity gravity = ToastGravity.bottomSafe,
    bool ignorePointer = false,
    bool dismissOnTap = true,
    ToastPriority priority = ToastPriority.now,
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
    ToastGravity gravity = ToastGravity.bottomSafe,
    bool ignorePointer = false,
    bool dismissOnTap = true,
    ToastPriority priority = ToastPriority.regular,
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

enum _ToastState {
  regular,
  success,
  warning,
  error;

  Color color(WidgetRef ref) => switch (this) {
        _ToastState.regular => AppColors.adaptiveGrey(ref),
        _ToastState.success => AppColors.primary,
        _ToastState.warning => const Color(0xFFFFC038),
        _ToastState.error => const Color(0xFF980B0B),
      };
}

enum ToastPriority {
  regular,
  ifEmpty,
  noRepeat,
  nowNoRepeat,
  now,
  replaceAll;

  bool get isRegular => this == ToastPriority.regular;

  bool get isIfEmpty => this == ToastPriority.ifEmpty;

  bool get isNoRepeat => this == ToastPriority.noRepeat;

  bool get isNow => this == ToastPriority.now;

  bool get isReplaceAll => this == ToastPriority.replaceAll;
}
