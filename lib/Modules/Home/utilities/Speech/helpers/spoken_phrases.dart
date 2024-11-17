import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Shared/Extensions/on_context.dart';
import '../../../../../Shared/Services/Routing/routes_base.dart';
import '../../../../../Shared/Services/l10n/assets/enums.dart';
import '../../../../Settings/Provider/setting_provider.dart';

abstract class L10nSC {
  static SupportedLocale _currentLocale([WidgetRef? ref]) {
    SupportedLocale? locale;
    final context = RoutesBase.activeContext;
    if (ref != null) {
      final settings = ref.watch(settingProvider).localeSettings;
      locale = SupportedLocale.fromLocale(settings.locale!);
    } else if (context != null) {
      final settings = context.read(settingProvider).localeSettings;
      locale = SupportedLocale.fromLocale(settings.locale!);
    }
    return locale ?? SupportedLocale.ar;
  }

  static String tGo([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Go',
        SupportedLocale.ar => 'انْطَلِقْ',
      };

  static String tSTART([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'START',
        SupportedLocale.ar => 'إِبْدَأْ',
      };

  static String tPAUSE([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.ar => 'تَوَقَّفْ',
        SupportedLocale.en => 'PAUSE',
      };

  static String tREST([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.ar => 'راحة',
        SupportedLocale.en => 'REST',
      };

  static String tHalfTotalTime([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Half Total Time',
        SupportedLocale.ar => 'مُنْتَصَفُ الْوَقْتِ الْكُلِّي',
      };

  static String tTimerPaused([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Timer is paused',
        SupportedLocale.ar => 'تَمَّ تَعْلِيقُ الْمُؤَقِّتْ',
      };

  static String tRestAlreadyCountingDown([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Rest already counting down',
        SupportedLocale.ar => 'وَقْتُ الرَّاحَةِ قَيْدُ الْعَد',
      };

  static String tTimerResumed([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Timer is resumed',
        SupportedLocale.ar => 'تَمَّ اسْتِئْنَافُ الْمُؤَقِّتْ',
      };

  static String tPleaseSetTotalTime([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Please set total time',
        SupportedLocale.ar => 'قُمْ بِتَحْدِيدِ الْوَقْتِ الْكُلِّي',
      };

  static String tRestTime(int minutes, int seconds) => ''
      '${minutes != 0 ? _minString(minutes) : ''}'
      '${seconds != 0 ? _secString(seconds) : ''}';

  static String tRestFor([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Rest for: ',
        SupportedLocale.ar => 'استرح لمدة: ',
      };

  static String tSecondsRemainingTillEnd(int seconds) => switch (_currentLocale()) {
        SupportedLocale.en => '$seconds Seconds remaining till end',
        SupportedLocale.ar => ' متبقي $seconds ثانية على النهاية',
      };

  static String _minString(int minutes) => switch (_currentLocale()) {
        SupportedLocale.ar => switch (minutes) {
            1 => 'دقيقة',
            2 => 'دقيقتان',
            > 2 && < 11 => '$minutes دقائق',
            _ => '$minutes دقيقة',
          },
        SupportedLocale.en => switch (minutes) {
            1 => 'one minute',
            _ => '$minutes minutes',
          }
      };

  static String _secString(int seconds) => switch (_currentLocale()) {
        SupportedLocale.ar => switch (seconds) {
            1 => 'ثانية',
            2 => 'ثانيتان',
            > 2 && < 11 => '$seconds ثواني',
            _ => '$seconds ثانية',
          },
        SupportedLocale.en => switch (seconds) {
            1 => 'one second',
            _ => '$seconds seconds',
          }
      };

  static String tGetReady([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Get ready',
        SupportedLocale.ar => 'استعِد',
      };

  static String tTimerStarted([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Timer started',
        SupportedLocale.ar => 'تَمَّ بِدْءُ الْمُؤَقِّت',
      };

  static String tTimerIsAlreadyRunning([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Timer is already running',
        SupportedLocale.ar => 'الْمُؤَقِّتُ قيدُ التشغيل',
      };

  static String tAlreadyStartedTryResume([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Already started - Try saying ${tRESUME(ref)}',
        SupportedLocale.ar => 'الْمُؤَقِّتُ بَدَأَ بالفِِعْل - جَرِّبْ قَوْلَ ${tRESUME(ref)}',
      };

  static String tTimerIsPausedTrySayingResume([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Timer is paused - Try saying ${tRESUME(ref)}',
        SupportedLocale.ar => 'الْمُؤَقِّتُ مُعَلَّقٌ - جَرِّبْ قَوْلَ ${tRESUME(ref)}',
      };

  static String tRESUME([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.ar => 'أَكْمِلْ',
        SupportedLocale.en => 'RESUME',
      };

  static String tTimerIsPaused([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Timer is paused',
        SupportedLocale.ar => 'تَمَّ تَعْلِيقُ الْمُؤَقِّتْ',
      };

  static String tTimerIsAlreadyPaused([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Timer is already paused',
        SupportedLocale.ar => 'الْمُؤَقِّتُ مُعَلَّقٌ بالفِِعْل',
      };

  static String tTimerHasNotStartedYet([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Timer has not started yet',
        SupportedLocale.ar => 'الْمُؤَقِّتُ لَمْ يَبْدَأْ بَعْدْ',
      };

  static String tNotAKnownCommand([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Not a known command',
        SupportedLocale.ar => 'أَمْرٌ غَيْرُ مَعْروفٍ',
      };
}
