part of '../toast.dart';

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
