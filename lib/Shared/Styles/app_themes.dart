import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/assets_strings.dart';
import 'app_colors.dart';

abstract class LaddersStyles {
  /// Nice Customization and Tinkering
  // static final themeAnimationStyle = AnimationStyle(
  //   curve: Curves.easeInOutCubicEmphasized,
  //   duration: 2.seconds,
  // );

  static ThemeData get light => ThemeData(
        colorSchemeSeed: AppColors.primary,
        // fontFamily: _topLevelFamily,
        fontFamily: AssetFonts.cairo,

        /// T O D O : Semi DONE!  BUG cupertinoButton does not reed font family
        /// Not all widgets read it ... for example [CupertinoDialogAction] I have to set
        /// the textStyle Manually but for [CupertinoTextButton] It reads the textStyle
        /// property defined below.
        cupertinoOverrideTheme: _cupertinoThemeData,
      );

  static CupertinoThemeData get _cupertinoThemeData => const CupertinoThemeData(
        applyThemeToAll: true,
        textTheme: CupertinoTextThemeData(
          textStyle: _overriddenFontFamilyStyle,
          actionTextStyle: _overriddenFontFamilyStyle,
          dateTimePickerTextStyle: _overriddenFontFamilyStyle,
          navActionTextStyle: _overriddenFontFamilyStyle,
          navLargeTitleTextStyle: _overriddenFontFamilyStyle,
          navTitleTextStyle: _overriddenFontFamilyStyle,
          pickerTextStyle: _overriddenFontFamilyStyle,
          tabLabelTextStyle: _overriddenFontFamilyStyle,
        ),
      );

  static const TextStyle _overriddenFontFamilyStyle = TextStyle(fontFamily: AssetFonts.cairo);

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: AppColors.primary,
        // fontFamily: _topLevelFamily,
        fontFamily: AssetFonts.cairo,
        // textTheme: ThemeData.dark().textTheme.copyWith(displaySmall: const TextStyle(fontWeight: FontWeight.w800))
        cupertinoOverrideTheme: _cupertinoThemeData,
      );

// static String? get _topLevelFamily {
//   print('_topLevelFamily CALLED');
//   final locale = L10nService.localeSettings.locale;
//   if (locale == null) return null;
//   // return null;
//
//   final supportedLocale = SupportedLocale.getFrom(locale);
//   return switch (supportedLocale) {
//     SupportedLocale.ar => AssetFonts.cairo,
//     SupportedLocale.en => AssetFonts.cairo, // Todo : You may LATER want to change that
//     // SupportedLocale.en => AssetFonts.montserrat,
//   };
// }
  ///
// final currentLocale = context.read<L10nProvider>().localeSettings.locale;
// if (currentLocale == LocaleSetting.arabic.locale) {
//   return AssetFonts.cairo;
// } else {
//   return null;
// }
}
