import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Services/Database/Hive/hive_service.dart';
import '../Utilities/SessionData/session_data.dart';

abstract class AppColors {
  /// In September 2019 Dark mode was introduced by Android 10 Q (API 29) and iOS 13
  /// This line is to show automatic themeMode is Android 10 and above
  /// Note: We are not checking on iOS as we do not support iOS below 13
  /// however we support from Android 6 (API 23)
  static bool get isDarkModeSupported => (HiveService.androidInfo?.sdkVersion ?? 30) >= 29;

  static TextStyle? positiveChoiceStyle(WidgetRef ref, {bool bold = true}) =>
      LiveData.textTheme(ref).bodyMedium?.copyWith(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: primary,
          );

  static TextStyle? negativeChoiceStyle(WidgetRef ref) =>
      LiveData.textTheme(ref).bodyMedium?.copyWith(color: negativeColor(ref));

  static Color negativeColor(WidgetRef ref) => LiveData.themeData(ref).colorScheme.error;
  static Color whileDarkLightBlack(WidgetRef ref) => LiveData.isLight(ref) ? Colors.black:Colors.white;

  static const primary = Color(0xff55361f);

  static LinearGradient opacityGradient([Color? color, (double from, double to)? bounds]) =>
      LinearGradient(
        colors: [
          (color ?? AppColors.primary).withOpacity(bounds?.$1 ?? 0.15),
          (color ?? AppColors.primary).withOpacity(bounds?.$2 ?? 0.05),
        ],
        begin: AlignmentDirectional.topStart,
        end: AlignmentDirectional.bottomEnd,
      );

  static Color adaptivePrimary(WidgetRef ref) =>
      LiveData.isLight(ref) ? const Color(0xffcc9b76) : const Color(0xff55361f);

  static Color get green => Colors.green.shade700;

  static Color get greenLight => Colors.green.shade400;

  static Color adaptiveGreen(WidgetRef ref) => LiveData.isLight(ref) ? greenLight : green;

  static Color get grey => const Color(0xff4b4b4b);

  static Color get greyLight => const Color(0xffd2d2d2);

  static Color adaptiveGrey(WidgetRef ref) =>
      LiveData.isLight(ref) ? const Color(0xffd2d2d2) : const Color(0xff4b4b4b);

  static Color get yellow => const Color(0xffb3973c);

  static Color get yellowLight => const Color(0xfffff799);

  static Color adaptiveYellow(WidgetRef ref) => LiveData.isLight(ref) ? yellowLight : yellow;

  static Color get red => const Color(0xffb33c3c);

  static Color get redLight => const Color(0xffff9999);

  static Color adaptiveRed(WidgetRef ref) => LiveData.isLight(ref) ? redLight : red;

  static Color get blue => const Color(0xFF3c6ab3);

  static Color get blueLight => const Color(0xff88b2ff);

  static Color adaptiveBlue(WidgetRef ref) => LiveData.isLight(ref) ? blueLight : blue;

  static Color textField(WidgetRef ref) => LiveData.isLight(ref) ? Colors.white : Colors.grey.shade800;

  static Color emojiRowThemed(WidgetRef ref) => LiveData.isLight(ref) ? Colors.grey : Colors.black87;

  static Color scaffoldBackground(WidgetRef ref) => LiveData.themeData(ref).scaffoldBackgroundColor;
}
