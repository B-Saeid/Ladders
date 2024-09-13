import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n_service.dart';

enum LocaleSetting {
  auto,
  arabic,
  english;

  Locale? get locale => switch (this) {
        LocaleSetting.auto => L10nService.deviceLocale,
        LocaleSetting.arabic => Locale(SupportedLocale.ar.name),
        LocaleSetting.english => Locale(SupportedLocale.en.name),
      };

  bool get isArabic => this == LocaleSetting.arabic;

  bool get isEnglish => this == LocaleSetting.english;

  bool get isAuto => this == LocaleSetting.auto;

  static LocaleSetting fromStored(value) =>
      LocaleSetting.values.firstWhereOrNull((element) => value == element.name) ?? LocaleSetting.auto;

  String displayName(WidgetRef ref) => L10nR.localeSettingDisplayName(this, ref);
}

enum SupportedLocale {
  ar,
  en;

  static SupportedLocale fromLocale(Locale locale) =>
      SupportedLocale.values.firstWhere((element) => element.name == locale.languageCode);

  String get displayName => switch (this) {
        SupportedLocale.ar => 'العربية',
        SupportedLocale.en => 'English',
      };

  /// If rootApp widget locale is set to null and device locale is set to a locale no in this list
  /// The root app will take the first locale supported AFTER THE MAIN ONE IN DEVICE SETTINGS LIST
  /// and if can't find any IT WILL THEN TAKE THE first locale in THIS list.
  ///
  /// THe above talk is experienced on both iOS 17.4 and Android 10
  static final list = [
    Locale(SupportedLocale.en.name),
    Locale(SupportedLocale.ar.name),
  ];
}
