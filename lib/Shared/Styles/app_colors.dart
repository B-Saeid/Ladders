import 'package:flutter/material.dart';

import '../Services/Database/Hive/hive_service.dart';

abstract class AppColors {

  /// In September 2019 Dark mode was introduced by Android 10 Q (API 29) and iOS 13
  /// This line is to show automatic themeMode is Android 10 and above
  /// Note: We are not checking on iOS as we do not support iOS below 13
  /// however we support from Android 6 (API 23)
  static bool get isDarkModeSupported => (HiveService.androidInfo?.sdkVersion ?? 30) >= 29;

  static TextStyle? positiveChoiceStyle(BuildContext context, {bool bold = true}) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: primary,
          );

  static TextStyle? negativeChoiceStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(color: negativeColor(context));

  static Color negativeColor(BuildContext context) => Theme.of(context).colorScheme.error;

  static bool isLight(BuildContext context) => Theme.of(context).brightness == Brightness.light;

  static const primary = Color(0xFF3c6ab3);

  static LinearGradient opacityGradient([Color? color, (double from, double to)? bounds]) =>
      LinearGradient(
        colors: [
          (color ?? AppColors.primary).withOpacity(bounds?.$1 ?? 0.15),
          (color ?? AppColors.primary).withOpacity(bounds?.$2 ?? 0.05),
        ],
        begin: AlignmentDirectional.topStart,
        end: AlignmentDirectional.bottomEnd,
      );

  static Color adaptivePrimary(BuildContext context) =>
      isLight(context) ? const Color(0xff88b2ff) : const Color(0xFF3c6ab3);

  static Color get green => Colors.green.shade700;

  static Color get greenLight => Colors.green.shade400;

  static Color adaptiveGreen(BuildContext context) =>
      isLight(context) ? Colors.green.shade400 : Colors.green.shade700;

  static Color get grey => const Color(0xff4b4b4b);

  static Color get greyLight => const Color(0xffd2d2d2);

  static Color adaptiveGrey(BuildContext context) =>
      isLight(context) ? const Color(0xffd2d2d2) : const Color(0xff4b4b4b);

  static Color get yellow => const Color(0xffb3973c);

  static Color get yellowLight => const Color(0xfffff799);

  static Color adaptiveYellow(BuildContext context) =>
      isLight(context) ? const Color(0xfffff799) : const Color(0xffb3973c);

  static Color get red => const Color(0xffb33c3c);

  static Color get redLight => const Color(0xffff9999);

  static Color adaptiveRed(BuildContext context) =>
      isLight(context) ? const Color(0xffff9999) : const Color(0xffb33c3c);

  static Color textField(BuildContext context) => isLight(context) ? Colors.white : Colors.grey.shade800;

  static Color emojiRowThemed(BuildContext context) => isLight(context) ? Colors.grey : Colors.black87;

  static Color scaffoldBackground(BuildContext context) => Theme.of(context).scaffoldBackgroundColor;
}
