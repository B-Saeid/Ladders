import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../Shared/Services/l10n/l10n_service.dart';

final settingProvider = ChangeNotifierProvider((_) => SettingsProvider());

class SettingsProvider extends ChangeNotifier {
  /// Language
  /// NOTE : In here we initialize a class property with a late property of another class
  /// Since [SettingsProvider] is not abstract and It is crated in the [MultiProviders]
  /// and Since we DO INITIALIZE THAT late property BEFORE [runApp] is called
  /// i.e. before [SettingsProvider] is created .. SO IT is Safe and OK IN THIS CASE.
  LocaleSetting localeSettings = LocaleSetting.auto;

  void setLocaleSetting(LocaleSetting newSetting) {
    HiveService.settings.put(SettingsKeys.locale, newSetting.name);
    final notInitialized = !L10nService.initialized;
    if (newSetting != localeSettings || notInitialized) {
      localeSettings = newSetting;
      notifyListeners();
    }
  }

  /// ThemeMode
  ThemeMode themeMode = _initThemeMode();

  static ThemeMode _initThemeMode() {
    final storedValue = HiveService.settings.get(SettingsKeys.themeMode);
    final storedThemeMode = ThemeMode.values.firstWhereOrNull((e) => e.name == storedValue);
    return storedThemeMode ?? ThemeMode.system;
  }

  void setThemeMode(ThemeMode newMode) {
    if (themeMode != newMode) {
      HiveService.settings.put(SettingsKeys.themeMode, newMode.name);
      themeMode = newMode;
      notifyListeners();
    }
  }
}
