import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Modules/Settings/Provider/setting_provider.dart';
import '../Constants/assets_strings.dart';
import '../Services/l10n/l10n_service.dart';
import 'app_colors.dart';

Provider<LaddersStyles> stylesProvider = Provider((ref) => LaddersStyles._(
      ref.watch(settingProvider.select((p) => p.localeSettings.locale)),
    ));

class LaddersStyles {
  LaddersStyles._(this.locale);

  final Locale? locale;

  /// Nice Customization and Tinkering
  // static final themeAnimationStyle = AnimationStyle(
  //   curve: Curves.easeInOutCubicEmphasized,
  //   duration: 2.seconds,
  // );

  late final ThemeData light = ThemeData(
    colorSchemeSeed: AppColors.primary,
    fontFamily: topLevelFamily,

    /// T O D O : Semi DONE!  BUG cupertinoButton does not reed font family
    /// Not all widgets read it ... for example [CupertinoDialogAction] I have to set
    /// the textStyle Manually but for [CupertinoTextButton] It reads the textStyle
    /// property defined below.
    cupertinoOverrideTheme: _cupertinoThemeData,
  );

  CupertinoThemeData get _cupertinoThemeData => CupertinoThemeData(
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

  late final TextStyle _overriddenFontFamilyStyle = TextStyle(fontFamily: topLevelFamily);

  late final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: AppColors.primary,
    fontFamily: topLevelFamily,
    // textTheme: ThemeData.dark().textTheme.copyWith(displaySmall: const TextStyle(fontWeight: FontWeight.w800))
    cupertinoOverrideTheme: _cupertinoThemeData,
  );

  String? get topLevelFamily {
    if (locale == null) return null;

    final supportedLocale = SupportedLocale.fromLocale(locale!);
    return switch (supportedLocale) {
      SupportedLocale.ar => AssetFonts.cairo,
      SupportedLocale.en => AssetFonts.montserrat,
    };
  }

  String? get arabicFontFamily => AssetFonts.cairo;
}
