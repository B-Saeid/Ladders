import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../Widgets/dialogue.dart';
import '../Database/Hive/hive_service.dart';
import '../Routing/routes_base.dart';
import 'assets/enums.dart';
import 'assets/l10n_resources.dart';

export 'assets/enums.dart';
export 'assets/l10n_resources.dart';

abstract class L10nService {
  static const delegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];

  static const supportedLocales = SupportedLocale.list;

  static late LocaleSetting localeSettings;

  static void init() {
    final cachedSettings = HiveService.settings.get(SettingsKeys.locale);
    print('cachedSettings $cachedSettings');
    final userCachedLocale = LocaleSetting.fromStored(cachedSettings);
    print('userCachedLocale $userCachedLocale');

    /// THIS IS THE ONLY write to [localeSettings] and it happens before [runApp] is called.
    localeSettings = userCachedLocale ?? LocaleSetting.auto;
    print('End localeSettings $localeSettings');
  }

  static Locale? deviceLocale;

  static void initDeviceLocalIfAuto(BuildContext context) {
    if (localeSettings.isAuto) {
      deviceLocale = Localizations.localeOf(context);
    }
  }

  static Locale? handleDeviceLocale() {
    print('deviceLocale $deviceLocale');
    if (deviceLocale == null) {
      // This means no sync until restart
      showRelaunchRequiredDialogue(setting: LocaleSetting.auto);
    }
    return deviceLocale;
  }

  static void showRelaunchRequiredDialogue({required LocaleSetting setting}) {
    final context = RoutesBase.activeContext!; // SWEET LINE

    showAdaptiveDialog(
      context: context,
      builder: (context) => MyDialogue(
        title: L10nR.tNote,
        content: _dialogueContent(setting),
        actionFunction: () => Navigator.of(context).pop(),

        /// TODO : Implement Restart app and give the user option to restart
        actionTitle: L10nR.tOK,
      ),
    );
  }

  static String _dialogueContent(LocaleSetting setting) => L10nR.langSettingRelaunchRequired(setting);
}
