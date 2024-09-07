import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../Modules/Settings/Provider/setting_provider.dart';
import '../../Extensions/on_context.dart';
import '../Database/Hive/hive_service.dart';
import 'assets/enums.dart';

export 'assets/enums.dart';
export 'assets/l10n_resources.dart';

abstract class L10nService {
  static const delegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];

  static final supportedLocales = SupportedLocale.list;

  static Locale? _deviceLocale;

  static bool _initialized = false;

  static bool get initialized => _initialized;

  static Locale? get deviceLocale => _deviceLocale;

  static void init(BuildContext context) {
    if (deviceLocale == null) _deviceLocale = Localizations.localeOf(context);
    _setCachedSettings(context);
  }

  static void _setCachedSettings(BuildContext context) {
    final cachedSettings = HiveService.settings.get(SettingsKeys.locale);
    print('cachedSettings $cachedSettings');
    final userCachedLocale = LocaleSetting.fromStored(cachedSettings);
    print('userCachedLocale $userCachedLocale');

    context.read(settingProvider).setLocaleSetting(userCachedLocale);
    print('End localeSettings ${context.read(settingProvider).localeSettings}');
    _initialized = true;
  }
}
