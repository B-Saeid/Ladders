import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Modules/Settings/Provider/setting_provider.dart';
import '../../../Constants/global_constants.dart';
import '../../../Extensions/on_context.dart';
import '../../Routing/routes_base.dart';
import '../l10n_service.dart';

/// TODO : Complete This file Translations
abstract class L10nR {
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

  static String tHomePageTitle([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Home',
        SupportedLocale.ar => 'الرئيسية',
      };

  static String tSettings([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Settings',
        SupportedLocale.ar => 'الضبط',
      };

  static String tAutomatic([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Automatic',
        SupportedLocale.ar => 'تلقائي',
      };

  static String tLight([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Light',
        SupportedLocale.ar => 'مضيء',
      };

  static String tDark([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Dark',
        SupportedLocale.ar => 'داكن',
      };

  static String localeDisplayName(LocaleSetting setting, [WidgetRef? ref]) => switch (setting) {
        LocaleSetting.auto => switch (_currentLocale(ref)) {
            SupportedLocale.en => 'Device Language',
            SupportedLocale.ar => 'لغة الجهاز',
          },
        LocaleSetting.arabic => 'العربية',
        LocaleSetting.english => 'English',
      };

  /// Toasts
  static String tThemeChangeCoolDown([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Theme change cooling down',
        SupportedLocale.ar => 'تغيير سمة الجهاز قيد الانتظار',
      };

  static String tLongTapToFollowDeviceTheme([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Long Tap to follow Device theme',
        SupportedLocale.ar => 'اضغط لفترة طويلة لمتابعة سمة الجهاز',
      };

  static String tNowYouFollowDeviceTheme([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Now you follow Device theme',
        SupportedLocale.ar => 'أنت الآن تتبع سمة الجهاز',
      };

  static String localeToolTip([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Language Menu',
        SupportedLocale.ar => 'قائمة اللغة',
      };

  static String online([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Online',
        SupportedLocale.ar => 'متصل',
      };

  static String lastSeenRecently([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Last Seen Recently',
        SupportedLocale.ar => 'آخر ظهور كان قريبا',
      };

  static String waitingForNetwork([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Waiting for network...',
        SupportedLocale.ar => 'في انتظار الشبكة...',
      };

  static String tToastInternetConnected([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Connected to Internet',
        SupportedLocale.ar => 'متصل بالإنترنت',
      };

  static String tToastInternetDisconnected([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Internet connection is lost',
        SupportedLocale.ar => 'انقطع الاتصال بالإنترنت',
      };

  static String tToastNoInternetConnection([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'No Internet Connection',
        SupportedLocale.ar => 'لا يوجد اتصال بالإنترنت',
      };

  static String tToastCheckInternet([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Check your internet connection',
        SupportedLocale.ar => 'تحقق من الاتصال بالإنترنت',
      };

  static String tToastEmailNotValid([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Email is not Valid',
        SupportedLocale.ar => 'البريد الإلكتروني غير صالح',
      };

  static String tToastEmailUsed([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Email is already in use',
        SupportedLocale.ar => 'البريد الإلكتروني مستخدم من قبل',
      };

  static String tToastPhoneUsed([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Phone number is already used',
        SupportedLocale.ar => 'رقم الهاتف مستخدم من قبل',
      };

  static String tUserNotFound([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'User not found',
        SupportedLocale.ar => 'المستخدم غير موجود',
      };

  static String tNotFound([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Not found',
        SupportedLocale.ar => 'غير موجود',
      };

  static String tLoginMethods([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Login Methods',
        SupportedLocale.ar => 'طرق تسجيل الدخول',
      };

  static String tAlreadyExists([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Already Exists',
        SupportedLocale.ar => 'موجود بالفعل',
      };

  static String tNoAccountCreatedWith(String email, String thirdPartyName, [WidgetRef? ref]) =>
      switch (_currentLocale(ref)) {
        SupportedLocale.en => 'There is no account connected to your $thirdPartyName account: $email',
        SupportedLocale.ar => 'لم يتم إنشاء حساب باستخدام حساب $thirdPartyName ذا $tLabelEmail: $email',
      };

  static String tLoginMethodsDialogueContent(String email, List<String> methods, String? thirdPartyName,
      [WidgetRef? ref]) {
    var listString = '';
    if (methods.length == 1) {
      listString = methods.first;
    } else {
      listString += '\n';
      for (final method in methods) {
        listString += '\n - $method';
      }
    }
    return switch (_currentLocale(ref)) {
      SupportedLocale.en => 'You can login to your account $email via $listString'
          '${thirdPartyName != null ? '\n\nAdd $thirdPartyName as a login method ?' : ''}',
      SupportedLocale.ar => 'يمكنك تسجيل الدخول لحسابك $email عن طريق $listString'
          '${thirdPartyName != null ? '\n\nأضف $thirdPartyName كطريقة أخرى لتسجيل الدخول ؟' : ''}',
    };
  }

  static String tKeepDefault([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Keep Default',
        SupportedLocale.ar => 'إبقاء الأصل',
      };

  static String tTapOnIcon(String name, [WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Tap on $name Icon',
        SupportedLocale.ar => 'قم بالنقر على علامة $name',
      };

  static String tToastResetEmailSent([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Password reset email has been sent',
        SupportedLocale.ar => 'تم إرسال بريد إلكتروني لإعادة تعيين كلمة المرور',
      };

  static String tToastPleaseCheckYouInbox([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Please check your inbox',
        SupportedLocale.ar => 'برجاء مراجعة صندوق الرسائل',
      };

// static String get tToastUserNotFoundSignUp => switch(currentLocale {SupportedLocale.en=>tToastUserNotFoundSignUp,SupportedLocale.ar => throw UnimplementedError(),};
  static String tToastIncorrectEmailOrPassword([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Incorrect email or password',
        SupportedLocale.ar => 'البريد أو كلمة المرور غير صحيحة',
      };

  static String tToastIncorrectPassword([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Incorrect password',
        SupportedLocale.ar => 'كلمة المرور غير صحيحة',
      };

  static String tToastRedirecting([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Redirecting ...',
        SupportedLocale.ar => 'تتم إعادة التوجيه ...',
      };

  static String tToastWeakPassword([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Password is too weak',
        SupportedLocale.ar => 'كلمة المرورو ضعيفة',
      };

  static String tTooManyAttemptsWithTry([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Too many attempts - Try again later',
        SupportedLocale.ar => 'قد قمت بالعديد من المحاولات، حاول لاحقًا',
      };

  static String tToastCouldNotSendOTP([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Could Not Send OTP Code',
        SupportedLocale.ar => 'لم نتمكن من إرسال رمز التحقق',
      };

  static String tToastCouldNotResendOTP([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Could not resend OTP code',
        SupportedLocale.ar => 'لم نتمكن من إعادة إرسال رمز التحقق',
      };

// static String get tToastDeviceNotAuthorized => switch (currentLocale) {
//       SupportedLocale.en => 'App not authorized',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };

// static String get tToastCodeSentCheckInbox => switch (currentLocale) {
//       SupportedLocale.en => 'Code is Sent - Check Inbox',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };

// static String get tToastInvalidOTP => switch (currentLocale) {
//       SupportedLocale.en => 'Code is not correct',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };
//
// static String get tToastEmailUpdateRecentLogin => switch (currentLocale) {
//       SupportedLocale.en => 'Email update requires recent login',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };
//
// static String get tToastEmailIsUsed => switch (currentLocale) {
//       SupportedLocale.en => 'E-mail is used by another Account',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };
//
// static String get tToastPhoneIsUsed => switch (currentLocale) {
//       SupportedLocale.en => 'Phone is used by another Account',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };
//
// static String get tToastDefaultErrorWithTry => switch (currentLocale) {
//       SupportedLocale.en => 'Something went wrong - Try again later',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };

  static String tToastDefaultError([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Something went wrong',
        SupportedLocale.ar => 'نأسف حدث خطأ',
      };

// static String get tToastRecoveryEmailSent => switch (currentLocale) {
//       SupportedLocale.en => 'Check your inbox',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };

// static String get tToastNotFoundEmailRecovery => switch (currentLocale) {
//       SupportedLocale.en => 'Email does not exist',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };

// static String get tToastSigningCancelled => switch (currentLocale) {
//       SupportedLocale.en => 'Signing Cancelled',
//       SupportedLocale.ar => throw UnimplementedError(),
//     };

  static String tToastCancelled([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Cancelled',
        SupportedLocale.ar => 'تم الإنهاء',
      };

  static String tToastGettingLocation([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Getting current Location',
        SupportedLocale.ar => 'جاري تحديد الموقع',
      };

  static String tToastYouAreSignedOut([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'You are signed out',
        SupportedLocale.ar => 'لقد تم تسجيل خروجك',
      };

  static String tToastLoginAgain([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Login Again',
        SupportedLocale.ar => 'سجل دخول مرة أخرى',
      };

  static String tToastNothingUpdated([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Nothing is updated',
        SupportedLocale.ar => 'لم يتم التحديث',
      };

  static String tToastNameUpdated([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Name updated successfully',
        SupportedLocale.ar => 'تم تحديث الإسم بنجاح',
      };

  static String tToastEmailUpdated([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Email updated successfully',
        SupportedLocale.ar => 'تم تحديث البريد الإلكتروني بنجاح',
      };

  static String tToastBirthdayUpdated([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Birthday updated successfully',
        SupportedLocale.ar => 'تم تحديث تاريخ الميلاد بنجاح',
      };

  static String tToastPhoneUpdated([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Phone updated successfully',
        SupportedLocale.ar => 'تم تحديث رقم الهاتف بنجاح',
      };

  static String tToastCameraNotAllowed([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Camera permission not allowed',
        SupportedLocale.ar => 'إذن الكاميرا غير مسموح به',
      };

  static String tToastGettingRoute([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Finding optimal route',
        SupportedLocale.ar => 'جاري تحديد أفضل مسار',
      };

  static String tToastRouteSetSuccess([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Route is set successfully',
        SupportedLocale.ar => 'تم تحديد المسار بنجاح',
      };

  static String tToastTryAgainLater([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Try again later',
        SupportedLocale.ar => 'حاول مرة أخرى لاحقا',
      };

  static String tToastSelectVehicleType([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Select Vehicle Type',
        SupportedLocale.ar => 'حدد نوع المركبة',
      };

  static String tToastUploadAllRequiredImages([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Upload All Required Images',
        SupportedLocale.ar => 'برجاء رفع كل الصور المطلوبة',
      };

  static String tVehicleRegister([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Vehicle Register',
        SupportedLocale.ar => 'تسجيل المركبة',
      };

  static String tToastRegisteredSuccessfully([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Registered Successfully',
        SupportedLocale.ar => 'تم التسجبل بنجاح',
      };

  static String tToastTripIsPublished([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Your Trip is successfully published',
        SupportedLocale.ar => 'تم نشر رحلتك بنجاح',
      };

  static String tToastTripIsDeleted([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Trip is deleted successfully',
        SupportedLocale.ar => 'تم حذف الرحلة بنجاح',
      };

  static String tToastNoRoute([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'No route can be found',
        SupportedLocale.ar => 'لا يمكن تحدبد المسار',
      };

  static String tToastSigningOut([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Signing Out',
        SupportedLocale.ar => 'جاري تسجيل الخروج',
      };

  static String tToastTapIsEnough([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Tap is just enough',
        SupportedLocale.ar => 'اللمسة القصبرة تكفي',
      };

  static String tToastRecordAtLeastHalfSecond([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Record at least half a second',
        SupportedLocale.ar => 'سجل نصف ثانية على الأقل',
      };

  /// On Screen Text Widgets
// Top Level Screen
//   static String get tSetTime => switch (_currentLocale) {
//         SupportedLocale.en => 'Set Time',
//         SupportedLocale.ar => 'اضبط الوقت',
//       };
//
//   static String get tTimezone => switch (_currentLocale) {
//         SupportedLocale.en => 'Timezone',
//         SupportedLocale.ar => 'المنطقة الزمنية',
//       };
//
//   static String get tDevice => switch (_currentLocale) {
//         SupportedLocale.en => 'Device',
//         SupportedLocale.ar => 'الجهاز',
//       };
//
//   static String tSetTimeStatement(bool isNegative) => switch (_currentLocale) {
//         SupportedLocale.en => 'You device clock is '
//             '${isNegative ? 'preceding' : 'ahead of'} timezone clock.',
//         SupportedLocale.ar => 'ساعة الجهاز '
//             '${isNegative ? 'متأخرة عن' : 'متقدمة عن'} المنطقة الزمنية.',
//       };
//
//   static String get tHour => switch (_currentLocale) {
//         SupportedLocale.ar => 'ساعة',
//         SupportedLocale.en => 'Hour',
//       };
//
//   static String get tMinute => switch (_currentLocale) {
//         SupportedLocale.ar => 'دقيقة',
//         SupportedLocale.en => 'Mintue',
//       };
//
//   static String get tSecond => switch (_currentLocale) {
//         SupportedLocale.ar => 'ثانية',
//         SupportedLocale.en => 'Second',
//       };
//
//   static String get tLongTime => switch (_currentLocale) {
//         SupportedLocale.ar => 'مدة طويلة',
//         SupportedLocale.en => 'Long Time',
//       };
//
//   static String tSetTimeDifferenceString(Duration difference) {
//     final differenceAbs = difference.abs();
//
//     final (hourPart, minutePart, secondPart) = differenceAbs.nHHnMMnSS;
//     final hourExists = hourPart > 0;
//     final minuteExists = minutePart > 0;
//     final secondExists = secondPart > 0;
//
//     String displayString;
//     final isRightToLight = _currentLocale == SupportedLocale.ar;
//
//     /// Solo Parts
//     if (!hourExists && !minuteExists && secondExists) {
//       displayString = isRightToLight
//           ? '${minutePart.lhs0IfSingle}  $tSecond'
//           : '$tSecond ${minutePart.lhs0IfSingle}';
//     } else if (!hourExists && minuteExists && !secondExists) {
//       displayString =
//           isRightToLight ? '${minutePart.lhs0IfSingle} $tMinute' : '$tMinute ${minutePart.lhs0IfSingle}';
//     } else if (hourExists && !minuteExists && !secondExists) {
//       displayString =
//           isRightToLight ? '${hourPart.lhs0IfSingle} $tHour' : '$tHour ${hourPart.lhs0IfSingle}';
//     }
//
//     /// Couple Parts
//     else if (hourExists && minuteExists && !secondExists) {
//       displayString = isRightToLight
//           ? '${hourPart.lhs0IfSingle}:${minutePart.lhs0IfSingle} $tHour'
//           : '$tHour ${hourPart.lhs0IfSingle}:${minutePart.lhs0IfSingle}';
//     } else if (!hourExists && minuteExists && secondExists) {
//       displayString = isRightToLight
//           ? '${minutePart.lhs0IfSingle}:${secondPart.lhs0IfSingle} $tMinute'
//           : '$tMinute ${minutePart.lhs0IfSingle}:${secondPart.lhs0IfSingle}';
//     }
//
//     /// All Parts
//     else if (hourExists && secondExists) {
//       displayString = isRightToLight
//           ? '${hourPart.lhs0IfSingle}:${minutePart.lhs0IfSingle}:${secondPart.lhs0IfSingle} $tHour'
//           : '$tHour ${hourPart.lhs0IfSingle}:${minutePart.lhs0IfSingle}:${secondPart.lhs0IfSingle}';
//     }
//
//     /// This is for the compiler not to yell at us
//     else {
//       displayString = '';
//     }
//     if (differenceAbs.inHours > 99) return tLongTime;
//
//     return switch (_currentLocale) {
//       SupportedLocale.en => displayString,
//       SupportedLocale.ar => displayString,
//     };
//   }
//
//   static String get tSetTimeDialogueMessage {
//     return switch (_currentLocale) {
//       SupportedLocale.en => 'Please set the time properly before continuing to use the app.'
//           ' This can be due to one of the following:\n\n'
//           '- Timezone not set correctly.\n'
//           '- Unstable internet connection.\n'
//           '- Daylight saving changes.',
//       SupportedLocale.ar => 'برجاء ضبط الوقت قبل الاستمرار في استخدام التطبيق.'
//           ' يمكن أن يكون هذا التنبيه بسبب من الأسباب التالية:\n\n'
//           '- المنطقة الزمنية غير صحيحة.\n'
//           '- الاتصال بالانترنت غير مستقر.\n'
//           '- تغييرات التوقيت الصيفي.',
//     };
//   }
//
//   static String get tNote => switch (_currentLocale) {
//         SupportedLocale.ar => 'تنويه',
//         SupportedLocale.en => 'Note',
//       };
//
//   static String get _autoSettingRelaunchRequired => switch (_currentLocale) {
//         SupportedLocale.ar =>
//           'سيتم تزامن اللغة مع الجهاز عند إعادة تشغيل التطبيق.$_youCanCancelByTappingTheCurrent',
//         SupportedLocale.en =>
//           'The language will be synced with the device when you restart the app.$_youCanCancelByTappingTheCurrent',
//       };
//
//   static String get _youCanCancelByTappingTheCurrent => switch (_currentLocale) {
//         SupportedLocale.en => '\n\nYou can cancel that change by tapping the current selected language.',
//         SupportedLocale.ar => '\n\nيمكن إلغاء هذا التغيير بالنقر على اللغة المختارة الحالية.',
//       };
//
//   static String langSettingRelaunchRequired(LocaleSetting setting) => switch (setting) {
//         /// As We only show a dialogue when A DIFFERENT language is selected
//         /// and FOR NOW They are ONLY TWO .. when more are added every LocaleSetting
//         /// will return localized String except for the language itself
//         /// You get the idea!
//         LocaleSetting.arabic => 'The language will switch to Arabic when '
//             'you restart the app.$_youCanCancelByTappingTheCurrent',
//         LocaleSetting.english => 'ستتحول اللغة إلى الإنجليزية '
//             'عند إعادة تشغيل التطبيق.$_youCanCancelByTappingTheCurrent',
//
//         /// In this case we do not know what is the current LocaleSetting
//         /// so we provide strings for all supportedLocales
//         LocaleSetting.auto => _autoSettingRelaunchRequired,
//       };
//
//   static String get tPendingRestart => switch (_currentLocale) {
//         SupportedLocale.en => 'Pending Restart',
//         SupportedLocale.ar => 'في انتظار إعادة التشغيل',
//       };
//
//   static String get markAsReadTitle => switch (_currentLocale) {
//         SupportedLocale.ar => 'ضع علامة مقروءة',
//         SupportedLocale.en => 'Mark As Read',
//       };
//
//   static String get fiveMinETATitle => switch (_currentLocale) {
//         SupportedLocale.ar => '5 دقائق كن مستعدا',
//         SupportedLocale.en => '5 min Be Ready',
//       };
//
//   static String get tenToFifteenMinETATitle => switch (_currentLocale) {
//         SupportedLocale.ar => 'حوالي 15 دقيقة',
//         SupportedLocale.en => 'About 15 min',
//       };
//
//   static String get showBookingOnMapTitle => switch (_currentLocale) {
//         SupportedLocale.ar => 'عرض على الخريطة',
//         SupportedLocale.en => 'Show On Map',
//       };
//
//   static String get acceptBookingTitle => switch (_currentLocale) {
//         SupportedLocale.ar => 'قبول',
//         SupportedLocale.en => 'Accept',
//       };
//
//   static String get rejectBookingTitle => switch (_currentLocale) {
//         SupportedLocale.ar => 'دفض',
//         SupportedLocale.en => 'Reject',
//       };
//
//   static String get dismissBookingTitle => switch (_currentLocale) {
//         SupportedLocale.ar => 'تجاهل',
//         SupportedLocale.en => 'Dismiss',
//       };
//
//   static String get fiveSeconds => switch (_currentLocale) {
//         SupportedLocale.ar => '5 ثواني',
//         SupportedLocale.en => '5 Seconds',
//       };
//
//   static String get tenSeconds => switch (_currentLocale) {
//         SupportedLocale.ar => '10 ثواني',
//         SupportedLocale.en => '10 Seconds',
//       };
//
//   static String get fifteenSeconds => switch (_currentLocale) {
//         SupportedLocale.ar => '15 ثانية',
//         SupportedLocale.en => '15 Seconds',
//       };
//
//   static String get thirtySeconds => switch (_currentLocale) {
//         SupportedLocale.ar => '30 ثانية',
//         SupportedLocale.en => '30 Seconds',
//       };
//
//   static String get minute => switch (_currentLocale) {
//         SupportedLocale.ar => 'دقيقة',
//         SupportedLocale.en => '1 Minute',
//       };
//
//   static String get twoMinutes => switch (_currentLocale) {
//         SupportedLocale.ar => 'دقيقتان',
//         SupportedLocale.en => '2 Minutes',
//       };
//
//   static String get fiveMinutes => switch (_currentLocale) {
//         SupportedLocale.ar => '5 دقائق',
//         SupportedLocale.en => '5 Minutes',
//       };
//
//   static String newMessageNPrepend(int numberOfMessages, bool htmlFormat) {
//     switch (_currentLocale) {
//       case SupportedLocale.en:
//         return htmlFormat
//             ? "<b>$numberOfMessages</b> New Message${numberOfMessages > 1 ? 's' : ''} "
//             : "$numberOfMessages New Message${numberOfMessages > 1 ? 's' : ''} ";
//       case SupportedLocale.ar:
//         if (numberOfMessages == 1) {
//           return 'رسالة جديدة';
//         } else if (numberOfMessages == 2) {
//           return 'رسالتان جديدتان';
//         } else if (numberOfMessages < 10) {
//           return htmlFormat
//               ? '<b>$numberOfMessages</b>' ' رسائل جديدة'
//               : ' رسائل جديدة$numberOfMessages';
//         } else {
//           return htmlFormat
//               ? '<b>$numberOfMessages</b>' ' رسالة جديدة'
//               : ' رسائل جديدة$numberOfMessages';
//         }
//     }
//   }
//
//   static String get bookingNToSubtitle => switch (_currentLocale) {
//         SupportedLocale.ar => 'إلي:',
//         SupportedLocale.en => 'To:',
//       };
//
//   static String get passwordLengthVal => switch (_currentLocale) {
//         SupportedLocale.ar => 'يجب أن تكون كلمة المرور أطول من 8 أحرف',
//         SupportedLocale.en => 'Password must be longer than 8 characters',
//       };
//
//   static String get passwordUppercaseVal => switch (_currentLocale) {
//         SupportedLocale.ar => 'يجب أن تحتوي كلمة المرور على أحرف كبيرة',
//         SupportedLocale.en => 'Password must contain an uppercase letter',
//       };
//
//   static String get passwordLowercaseVal => switch (_currentLocale) {
//         SupportedLocale.ar => 'يجب أن تحتوي كلمة المرور على أحرف صغيرة',
//         SupportedLocale.en => 'Password must contain a lowercase letter',
//       };
//
//   static String get passwordDigitVal => switch (_currentLocale) {
//         SupportedLocale.ar => 'يجب أن تحتوي كلمة المرور على رقم',
//         SupportedLocale.en => 'Password must contain a number',
//       };
//
//   static String get passwordSpecialCharacterVal => switch (_currentLocale) {
//         SupportedLocale.ar => 'يجب أن تحتوي كلمة المرور على حرف خاص مثل @ # % & * !',
//         SupportedLocale.en => 'Password must contain a special character e.g. @ # % & * !',
//       };
//
//   static String get tSetTimeIOSSettingsGuide => switch (_currentLocale) {
//         SupportedLocale.en => 'Please Go To: \n\nSettings > General > Date & Time\n',
//         SupportedLocale.ar => 'فضلا الانتقال إلى: \n\nالضبط > عام > الوقت والتاريخ\n',
//       };
//
//   static String get tExit => switch (_currentLocale) {
//         SupportedLocale.en => 'Exit',
//         SupportedLocale.ar => 'غلق',
//       };
//
// // On Boarding
//   static String get tOnBoardingTitle1 => switch (_currentLocale) {
//         SupportedLocale.en => 'Select a Destination',
//         SupportedLocale.ar => 'اختر وجهتك',
//       };
//
//   static String get tOnBoardingDescription1 => switch (_currentLocale) {
//         SupportedLocale.en => 'Set where you go to search the road for drivers going your way.',
//         SupportedLocale.ar => throw UnimplementedError(),
//       };
//
//   static String get tOnBoardingTitle2 => switch (_currentLocale) {
//         SupportedLocale.en => 'Choose From Rides',
//         SupportedLocale.ar => 'اختر من الرحلات',
//       };
//
//   static String get tOnBoardingDescription2 => switch (_currentLocale) {
//         SupportedLocale.en => 'Pick from found rides the one that suits you',
//         SupportedLocale.ar => 'اختر من الرحلات الموجودة ما يناسبك',
//       };
//
//   static String get tOnBoardingTitle3 => switch (_currentLocale) {
//         SupportedLocale.en => 'Nominal Fares',
//         SupportedLocale.ar => 'أجر رمزية',
//       };
//
//   static String get tOnBoardingDescription3 => switch (_currentLocale) {
//         SupportedLocale.en =>
//           'Enjoy sedan comfort while paying very cheap fares when travelling between cities',
//         SupportedLocale.ar => 'استمع براحة السيارة الخاصة في رحلاتك مقابل أجر رخيصة للفاية',
//       };
//
//   static String get tContinue => switch (_currentLocale) {
//         SupportedLocale.en => 'Continue',
//         SupportedLocale.ar => 'متابعة',
//       };
//
//   static String get tDetermineGender => switch (_currentLocale) {
//         SupportedLocale.en => 'Determine Gender',
//         SupportedLocale.ar => 'حدد النوع',
//       };
//
// //  Login Screen
// //   static String get tDoNotHaveAccount => switch (currentLocale) {
// //         SupportedLocale.en => 'New to ${GlobalConstants.appName} ?',
// //         SupportedLocale.ar => ' ؟${GlobalConstants.appName}مستخدم جديد لدى ',
// //       };
//
//   static String get tCreateAccountCAPS => switch (_currentLocale) {
//         SupportedLocale.en => 'CREATE ACCOUNT',
//         SupportedLocale.ar => 'إنشاء حساب',
//       };
//
//   static String get tPrivacyTermsNoticeP1 => switch (_currentLocale) {
//         SupportedLocale.en => 'By Continuing you agree to our ',
//         SupportedLocale.ar => 'باستمرارك أنت توافق على ',
//       };
//
//   static String get tSpaceAndSpace => switch (_currentLocale) {
//         SupportedLocale.en => ' and ',
//         SupportedLocale.ar => ' و ',
//       };
//
//   static const tDot = '.';
//
//   static String get tGender => switch (_currentLocale) {
//         SupportedLocale.en => 'Gender',
//         SupportedLocale.ar => 'النوع',
//       };
//
//   static String get tMale => switch (_currentLocale) {
//         SupportedLocale.en => 'Male',
//         SupportedLocale.ar => 'ذكـر',
//       };
//
//   static String get tFemale => switch (_currentLocale) {
//         SupportedLocale.en => 'Female',
//         SupportedLocale.ar => 'أنـثـى',
//       };
//
// //  Sending Password Reset Email Screen
// // static String get tForgotPasswordSelectTitle => switch(currentLocale {SupportedLocale.en=>tForgotPasswordSelectTitle,SupportedLocale.ar => throw UnimplementedError(),};
// // static String get tForgotPasswordSelectSubTitle => switch(currentLocale {SupportedLocale.en=>tForgotPasswordSelectSubTitle,SupportedLocale.ar => throw UnimplementedError(),};
//   static String get tResetViaEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'Reset via E-mail',
//         SupportedLocale.ar => 'إسترجاع بواسطة البريد الإلكتروني',
//       };
//
//   static String get tResetViaPhone => switch (_currentLocale) {
//         SupportedLocale.en => 'Reset via Phone Number',
//         SupportedLocale.ar => 'إسترجاع بواسطة رقم الهاتف',
//       };
//
//   static String get tResetViaEmailSubtitle => switch (_currentLocale) {
//         SupportedLocale.en => 'Please enter the email address linked to your account. '
//             'You will receive a verification link, by tapping it you will be redirected '
//             'to the app in order to reset your password.',
//         SupportedLocale.ar => 'برجاء إدخال البريد الإلكتروني المربوط بحسابك. '
//             'سوف يصلك رابط تحقق من خلال النقر عليه سيتم إعادة توجيهك '
//             'إلى التطبيق من أجل إعادة تعيين كلمة المرور الخاصة بك.',
//       };
//
//   static String get tResetViaPhoneSubtitle => switch (_currentLocale) {
//         SupportedLocale.en => 'Please enter the phone number linked to your account.',
//         SupportedLocale.ar => 'برجاء إدخال رقم الهاتف المربوط بحسابك. '
//       };
//
//   ///  Confirm Password Reset Screen
//   ///
//   static String get tSendingPasswordResetLink => switch (_currentLocale) {
//         SupportedLocale.en => 'Sending password reset link ...',
//         SupportedLocale.ar => 'جاري إرسال رابط الاسترجاع ...',
//       };
//
//   static String get tPasswordResetLinkSent => switch (_currentLocale) {
//         SupportedLocale.en => 'Password reset link has been sent to your email. '
//             'Please check your inbox to reset your password.\n\n'
//             'NOTE: You need to open the link using this device.',
//         // TODO: May be add as a tip or in a WHY? button
//         //  as for security reasons email verification is not done using web browsers
//         SupportedLocale.ar => 'تم إرسال رابط الاسترجاع إلى البريد الخاص بكم. '
//             'برجاء مراجعة صندوق الرسائل.\n\n'
//             'تنويه: لابد من فتح الرابط باستخدام هذا الجهاز.',
//       };
//
//   static String get tVerifyingResetCode => switch (_currentLocale) {
//         SupportedLocale.en => 'Verifying reset link ...',
//         SupportedLocale.ar => 'مراحعة رابط الاسترجاع ...',
//       };
//
//   static String get tPasswordResetExpired => switch (_currentLocale) {
//         SupportedLocale.en => 'Password reset link is expired. Tap the button to resend a new one.',
//         SupportedLocale.ar => 'انتهت صلاحية رابط الاسترجاع. اضغط على الزر لإعادة إرسال رابط جديد.',
//       };
//
//   static String get tEnterYourNewPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Enter your new password',
//         SupportedLocale.ar => 'أدخل كلمة المرور الجدبدة',
//       };
//
//   static String get tResettingPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Resetting password ...',
//         SupportedLocale.ar => 'إعادة ضبط كلمة المرور ...',
//       };
//
//   static String get tPasswordResetSuccessfully => switch (_currentLocale) {
//         SupportedLocale.en => 'Password reset successfully',
//         SupportedLocale.ar => 'تم إعادة ضبط كلمة المرور بنجاح',
//       };
//
//   static String get tLoginWithYourNewPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Login with your new password',
//         SupportedLocale.ar => 'سجل دخول بكلمة المرور الجديدة',
//       };
//
//   static String get tCouldNotResetYourPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Could not reset your password',
//         SupportedLocale.ar => 'لم نتمكن من إعادة ضبط كلمة المرور',
//       };
//
//   static String get tResendResetLink => switch (_currentLocale) {
//         SupportedLocale.en => 'Resend Reset link',
//         SupportedLocale.ar => 'أعد إرسال رابط الاسترجاع',
//       };
//
//   static String get tResetPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Reset Password',
//         SupportedLocale.ar => 'إعادة ضبط كلمة المرور',
//       };
//
//   static String get tMultipleWrongAttempts => switch (_currentLocale) {
//         SupportedLocale.en => 'Multiple Wrong Attempts',
//         SupportedLocale.ar => 'العديد من المحاولات الخاطئة',
//       };
//
//   static String get tTooManyWrongsAttemptsDialogueMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'Access to this account has been '
//             'temporarily disabled due to many failed login attempts.',
//         SupportedLocale.ar => 'تم تعطيل الدخول إلى هذا الحساب بشكل مؤقت بسبب كثرة محاولات'
//             ' تسجيل الدخول الخاظئة.'
//       };
//
//   static String get tCancelVerification => switch (_currentLocale) {
//         SupportedLocale.en => 'Cancel Verification',
//         SupportedLocale.ar => 'إنهاء التحقق',
//       };
//
//   static String get tCancelRegistering => switch (_currentLocale) {
//         SupportedLocale.en => 'Cancel Registering',
//         SupportedLocale.ar => 'إنهاء التسجيل',
//       };
//
//   static String get tSkip => switch (_currentLocale) {
//         SupportedLocale.en => 'Skip',
//         SupportedLocale.ar => 'تخطي',
//       };
//
//   static String get tConfirmSkip => switch (_currentLocale) {
//         SupportedLocale.en => 'Confirm Skip',
//         SupportedLocale.ar => 'تأكيد التخطي',
//       };
//
//   static String get tVerificationMethod => switch (_currentLocale) {
//         SupportedLocale.en => 'Verification Method',
//         SupportedLocale.ar => 'طريقة التحقق',
//       };
//
//   static String get accountCreatedSuccessfully => switch (_currentLocale) {
//         SupportedLocale.en => 'Account Created Successfully',
//         SupportedLocale.ar => 'تم إنشاء الحساب بنجاح',
//       };
//
//   static String get tCancelVerificationDialogueMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'If you cancel email verification '
//             'this step will not be skipped. You need to verify your '
//             'email first.\n\n'
//             'Do you want to cancel the verification ?',
//         SupportedLocale.ar => 'في حالة إنهاء التحقق من البريد الإلكتروني '
//             'لن يتم تجاوز هذه الخطوة. لابد من إتمام التحقق أولاً.\n\n'
//             'هل تود إنهاء التحقق ؟',
//       };
//
//   static String get tCancelPhoneOTPDialogueMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'If you cancel phone verification '
//             'this step will not be skipped. You need to verify your '
//             'phone first.\n\n'
//             ' Do you want to cancel the verification ?',
//         SupportedLocale.ar => 'في حالة إنهاء التحقق من الهاتف '
//             'لن يتم تجاوز هذه الخطوة. لابد من إتمام التحقق أولاً.\n\n'
//             'هل تود إنهاء التحقق ؟',
//       };
//
//   static String get tCancelPhonePasswordDialogueMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'If you cancel now previous phone number verification will be lost.\n\n'
//             ' Do you want to cancel registering?',
//         SupportedLocale.ar => 'في حالة الإنهاء سوف تفقد تحقق رقم الهاتف السابق.\n\n'
//             ' هل تريد إنهاء إنشاء حسابك؟',
//       };
//
//   static String get tConfirmSkipDriverApplyMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'You can add a vehicle and become a Driver by '
//             'going to Menu > ${L10nR.tBecomeDriverButton}'
//             '\n\nDo you want to skip?',
//         SupportedLocale.ar => 'يمكنك إضافة مركبة والتقديم كسائق '
//             'عن طريق الذهاب إلى القائمة > ${L10nR.tBecomeDriverButton}'
//             '\n\nهل تريد التخطي؟',
//       };
//
//   static String get tChooseFromGallery => switch (_currentLocale) {
//         SupportedLocale.en => 'Choose from gallery',
//         SupportedLocale.ar => 'اختر من الصور',
//       };
//
//   static String get tTakeAPicture => switch (_currentLocale) {
//         SupportedLocale.en => 'Take a picture',
//         SupportedLocale.ar => 'التقط صورة',
//       };
//
//   static String get tAppliedSuccessfully => switch (_currentLocale) {
//         SupportedLocale.en => 'Applied Successfully',
//         SupportedLocale.ar => 'تم التقديم بنجاح',
//       };
//
//   static String get tAppliedSuccessfullyMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'Congratulation! You have successfully applied as a Driver.'
//             ' Once Your application is reviewed you will receive a'
//             ' feedback in the app notification center.',
//         SupportedLocale.ar => 'تهانينا! تم تقديم كسائق بنجاح.'
//             ' سوف تصلكم نتيجة التقديم في مركز الإشعارات'
//             ' فور الانتهاء من مراجعة الطلب.',
//       };
//
//   static String get tVerificationChoiceMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'We will sent you an OTP code to verify your phone number.'
//             ' Please choose a receiving destination.',
//         // '\n\n If you can access your'
//         // ' phone number WhatApp account, It is recommended to continue with WhatsApp.',
//         SupportedLocale.ar => 'سوف نرسل لك رمز أمان للتحقق من رقم هاتفك.'
//             ' يرجى اختيار طريقة الاستلام.',
//         // 'إذا كنت تستطيع الوصول إلى الخاص بك'
//         //             ' رقم الهاتف حساب WhatApp، يوصى بمتابعة استخدام WhatsApp.',
//       };
//
//   static String get tVerificationChoiceWhatsAppNote => switch (_currentLocale) {
//         SupportedLocale.en => 'Please make sure you have access to your phone '
//             'number WhatsApp account.',
//         SupportedLocale.ar => 'يرجى التأكد من إمكانية الوصول إلى حساب '
//             'الواتساب الخاص برقم الهاتف.',
//       };
//
//   static String get tVerificationChoiceSMSNote => switch (_currentLocale) {
//         SupportedLocale.en => 'Please make sure you can receive SMS'
//             ' and the cellular network coverage is good.',
//         SupportedLocale.ar => 'يرجى التأكد من إمكانية استلام رسائل نصية SMS'
//             ' و أن تغطية الشبكة الخلوية جيدة.',
//       };
//
//   static String get tWhatsApp => switch (_currentLocale) {
//         SupportedLocale.en => 'WhatsApp',
//         SupportedLocale.ar => 'واتساب',
//       };
//
//   static String get tSMS => switch (_currentLocale) {
//         SupportedLocale.en => 'SMS',
//         SupportedLocale.ar => 'رسالة نصية SMS',
//       };
//
//   static String get recommended => switch (_currentLocale) {
//         SupportedLocale.en => 'Recommended',
//         SupportedLocale.ar => 'يفضل',
//       };
//
//   static String get tCreatePassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Create Password',
//         SupportedLocale.ar => 'إنشاء كلمة المرور',
//       };
//
//   static String tCreatingPasswordGreeting(String name) => switch (_currentLocale) {
//         SupportedLocale.ar => '$nameمرحبا ',
//         SupportedLocale.en => 'Welcome $name',
//       };
//
//   static String get tCreatingPasswordMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'Please create a password for your account '
//             'to be able to login via your phone number.',
//         SupportedLocale.ar => 'يرجى إنشاء كلمة مرور'
//             ' لتسجيل الدخول عن طريق رقم الهاتف.',
//       };
//
//   static String get tConsecutiveRequests => switch (_currentLocale) {
//         SupportedLocale.en => 'Consecutive Requests',
//         SupportedLocale.ar => 'محاولات متتالية',
//       };
//
//   static String get tConsecutiveRequestsDialogueMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'For accounts security assurance consecutive requests to'
//             ' reset password are not allowed. Please try again later.',
//         SupportedLocale.ar => 'لضمان أمان الحسابات الطلبات المتتالية لإعادة ضبط كلمة المرور'
//             ' غير مسموح بها. برجاء المحاولة في وقت لاحق.',
//       };
//
//   static String get tOK => switch (_currentLocale) {
//         SupportedLocale.en => 'OK',
//         SupportedLocale.ar => 'حسنا',
//       };
//
//   static String get tPreviousMatch => switch (_currentLocale) {
//         SupportedLocale.en => 'Previous Match',
//         SupportedLocale.ar => 'تطابق سابق',
//       };
//
//   static String get tPreviousPasswordMatchDialogueMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'You entered the correct password of your account.'
//             ' It is recommended to reset your password with a new one.'
//             '\n\nNote: You can use this password to login without resetting it.',
//         SupportedLocale.ar => 'لقد قمت بإدخال كلمة المرور الصحيحة. '
//             'يفضل إعادة ضبطها بكلمة مرور جديدة.\n\n'
//             'تنويه: يمكنك استخدام كلمة المرور تلك لتسجبل الدخول بدون إعادة ضبطها.',
//       };
//
//   static String get tCancelConfirm => switch (_currentLocale) {
//         SupportedLocale.en => 'Cancel Confirm',
//         SupportedLocale.ar => 'تأكيد الإنهاء',
//       };
//
//   static String get tCancelPasswordResetDialogue => switch (_currentLocale) {
//         SupportedLocale.en => 'Do you want to cancel password resetting?',
//         SupportedLocale.ar => 'هل تود إنهاء إعادة ضبط كلمة المرور؟',
//       };
//
//   ///
//   //  OTP Screen
//   static String get tOTPTitle => switch (_currentLocale) {
//         SupportedLocale.en => 'Phone number Verification',
//         SupportedLocale.ar => 'التحقق من رقم الهاتف',
//       };
//
//   // static String get tEnterCode => switch (_currentLocale) {
//   //       SupportedLocale.en => 'Enter the verification code sent to your phone number.'
//   //           ' \n\nNote: The code expires after ${GlobalConstants.otpExpirationMinutes} minutes',
//   //       SupportedLocale.ar => 'أدخل رمز التحقق المرسل إلى رقم الهاتف.'
//   //           '\n\nتنويه: مدة صلاحية الرمز ${GlobalConstants.otpExpirationMinutes} دقائق',
//   //     };
//
//   static String get tResendingCode => switch (_currentLocale) {
//         SupportedLocale.en => 'Resending OTP Code ...',
//         SupportedLocale.ar => 'جاري إرسال رمز التحقق ...',
//       };
//
//   // static String get tSendOTPCode => switch (_currentLocale) {
//   //       SupportedLocale.en => 'Send OTP Code',
//   //       SupportedLocale.ar => 'أرسل رمز التحقق',
//   //     };
//
//   static String get tResendOTPCode => switch (_currentLocale) {
//         SupportedLocale.en => 'Resend OTP Code',
//         SupportedLocale.ar => 'أعد إرسال الرمز',
//       };
//
//   static String get tVerifying => switch (_currentLocale) {
//         SupportedLocale.en => 'Verifying ...',
//         SupportedLocale.ar => 'جاري التحقق ...',
//       };
//
//   static String get tPhoneSuccessfullyVerified => switch (_currentLocale) {
//         SupportedLocale.en => 'Phone number is successfully verified.',
//         SupportedLocale.ar => 'تم التحقق من رقم الهاتف بنجاح.',
//       };
//
//   static String get tInvalidOTP => switch (_currentLocale) {
//         SupportedLocale.en => 'OTP Code is not valid.',
//         SupportedLocale.ar => 'رمز التحقق غير صالح.',
//       };
//
//   static String get tCouldNotVerifyYourPhone => switch (_currentLocale) {
//         SupportedLocale.en => 'Could not verify your phone number.',
//         SupportedLocale.ar => 'لم نتمكن من التحقق من رقم الهاتف.',
//       };
//
// //  Register Screen
//   static String get tSignUpPageTitle => switch (_currentLocale) {
//         SupportedLocale.en => 'Sign Up',
//         SupportedLocale.ar => 'إنشاء حساب',
//       };
//
// // static String get tSignUpWith => switch(currentLocale {SupportedLocale.en=>tSignUpWith,SupportedLocale.ar => throw UnimplementedError(),};
// // static String get tSignUpOr => switch(currentLocale {SupportedLocale.en=>tSignUpOr,SupportedLocale.ar => throw UnimplementedError(),};
//   static String get tSigningVia => switch (_currentLocale) {
//         SupportedLocale.en => 'via',
//         SupportedLocale.ar => 'بواسطة',
//       };
//
//   static String get tAlreadyHaveAccount => switch (_currentLocale) {
//         SupportedLocale.en => 'Already have an account ?',
//         SupportedLocale.ar => 'لديك حساب بالفعل ؟',
//       };
//
//   static String get tAccountCannotBeCreated => switch (_currentLocale) {
//         SupportedLocale.en => 'Account can not be created',
//         SupportedLocale.ar => 'لا يمكن إنشاء الحساب',
//       };
//
//   static String get tCouldNotSignYouIn => switch (_currentLocale) {
//         SupportedLocale.en => 'Could not sign you in',
//         SupportedLocale.ar => 'لم نتمكن من تسجبل دخولك',
//       };
//
//   static String get tCouldNotSignInWithGoogle => switch (_currentLocale) {
//         SupportedLocale.en => 'Could not Sign in with Google',
//         SupportedLocale.ar => 'لم نتمكن من تسجبل دخول بحساب Google',
//       };
//
//   static String get tCouldNotContinueWithGoogle => switch (_currentLocale) {
//         SupportedLocale.en => 'Could not Continue with Google',
//         SupportedLocale.ar => 'لم نتمكن من استخدام حساب Google',
//       };
//
//   static String get tAborted => switch (_currentLocale) {
//         SupportedLocale.en => 'Aborted',
//         SupportedLocale.ar => 'لم ينتهي',
//       };
//
//   static String get tCancelled => switch (_currentLocale) {
//         SupportedLocale.en => 'Cancelled',
//         SupportedLocale.ar => 'تم الإلغاء',
//       };
//
//   static String get tCouldNotRetrieveYourAccountInfo => switch (_currentLocale) {
//         SupportedLocale.en => 'Could not get your account info',
//         SupportedLocale.ar => 'لم نتمكن من الحصول على معلومات حسابك',
//       };
//
//   static String get dialCodeSearchHint => switch (_currentLocale) {
//         SupportedLocale.en => 'Country name or dial-in code',
//         SupportedLocale.ar => 'اسم البلد أو رمز الاتصال',
//       };
//
// // Email Verify Screen
//   static String get tPleaseVerifyYourEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'Please verify your email',
//         SupportedLocale.ar => 'برجاء إتمام التحقق من البريد الإلكتروني',
//       };
//
//   static String get tSendingVerificationLink => switch (_currentLocale) {
//         SupportedLocale.en => 'Sending verification email ...',
//         SupportedLocale.ar => 'جاري إرسال بريد التحقق ...',
//       };
//
//   static String get tVerifyingYourEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'Verifying your email ...',
//         SupportedLocale.ar => 'جاري التحقق من بريدكم الإلكتروني ...',
//       };
//
//   static String get tVerificationLinkSent => switch (_currentLocale) {
//         SupportedLocale.en => 'Verification link has been sent to your email. '
//             'Please check your inbox to verify your email.\n\n'
//             'NOTE: You need to open the link using this device.',
//         //  TODO: May be add as a tip or in a WHY? button
//         //  as for security reasons email verification is not done using web browsers
//         SupportedLocale.ar => 'تم إرسال رابط التحقق إلى بريدكم الإلكتروني. '
//             'برجاء مراجعة صندوق الرسائل لإتمام التحقق.\n\n'
//             'تنويه: لابد من فتح الرابط باستخدام هذا الجهاز.',
//       };
//
//   static String get tEmailSuccessfullyVerified => switch (_currentLocale) {
//         SupportedLocale.en => 'Email is successfully verified',
//         SupportedLocale.ar => 'تم التحقق من البريد الإلكتروني بنجاح.',
//       };
//
//   static String get tEmailVerificationLinkExpired => switch (_currentLocale) {
//         SupportedLocale.en => 'Verification link is expired. '
//             'Tap the button to resend a new verification email.',
//         SupportedLocale.ar => 'انتهت صلاحية رابط التحقق.'
//             ' اضغط على الزر لإعادة إرسال رابط جديد.',
//       };
//
//   static String get tAccountDisabled => switch (_currentLocale) {
//         SupportedLocale.en => 'Account is disabled',
//         SupportedLocale.ar => 'تم تعطيل الحساب',
//       };
//
//   static String get tAccountNotRegistered => switch (_currentLocale) {
//         SupportedLocale.en => 'Account not registered',
//         SupportedLocale.ar => 'الحساب غير مسجل',
//       };
//
//   static String get tUseStrongPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Use strong passwords. Besides using upper, lower letters, '
//             'numbers and special characters, Avoid using common dictionary words',
//         SupportedLocale.ar => 'استخدم كلمة مرور آمنة. بالإضافة إلى استخدامك حروف كبيرة و صغيرة'
//             ' و أرقام و رموز خاصة، تجنب أي كلمات  مشهورة أو شائعة الاستخدام.',
//       };
//
//   static String get tConnectionErrorTryAgain => switch (_currentLocale) {
//         SupportedLocale.en => 'Connection Error. Try open the link again.',
//         SupportedLocale.ar => 'خطأ في الاتصال. حاول الضغط على الرابط مرة أخرى',
//       };
//
//   static String get tCouldNotVerifyYourEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'Could not verify your email',
//         SupportedLocale.ar => 'لم نتمكن من التحقق من بريدكم الإلكتروني',
//       };
//
// // static String get tTooManyWrongAttemptsResetPasswordWithTry => switch(currentLocale {SupportedLocale.en=>tTooManyWrongAttemptsResetPasswordWithTry,SupportedLocale.ar => throw UnimplementedError(),};
// // static String get tToastResetRecentlyWithTry => switch(currentLocale {SupportedLocale.en=>tToastResetRecentlyWithTry,SupportedLocale.ar => throw UnimplementedError(),};
// // static String get tResetRecentlyWithReason => switch(currentLocale {SupportedLocale.en=>tResetRecentlyWithReason,SupportedLocale.ar => throw UnimplementedError(),};
// //     'Password reset requested recently. For security reasons users are not allowed to request password reset multiple times consecutively. Please Try again later.';
//   static String get tSessionExpired => switch (_currentLocale) {
//         SupportedLocale.en => 'Session expired',
//         SupportedLocale.ar => 'انتهت صلاحية الجلسة',
//       };
//
//   static String get tAccountDeletedSuccessfully => switch (_currentLocale) {
//         SupportedLocale.en => 'Account Deleted Successfully',
//         SupportedLocale.ar => 'تم حذف الحساب بنجاح',
//       };
//
// // static String get tSessionExpiredLoginToContinue => switch(currentLocale {SupportedLocale.en=>tSessionExpiredLoginToContinue,SupportedLocale.ar => throw UnimplementedError(),};
//   static String get tSendVerificationEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'Send Verification Email',
//         SupportedLocale.ar => 'أرسل رابط التحقق',
//       };
//
//   static String get tResendVerificationEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'Resend Verification Email',
//         SupportedLocale.ar => 'أعد إرسال الرابط',
//       };
//
//   static String get tCouldNotSendVerificationEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'Could not send the verification email',
//         SupportedLocale.ar => 'لم نتمكن من إرسال رابط التحقق',
//       };
//
// // static String get tToRiderAppName => switch(currentLocale {SupportedLocale.en=>tToRiderAppName,SupportedLocale.ar => throw UnimplementedError(),};
//
// //  Permission Screen
//   static String get tPermissionScreenTitle => switch (_currentLocale) {
//         SupportedLocale.en => 'Permissions Check',
//         SupportedLocale.ar => 'مراجعة الأذونات',
//       };
//
// // static String get tPermissionScreenSubTitle => switch(currentLocale {SupportedLocale.en=>tPermissionScreenSubTitle,SupportedLocale.ar => throw UnimplementedError(),};
//   static String get tLocationEnabled => switch (_currentLocale) {
//         SupportedLocale.en => 'Location is enabled',
//         SupportedLocale.ar => 'الموقع مفعل',
//       };
//
//   static String get tLocationNotEnabled => switch (_currentLocale) {
//         SupportedLocale.en => 'Location is not enabled',
//         SupportedLocale.ar => 'الموقع غير مفعل',
//       };
//
//   static String get tLocationPermissionAllowed => switch (_currentLocale) {
//         SupportedLocale.en => 'Location Permission Allowed',
//         SupportedLocale.ar => 'إذن الوصول للموقع مسموح به',
//       };
//
//   static String get tLocationPermissionNotAllowed => switch (_currentLocale) {
//         SupportedLocale.en => 'Location Permission is not allowed',
//         SupportedLocale.ar => 'إذن الوصول للموقع غير مسموح به',
//       };
//
//   static String get tNotificationPermissionAllowed => switch (_currentLocale) {
//         SupportedLocale.en => 'Notification Permission Allowed',
//         SupportedLocale.ar => 'إذن إظهار الإشعارات مسموح به',
//       };
//
//   static String get tNotificationPermissionNotAllowed => switch (_currentLocale) {
//         SupportedLocale.en => 'Notification Permission is not allowed',
//         SupportedLocale.ar => 'إذن إظهار الإشعارات غير مسموح به',
//       };
//
  static String tAllow([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Allow',
        SupportedLocale.ar => 'سماح',
      };

  static String tRefresh([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Refresh',
        SupportedLocale.ar => 'تحديث',
      };

//
//   static String get tDriverApply => switch (_currentLocale) {
//         SupportedLocale.en => 'Driver Apply',
//         SupportedLocale.ar => 'تقديم السائق'
//       };
//
//   static String get tWelcome {
//     print(_currentLocale);
//     return switch (_currentLocale) {
//       SupportedLocale.en => 'Welcome',
//       SupportedLocale.ar => 'مرحبا',
//     };
//   }
//
//   static String get tRiderAccountMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'Now your account type is Rider. You can set a destination,'
//             ' pick the trip and the suitable vehicle from drivers\' trips going your way.',
//         SupportedLocale.ar => 'الآن حسابك من نوع راكب. يمكنك تحديد وجهتك '
//             'واختيار الرحلة والسيارة المناسبة من رحلات السائقين المتجهة في مسارك.',
//       };
//
//   static String get tBecomeDriverButton => switch (_currentLocale) {
//         SupportedLocale.en => 'Become Driver',
//         SupportedLocale.ar => 'تقديم السائق'
//       };
//
//   static String get tPendingApplication => switch (_currentLocale) {
//         SupportedLocale.en => 'Pending Application',
//         SupportedLocale.ar => 'تقديم قيد المراجعة'
//       };
//
//   static String get tPendingApplicationMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'Your application is pending review. Once it is done'
//             ' You will receive a feedback in [Menu > Notification Center].',
//         SupportedLocale.ar => 'تقديم السائق قيد المراجعة، سوف تصلكم نتيجة التقديم'
//             ' فور الانتهاء من مراجعة الطلب في [القائمة > مركز الإشعارات].',
//       };
//
//   static String get tSwitchToDriver => switch (_currentLocale) {
//         SupportedLocale.en => 'Switch To Driver',
//         SupportedLocale.ar => 'تحويل لوضع السائق'
//       };
//
//   static String get tSwitchToRider => switch (_currentLocale) {
//         SupportedLocale.en => 'Switch To Rider',
//         SupportedLocale.ar => 'تحويل لوضع الراكب'
//       };
//
//   static String get tBecomeDriverToo => switch (_currentLocale) {
//         SupportedLocale.en => 'Become Driver Too',
//         SupportedLocale.ar => 'تقديم كسائق أيضا'
//       };
//
//   static String get tBecomeDriverTooMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'If you have vacant seats on your trips or regular rides '
//             'you can publish them and earn from riders on your route.',
//         SupportedLocale.ar => 'إذا كان لديك مقعد متاح في رحلاتك أو المشاوير المعتادة لديك'
//             ' يمكنك نشرها و الربح من الركاب المسافرون في طريقك.'
//       };
//
//   static String get tVehicleOwingQuestion => switch (_currentLocale) {
//         SupportedLocale.en => 'Do you own or have a vehicle?',
//         SupportedLocale.ar => 'هل تمتلك أو لديك مركبة؟'
//       };
//
//   static String get tYes => switch (_currentLocale) {
//         SupportedLocale.en => 'Yes',
//         SupportedLocale.ar => 'نعم',
//       };
//
//   static String get tYES => switch (_currentLocale) {
//         SupportedLocale.en => 'YES',
//         SupportedLocale.ar => 'نعم',
//       };
//
//   static String get tLicenceQuestion => switch (_currentLocale) {
//         SupportedLocale.en => 'What about a driving licence?',
//         SupportedLocale.ar => 'ماذا عن رخصة القيادة؟',
//       };
//
//   static String get tHaveIt => switch (_currentLocale) {
//         SupportedLocale.en => 'Have IT',
//         SupportedLocale.ar => 'معي',
//       };
//
//   static String get tGREATWithEXC => switch (_currentLocale) {
//         SupportedLocale.en => 'GREAT!',
//         SupportedLocale.ar => 'رائـع!',
//       };
//
//   static String get tAddVehicleMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'Now you can add a vehicle and become a Driver.',
//         SupportedLocale.ar => 'الآن يمكنك إضافة مركبة و إكمال حساب سائق.',
//       };
//
//   static String get tAddVehicle => switch (_currentLocale) {
//         SupportedLocale.en => 'Add Vehicle',
//         SupportedLocale.ar => 'إضافة مركبة',
//       };
//
//   static String get tContinueAsRider => switch (_currentLocale) {
//         SupportedLocale.en => 'Continue As Rider',
//         SupportedLocale.ar => 'استمرار كراكب',
//       };
//
//   static String get tNo => switch (_currentLocale) {
//         SupportedLocale.en => 'No',
//         SupportedLocale.ar => 'لا',
//       };
//
//   static String get tNO => switch (_currentLocale) {
//         SupportedLocale.en => 'NO',
//         SupportedLocale.ar => 'لا',
//       };
//
//   /// Labels & Hints TextFields
//
//   static String get tUserName => switch (_currentLocale) {
//         SupportedLocale.en => 'User Name',
//         SupportedLocale.ar => 'اسم المستخدم',
//       };
//
//   static String get tName => switch (_currentLocale) {
//         SupportedLocale.en => 'Name',
//         SupportedLocale.ar => 'الاسم',
//       };
//
//   static String get tLabelPhone => switch (_currentLocale) {
//         SupportedLocale.en => 'Phone Number',
//         SupportedLocale.ar => 'رقم الهاتف',
//       };
//
//   static String get tHintPhone => '01*********';
//
  static String tLabelEmail([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'E-mail',
        SupportedLocale.ar => 'البريد الإلكتروني',
      };

//
//   static String get tLabelPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Password',
//         SupportedLocale.ar => 'كلمة المرور',
//       };
//
//   static String get tLabelConfirmPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Confirm Password',
//         SupportedLocale.ar => 'تأكيد كلمة المرور',
//       };
//
//   /// Validators TextFields
//
//   static String get tValEmptyName => switch (_currentLocale) {
//         SupportedLocale.en => 'Name is not provided',
//         SupportedLocale.ar => 'لم يتم إدخال الاسم',
//       };
//
//   static String get tValTooLongName => switch (_currentLocale) {
//         SupportedLocale.en => 'Name is too long',
//         SupportedLocale.ar => 'الإسم طويل للغاية',
//       };
//
//   static String get tValEmptyPhone => switch (_currentLocale) {
//         SupportedLocale.en => 'Phone Number is not provided',
//         SupportedLocale.ar => 'لم يتم إدخال رقم الهاتف',
//       };
//
//   static String get tValInvalidPhone => switch (_currentLocale) {
//         SupportedLocale.en => 'Phone Number is not valid',
//         SupportedLocale.ar => 'رقم الهاتف غير صالح',
//       };
//
//   static String get tValEmptyEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'Email is not provided',
//         SupportedLocale.ar => 'لم يتم إدخال البريد الإلكتروني',
//       };
//
//   static String get tValInvalidEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'Email is not valid',
//         SupportedLocale.ar => 'البريد الإلكتروني غير صالح',
//       };
//
//   static String get tValEmptyPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Password is not provided',
//         SupportedLocale.ar => 'لم يتم إدخال كلمة المرور',
//       };
//
//   static String get tValPasswordAlreadyUsed => switch (_currentLocale) {
//         SupportedLocale.en => 'Password is already used',
//         SupportedLocale.ar => 'كلمة المرور مستخدمة بالفعل',
//       };
//
//   static String get tValEmptyConfirmPassword => switch (_currentLocale) {
//         SupportedLocale.en => 'Please confirm your password',
//         SupportedLocale.ar => 'فضلا قم بتأكيد كلمة المرور',
//       };
//
//   static String get tValPasswordDoNotMatch => switch (_currentLocale) {
//         SupportedLocale.en => "Passwords Don't Match",
//         SupportedLocale.ar => 'كلمة المرور غير مطابقة',
//       };
//
//   /// Buttons
//
//   static String get tLOGIN => switch (_currentLocale) {
//         SupportedLocale.en => 'LOGIN',
//         SupportedLocale.ar => 'سجل دخول',
//       };
//
//   static String get tLogin => switch (_currentLocale) {
//         SupportedLocale.en => 'Login',
//         SupportedLocale.ar => 'سجل دخول',
//       };
//
//   static String get tNext => switch (_currentLocale) {
//         SupportedLocale.en => 'Next',
//         SupportedLocale.ar => 'متابعة',
//       };
//
//   static String get tNEXT => switch (_currentLocale) {
//         SupportedLocale.en => 'NEXT',
//         SupportedLocale.ar => 'متابعة',
//       };
//
//   static String get tGetStarted => switch (_currentLocale) {
//         SupportedLocale.en => 'GET STARTED',
//         SupportedLocale.ar => 'إبدأ التسجيل',
//       };
//
//   static String get tGoogleAccount => switch (_currentLocale) {
//         SupportedLocale.en => 'Google Account',
//         SupportedLocale.ar => 'حساب Google',
//       };
//
//   static String get tAppleIDToolTip => 'Apple ID';
//
//   static String get tOrUse => switch (_currentLocale) {
//         SupportedLocale.en => 'Or use you account in',
//         SupportedLocale.ar => 'أو استخدم حسابك لدى',
//       };
//
//   static String get tB4GoogleSigningDialogueContent {
//     final android = Platform.isAndroid;
//     return android
//         ? switch (_currentLocale) {
//             SupportedLocale.en => 'You will be prompted to allow access to your name, '
//                 'email address and profile picture associated with your Google account.\n\n'
//                 'Note: This method may not work if your device is not connected with a Google account.',
//             SupportedLocale.ar => 'سيُطلب منك السماح بالوصول إلى اسمك و بريدك الإلكتروني '
//                 'و صورة ملفك الشخصي المرتبطة بحسابك على Google.\n\n'
//                 'ملاحظة: قد لا تعمل هذه الطريقة إذا كان جهازك غير مرتبط بحساب Google.',
//           }
//         : switch (_currentLocale) {
//             SupportedLocale.en => 'You will be prompted to allow access to your name, '
//                 'email address and profile picture associated with your Google account.\n\n'
//                 'Note: This may open your web browser.',
//             SupportedLocale.ar => 'سيُطلب منك السماح بالوصول إلى اسمك و بريدك الإلكتروني '
//                 'و صورة ملفك الشخصي المرتبطة بحسابك على Google.\n\n'
//                 'ملاحظة: قد يتم فتح المتفصح لإتمام هذه الخطوة.',
//           };
//   }
//
//   static String tCannotResetPwFor3rdParty(String word) {
//     return switch (_currentLocale) {
//       SupportedLocale.en => 'This account was created via $word'
//           ' and it does not have a password.\n\nIf you have access to your $word'
//           ' You can use to login right away.',
//       SupportedLocale.ar => 'هذا الحساب تم إنشاؤه بواسطة $word'
//           ' و ليس لديه كلمة مرور.\n\nإذا يمكنكم الوصول لحساب $word'
//           ' الخاص بكم يمكن استخدامه لتسجيل الدخول.',
//     };
//   }
//
//   static String get tRegisterTextButton => switch (_currentLocale) {
//         SupportedLocale.en => 'Register',
//         SupportedLocale.ar => 'قم بالتسجيل',
//       };
//
//   static String get tForgotPasswordTextButton => switch (_currentLocale) {
//         SupportedLocale.en => 'Forgot Password ?',
//         SupportedLocale.ar => 'نسيت كلمة المرور ؟',
//       };
//
//   static String get tSendEmailButtonInRecover => switch (_currentLocale) {
//         SupportedLocale.en => 'Send Recovery Email',
//         SupportedLocale.ar => 'أرسل بريد الاسترجاع',
//       };
//
//   static String get tVerifyButton => switch (_currentLocale) {
//         SupportedLocale.en => 'Verify',
//         SupportedLocale.ar => 'تحقق',
//       };
//
//   static String get tConfirmDestinationButton => switch (_currentLocale) {
//         SupportedLocale.en => 'Confirm Destination',
//         SupportedLocale.ar => 'تأكيد الوجهة',
//       };
//
//   static String get tConfirmPickUpButton => switch (_currentLocale) {
//         SupportedLocale.en => 'Confirm Pick Up',
//         SupportedLocale.ar => 'تأكيد مكان التقابل',
//       };
//
//   static String get tConfirm => switch (_currentLocale) {
//         SupportedLocale.en => 'Confirm',
//         SupportedLocale.ar => 'تأكيد',
//       };
//
//   static String get tPublishButton => switch (_currentLocale) {
//         SupportedLocale.en => 'Publish',
//         SupportedLocale.ar => 'انشر',
//       };
//
//   static String get tSubmitButton => switch (_currentLocale) {
//         SupportedLocale.en => 'Submit',
//         SupportedLocale.ar => 'إدخال',
//       };
//
//   static String get tDone => switch (_currentLocale) {
//         SupportedLocale.en => 'Done',
//         SupportedLocale.ar => 'تم',
//       };
//
//   static String get tFinish => switch (_currentLocale) {
//         SupportedLocale.en => 'Finish',
//         SupportedLocale.ar => 'إكمال',
//       };
//
  static String tViewProfile([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'View Profile',
        SupportedLocale.ar => 'عرض البيانات الشخصية',
      };
  static String tSetTotalTime([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Set Total Time',
        SupportedLocale.ar => 'حدد الوقت الإجمالي',
      };
  static String tPleaseDetermineLadderTime([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Please determine ladder time',
        SupportedLocale.ar => 'قد بتحديد وقت السلم',
      };
  static String tGo([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Go',
        SupportedLocale.ar => 'إبدأ',
      };
  static String tStart([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'START',
        SupportedLocale.ar => 'إبدأ',
      };
  static String tPause([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Pause',
        SupportedLocale.ar => 'إيقاف',
      };
  static String tResume([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Resume',
        SupportedLocale.ar => 'إكمال',
      };
  static String tAbort([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Abort',
        SupportedLocale.ar => 'إنهاء',
      };
  static String tRest([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Rest',
        SupportedLocale.ar => 'راحة',
      };

//
//   /// In App Scaffold Bodies
//
//   /// Schedule
//
// // static String get int schedulePageIndex = 0;
//   static String get tSchedulePageTitle => switch (_currentLocale) {
//         SupportedLocale.en => 'Schedule',
//         SupportedLocale.ar => 'الجدول الزمني',
//       };
//
//   static String get tProvideVehicleInformation => switch (_currentLocale) {
//         SupportedLocale.en => 'Please provide your vehicle information '
//             'and upload its photos as shown in the examples.',
//         SupportedLocale.ar => 'يرجى إدخال معلومات المركبة '
//             'وإرفاق الصور الخاصة بها كالأمثلة الموضحة.'
//       };
//
//   static String get tManufacturingYear => switch (_currentLocale) {
//         SupportedLocale.en => 'Manufacturing Year',
//         SupportedLocale.ar => 'سنة الصنع',
//       };
//
//   static String get tVehicleType => switch (_currentLocale) {
//         SupportedLocale.en => 'Vehicle Type',
//         SupportedLocale.ar => 'نوع المركبة',
//       };
//
//   static String get tVehicleFrontImage => switch (_currentLocale) {
//         SupportedLocale.en => 'Front Image',
//         SupportedLocale.ar => 'الصورة الأمامية',
//       };
//
//   static String get tVehicleRearImage => switch (_currentLocale) {
//         SupportedLocale.en => 'Rear Image',
//         SupportedLocale.ar => 'الصورة الخلفية',
//       };
//
//   static String get tVehicleLicenseFront => switch (_currentLocale) {
//         SupportedLocale.en => 'Vehicle License Front',
//         SupportedLocale.ar => 'وجه رخصة المركبة'
//       };
//
//   static String get tVehicleLicenseBack => switch (_currentLocale) {
//         SupportedLocale.en => 'Vehicle License Back',
//         SupportedLocale.ar => 'ظهر رخصة المركبة',
//       };
//
//   static String get tMotorcycleLicenseFront => switch (_currentLocale) {
//         SupportedLocale.en => 'Motorcycle License Front',
//         SupportedLocale.ar => 'وجه رخصة الدراجة النارية'
//       };
//
//   static String get tMotorcycleLicenseBack => switch (_currentLocale) {
//         SupportedLocale.en => 'Motorcycle License Back',
//         SupportedLocale.ar => 'ظهر رخصة الدراجة النارية'
//       };
//
//   static String get tDrivingLicenseFront => switch (_currentLocale) {
//         SupportedLocale.en => 'Driving License Front',
//         SupportedLocale.ar => 'وجه رخصة القيادة',
//       };
//
//   static String get tDrivingLicenseBack => switch (_currentLocale) {
//         SupportedLocale.en => 'Driving License Back',
//         SupportedLocale.ar => 'ظهر رخصة القيادة'
//       };
//
//   static String get tUpdateImage => switch (_currentLocale) {
//         SupportedLocale.en => 'Update Image',
//         SupportedLocale.ar => 'تحديث الصورة',
//       };
//
//   static String get tCar => switch (_currentLocale) {
//         SupportedLocale.en => 'Car',
//         SupportedLocale.ar => 'سيارة',
//       };
//
//   static String get tMotorcycle => switch (_currentLocale) {
//         SupportedLocale.en => 'Motorcycle',
//         SupportedLocale.ar => 'دراجة نارية',
//       };
//
//   static String get tOthers => switch (_currentLocale) {
//         SupportedLocale.en => 'Others',
//         SupportedLocale.ar => 'أخرى',
//       };
//
// // Published
//   static String get tPublished => switch (_currentLocale) {
//         SupportedLocale.en => 'Published',
//         SupportedLocale.ar => 'معلنة',
//       };
//
//   static String get tSetYourRoute => switch (_currentLocale) {
//         SupportedLocale.en => 'Set your route',
//         SupportedLocale.ar => 'قم بتحديد مسارك',
//       };
//
//   static String get tToSeeRangers => switch (_currentLocale) {
//         SupportedLocale.en => 'To see Rangers going your way',
//         SupportedLocale.ar => 'للاطلاع على الرحلات ............',
//       };
//
//   static String get tCannotFindRangers => switch (_currentLocale) {
//         SupportedLocale.en => 'We could not find any ranger to  ............. pick you up.',
//         SupportedLocale.ar => 'لم نتمكن من العثور على أي رحلة عابرة في مسارك أو بالقرب منه',
//       };
//
//   static String get tBook => switch (_currentLocale) {
//         SupportedLocale.en => 'Book',
//         SupportedLocale.ar => 'احجز',
//       };
//
// // static String get tYouCanSchedule => switch(currentLocale {SupportedLocale.en=>tYouCanSchedule,SupportedLocale.ar => throw UnimplementedError(),};
//   static String get tUpdatingPublished => switch (_currentLocale) {
//         SupportedLocale.en => 'Updating Published Trips',
//         SupportedLocale.ar => 'جاري تحديث الرحلات المعلنة',
//       };
//
//   static String get tPickUpDistance => switch (_currentLocale) {
//         SupportedLocale.en => 'Pick up Distance: ',
//         SupportedLocale.ar => 'بعد الالتقاط: ',
//       };
//
//   static String get tDropOffDistance => switch (_currentLocale) {
//         SupportedLocale.en => 'Drop-off Distance: ',
//         SupportedLocale.ar => 'throw UnimplementedError()',
//       };
//
//   static String get tCannotFindAnyRangers => switch (_currentLocale) {
//         SupportedLocale.en => 'Can\'t find any ranger going your way',
//         SupportedLocale.ar => 'throw UnimplementedError()',
//       };
//
//   static String get tChangeFilterSettings => switch (_currentLocale) {
//         SupportedLocale.en => 'Change filter Settings to expand your search',
//         SupportedLocale.ar => 'قم بتغيير إعدادات التنقية لتوسيع دائرة البحث',
//       };
//
// // Booked
//   static String get tBooked => switch (_currentLocale) {
//         SupportedLocale.en => 'Booked',
//         SupportedLocale.ar => 'محجوزة',
//       };
//
//   static String get tUpdatingBookings => switch (_currentLocale) {
//         SupportedLocale.en => 'Updating Bookings',
//         SupportedLocale.ar => 'جاري تحديث الحجوزات',
//       };
//
//   static String get tPending => switch (_currentLocale) {
//         SupportedLocale.en => 'Pending',
//         SupportedLocale.ar => 'تم الإرسال',
//       };
//
//   static String get tNotified => switch (_currentLocale) {
//         SupportedLocale.en => 'Notified',
//         SupportedLocale.ar => 'تم الاستلام',
//       };
//
//   static String get tNotAccepted => switch (_currentLocale) {
//         SupportedLocale.en => 'Not Accepted',
//         SupportedLocale.ar => 'لم يقبل',
//       };
//
//   static String get tAccepted => switch (_currentLocale) {
//         SupportedLocale.en => 'Accepted',
//         SupportedLocale.ar => 'تم القبول',
//       };

  static String tCancel([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Cancel',
        SupportedLocale.ar => 'إنهاء',
      };

  static String tDismiss([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Dismiss',
        SupportedLocale.ar => 'تجاهل',
      };

//
//   static String get tSaveInArchive => switch (_currentLocale) {
//         SupportedLocale.en => 'Save In Archive',
//         SupportedLocale.ar => 'حفظ في الأرشيف',
//       };
//
//   static String get tBookedTripsWillShowHere => switch (_currentLocale) {
//         SupportedLocale.en => 'Booked Trips will be listed here',
//         SupportedLocale.ar => 'الرحلات المحجورة سوف تعرض في هذه الصفحة',
//       };
//
// // History
// // History is part if home Nav but consumes Schedule Cubit
// //   static String get int historyPageIndex = 3;
//   static String get tArchivePageTitle => switch (_currentLocale) {
//         SupportedLocale.en => 'Archive',
//         SupportedLocale.ar => 'الأرشيف',
//       };
//
//   static String get tLoadingArchive => switch (_currentLocale) {
//         SupportedLocale.en => 'Loading Archive',
//         SupportedLocale.ar => 'تحميل بيانات الأرشيف',
//       };
//
//   static String get tCompletedTripsWillShowHere => switch (_currentLocale) {
//         SupportedLocale.en => 'Completed Trips will be listed here',
//         SupportedLocale.ar => 'throw UnimplementedError()',
//       };
//
// // Arranged
//   static String get tArranged => switch (_currentLocale) {
//         SupportedLocale.en => 'Arranged',
//         SupportedLocale.ar => 'تم تنسيقها',
//       };
//
//   static String get tArrangedTripsWillShowHere => switch (_currentLocale) {
//         SupportedLocale.en => 'Arranged Trips will be listed here',
//         SupportedLocale.ar => 'الرحلات المنسقة سوف تعرض في هذه الصفحة',
//       };
//
//   static String get tUpdatingArrangements => switch (_currentLocale) {
//         SupportedLocale.en => 'Updating Arrangements',
//         SupportedLocale.ar => 'تحديث التنسيقات',
//       };
//
// // Filter UI
//   static String get tSearchButton => switch (_currentLocale) {
//         SupportedLocale.en => 'Search',
//         SupportedLocale.ar => 'بحث',
//       };
//
//   static String get tFilter => switch (_currentLocale) {
//         SupportedLocale.en => 'Filter',
//         SupportedLocale.ar => 'تنقية',
//       };
//
//   static String get tMaxPickUpDistance => switch (_currentLocale) {
//         SupportedLocale.en => 'Max Pick Up Distance: ',
//         SupportedLocale.ar => 'أقصى بعد عن مكان التقابل: ',
//       };
//
//   static String get tMaxDropOffDistance => switch (_currentLocale) {
//         SupportedLocale.en => 'Max Drop-off Distance: ',
//         SupportedLocale.ar => 'أقصى بعد عن الوجهة: ',
//       };
//
//   static String get tMinAvailableSeats => switch (_currentLocale) {
//         SupportedLocale.en => 'Minimum Seats: ',
//         SupportedLocale.ar => 'الحد الأدنى للمقاعد',
//       };
//
//   static String get tLabelShowUntil => switch (_currentLocale) {
//         SupportedLocale.en => 'Show Trips Until',
//         SupportedLocale.ar => 'إعرض الرحلات حتى',
//       };
//
//   static String get tHintShowUntil => switch (_currentLocale) {
//         SupportedLocale.en => 'throw UnimplementedError()',
//         SupportedLocale.ar => 'throw UnimplementedError()',
//       };
//
//   /// Chat View
//   static String get tLoadingMessages => switch (_currentLocale) {
//         SupportedLocale.en => 'Loading Messages',
//         SupportedLocale.ar => 'جاري تحميل الرسائل',
//       };
//
//   static String get tNoMessages => switch (_currentLocale) {
//         SupportedLocale.en => 'No Messages',
//         SupportedLocale.ar => 'لا توجد رسائل',
//       };
//
//   static String get tStartMessagingBelow => switch (_currentLocale) {
//         SupportedLocale.en => 'Start messaging below',
//         SupportedLocale.ar => 'إبدأ المحادثة بالأسفل',
//       };
//
//   static String get tSomethingWentWrong => switch (_currentLocale) {
//         SupportedLocale.en => 'Something went wrong',
//         SupportedLocale.ar => 'حدث خطأ ما',
//       };
//
//   static String get tReload => switch (_currentLocale) {
//         SupportedLocale.en => 'Reload',
//         SupportedLocale.ar => 'إعادة التحميل',
//       };
//
//   static String get tNoRecentlyUsedEmojis => switch (_currentLocale) {
//         SupportedLocale.en => 'No Recently Used Emojis',
//         SupportedLocale.ar => 'لا توجد إشعارات مستخدمة مؤخرًا',
//       };

  static String tPermissionDenied([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Permission Denied',
        SupportedLocale.ar => 'الإذن غير مسموح به',
      };

  static String tMicrophoneReason([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'record voice messages',
        SupportedLocale.ar => 'تسجيل رسائل صوتية',
      };

  static String tCameraReason([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'take a picture',
        SupportedLocale.ar => 'التقاط صورة',
      };

  static String tPhotosReason([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'pick a photo',
        SupportedLocale.ar => 'الاختيار من الصور',
      };

  static String tLocationAlwaysReadableName([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Background Location Access',
        SupportedLocale.ar => 'الوصول للموقع في الخلفية',
      };

  static String tLocationAlwaysReason([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'track your location',
        SupportedLocale.ar => 'تتبع موقعك',
      };

//
//   static String get tConfirmDelete => switch (_currentLocale) {
//         SupportedLocale.en => 'Confirm Delete',
//         SupportedLocale.ar => 'تأكيد الحذف',
//       };
//
//   static String get tActionCannotBeUndone => switch (_currentLocale) {
//         SupportedLocale.en =>
//           'When you tap Delete you will delete the message for everyone. You can not undo this action.',
//         SupportedLocale.ar => 'عند الضغط على حذف ستقوم بحذف الرسالة للجميع. لا يمكن الرجوع في هذا الحذف',
//       };
//
//   static String get tAreYouSureToDelete => switch (_currentLocale) {
//         SupportedLocale.en => 'Are you sure to delete this message ?',
//         SupportedLocale.ar => 'هل تود حذف الرسالة ؟',
//       };
//
//   static String get tDeletedMessage => switch (_currentLocale) {
//         SupportedLocale.en => 'Deleted Message',
//         SupportedLocale.ar => 'رسالة محذوفة',
//       };
//
//   static String get tCancelRecoding => switch (_currentLocale) {
//         SupportedLocale.en => 'Cancel Recording',
//         SupportedLocale.ar => 'إنهاء التسجيل',
//       };
//
//   static String get tYouAreRecodingVoice => switch (_currentLocale) {
//         SupportedLocale.en => 'You are recording a voice message. $tAreYouSureToCancel',
//         SupportedLocale.ar => '$tAreYouSureToCancelالآن يتم تسجيل رسالة صوتية. ',
//       };
//
//   static String get tAreYouSureToCancel => switch (_currentLocale) {
//         SupportedLocale.en => 'Do you want to cancel ?',
//         SupportedLocale.ar => 'هل تود الإنهاء ؟',
//       };
//
  static String permissionRequestMessage(String readableName, String reason, [WidgetRef? ref]) =>
      switch (_currentLocale(ref)) {
        SupportedLocale.en => '$readableName permission is required to $reason.',
        SupportedLocale.ar => 'إذن $readableName مطلوب من أجل $reason.'
      };

//
  static String permissionSettingMessage(String readableName, String reason, [WidgetRef? ref]) =>
      switch (_currentLocale(ref)) {
        SupportedLocale.en =>
          'Allow ${GlobalConstants.appName} $readableName permission in app settings to $reason.',
        SupportedLocale.ar =>
          ' قم بالسماح ل ${GlobalConstants.appName} بإذن $readableName في إعدادات الجهاز.'
      };

//
// // class L10nStrings {
// // static static String get String today => switch(currentLocale {SupportedLocale.en=>today,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String yesterday => switch(currentLocale {SupportedLocale.en=>yesterday,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String repliedToYou => switch(currentLocale {SupportedLocale.en=>repliedToYou,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String repliedBy => switch(currentLocale {SupportedLocale.en=>repliedBy,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String reply => switch(currentLocale {SupportedLocale.en=>reply,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String copy => switch(currentLocale {SupportedLocale.en=>copy,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String edit => switch(currentLocale {SupportedLocale.en=>edit,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String cancelSending => switch(currentLocale {SupportedLocale.en=>cancelSending,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String delete => switch(currentLocale {SupportedLocale.en=>delete,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String report => switch(currentLocale {SupportedLocale.en=>report,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String replyTo => switch(currentLocale {SupportedLocale.en=>replyTo,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String message => switch(currentLocale {SupportedLocale.en=>message,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String reactionPopupTitle => switch(currentLocale {SupportedLocale.en=>reactionPopupTitle,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String photo => switch(currentLocale {SupportedLocale.en=>photo,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String send => switch(currentLocale {SupportedLocale.en=>send,SupportedLocale.ar => throw UnimplementedError(),};
// // static static String get String you => switch(currentLocale {SupportedLocale.en=>you,SupportedLocale.ar => throw UnimplementedError(),};
// // }
// //
// // class ReceiptsCustomMessages implements LookupMessages {
// // @override
// // String prefixAgo(),> prefixAgo;
// //
// // @override
// // String prefixFromNow(),> prefixFromNow;
// //
// // @override
// // String suffixAgo(),> suffixAgo;
// //
// // @override
// // String suffixFromNow(),> suffixFromNow;
// //
// // @override
// // String lessThanOneMinute(int seconds) > seconds;
// //
// // @override
// // String aboutAMinute(int minutes) > minutes;
// //
// // @override
// // String minutes(int minutes) > minutes;
// //
// // @override
// // String aboutAnHour(int minutes) > minutes;
// //
// // @override
// // String hours(int hours) > hours;
// //
// // @override
// // String aDay(int hours) > hours;
// //
// // @override
// // String days(int days) > days;
// //
// // @override
// // String aboutAMonth(int days) > days;
// //
// // @override
// // String months(int months) > months;
// //
// // @override
// // String aboutAYear(int year) > year;
// //
// // @override
// // String years(int years) > years;
// //
// // @override
// // String wordSeparator(),> wordSeparator;
// // }
//
//   /// Account
// // static String get int accountPageIndex = 1;
//   static String get tAccount => switch (_currentLocale) {
//         SupportedLocale.en => 'Account',
//         SupportedLocale.ar => 'الحساب',
//       };
//
//   static String get tBirthday => switch (_currentLocale) {
//         SupportedLocale.en => 'Birthday',
//         SupportedLocale.ar => 'تاريخ الميلاد',
//       };
//
//   static String get tPhone => switch (_currentLocale) {
//         SupportedLocale.en => 'Phone',
//         SupportedLocale.ar => 'الهاتف',
//       };
//
//   static String get tWallet => switch (_currentLocale) {
//         SupportedLocale.en => 'Wallet',
//         SupportedLocale.ar => 'المحفظة',
//       };
//
//   static String get tBalance => switch (_currentLocale) {
//         SupportedLocale.en => 'Balance:',
//         SupportedLocale.ar => 'الرصيد:',
//       };
//
//   static String get tNoPhone => switch (_currentLocale) {
//         SupportedLocale.en => 'No Phone Registered',
//         SupportedLocale.ar => 'رقم الهاتف غير مسجل',
//       };
//
//   static String get tNoEmail => switch (_currentLocale) {
//         SupportedLocale.en => 'No E-mail Registered',
//         SupportedLocale.ar => 'البريد الإلكتروني غير مسجل',
//       };
//
//   static String get tNoBirthday => switch (_currentLocale) {
//         SupportedLocale.en => 'No Birthday Registered',
//         SupportedLocale.ar => 'تاريخ الميلاد غير مسجل',
//       };
//
//   /// TODO : Check This out .. according to country as I Suppose using IP LOCATION FO EX
//   static String get tCurrency => switch (_currentLocale) {
//         SupportedLocale.en => ' EGP',
//         SupportedLocale.ar => ' جنيه مصري',
//       };
//
//   static String get tUpdateProfileImage => switch (_currentLocale) {
//         SupportedLocale.en => 'Update Profile Image',
//         SupportedLocale.ar => 'حدث الصورة الشخصية',
//       };
//
//   static String get tLogout => switch (_currentLocale) {
//         SupportedLocale.en => 'Logout',
//         SupportedLocale.ar => 'تسجيل الخروج',
//       };
//
//   /// Map
// // static String get int mapPageIndex => switch(currentLocale {SupportedLocale.en=>mapPageIndex,SupportedLocale.ar => throw UnimplementedError(),};
//   static String get tMapPageTitle => switch (_currentLocale) {
//         SupportedLocale.en => 'Map',
//         SupportedLocale.ar => 'الخريطة',
//       };
//
//   static String get tHintSearchPlaces => switch (_currentLocale) {
//         SupportedLocale.en => 'Search Places ...',
//         SupportedLocale.ar => 'بحث الأماكن ...',
//       };
//
//   static String get tLabelSearchPlaces => switch (_currentLocale) {
//         SupportedLocale.en => 'Search',
//         SupportedLocale.ar => 'بحث',
//       };
//
//   /// Settings
// // static String get int settingsPageIndex => switch(currentLocale {SupportedLocale.en=>settingsPageIndex,SupportedLocale.ar => throw UnimplementedError(),};
//
  /// Privacy Policy Screen
  static String tPrivacyPolicy([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Privacy Policy',
        SupportedLocale.ar => 'سياية الخصوصية',
      };

  /// Terms of Use Screen
  static String tTermsOfUse([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Terms of Use',
        SupportedLocale.ar => 'بنود الاستخدام',
      };

  /// Contact Us Screen
  static String tContactUs([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'Contact Us',
        SupportedLocale.ar => 'تواصل معنا',
      };

//
//   static String get tEmailUsAt => switch (_currentLocale) {
//         SupportedLocale.en => 'E-Mail us at:',
//         SupportedLocale.ar => 'راسلنا عبر البريد الإلكتروني:',
//       };
//
//   static String get tToastCopiedToClipboard => switch (_currentLocale) {
//         SupportedLocale.en => 'Copied to Clipboard',
//         SupportedLocale.ar => 'تم النسخ إلى الحافظة',
//       };
//
  /// About Screen
  static String tAbout([WidgetRef? ref]) => switch (_currentLocale(ref)) {
        SupportedLocale.en => 'About',
        SupportedLocale.ar => 'عن التطبيق',
      };
//
//   static String get tVersion => switch (_currentLocale) {
//         SupportedLocale.en => 'Version 3.0',
//         SupportedLocale.ar => 'نسخة 3.0',
//       };
//
//   static String get today => switch (_currentLocale) {
//         SupportedLocale.en => 'Today',
//         SupportedLocale.ar => 'اليوم',
//       };
//
//   static String get yesterday => switch (_currentLocale) {
//         SupportedLocale.en => 'Yesterday',
//         SupportedLocale.ar => 'أمس',
//       };
//
//   static String get repliedToYou => switch (_currentLocale) {
//         SupportedLocale.en => 'Replied to you',
//         SupportedLocale.ar => 'تم الرد على THrow',
//       };
//
//   static String get repliedBy => switch (_currentLocale) {
//         SupportedLocale.en => 'Replied by',
//         SupportedLocale.ar => 'رد من',
//       };
//
//   static String get reply => switch (_currentLocale) {
//         SupportedLocale.en => 'Reply',
//         SupportedLocale.ar => 'رد',
//       };
//
//   static String get copy => switch (_currentLocale) {
//         SupportedLocale.en => 'Copy',
//         SupportedLocale.ar => 'نسخ',
//       };
//
//   static String get edit => switch (_currentLocale) {
//         SupportedLocale.en => 'Edit',
//         SupportedLocale.ar => 'تعديل',
//       };
//
//   static String get cancelSending => switch (_currentLocale) {
//         SupportedLocale.en => 'Cancel Sending',
//         SupportedLocale.ar => 'إنهاء الإرسال',
//       };
//
//   static String get delete => switch (_currentLocale) {
//         SupportedLocale.en => 'Delete',
//         SupportedLocale.ar => 'حذف',
//       };
//
//   static String get deleteAll => switch (_currentLocale) {
//         SupportedLocale.en => 'Delete ALL',
//         SupportedLocale.ar => 'حذف الكل',
//       };
//
//   static String get tCancelApply => switch (_currentLocale) {
//         SupportedLocale.en => 'Cancel Apply',
//         SupportedLocale.ar => 'إنهاء التقديم'
//       };
//
//   static String get tCancelUploadingImages => switch (_currentLocale) {
//         SupportedLocale.en => 'Cancel images upload',
//         SupportedLocale.ar => 'إنهاء رفع الصور'
//       };
//
//   static String get tConfirmDeleteAllImages => switch (_currentLocale) {
//         SupportedLocale.en => 'Do you want to delete all images ?'
//             '\n\nNote: Images will not be deleted from your device.',
//         SupportedLocale.ar => 'هل تريد حذف جميع الصور ؟'
//             '\n\nتنويه: لن يتم حذف الصور من الجهاز.'
//       };
//
//   static String get report => switch (_currentLocale) {
//         SupportedLocale.en => 'Report',
//         SupportedLocale.ar => 'إبلاغ',
//       };
//
//   static String get replyTo => switch (_currentLocale) {
//         SupportedLocale.en => 'Replying to',
//         SupportedLocale.ar => 'رد على',
//       };
//
//   static String get message => switch (_currentLocale) {
//         SupportedLocale.en => 'Message',
//         SupportedLocale.ar => 'رسالة',
//       };
//
// // static String get reactionPopupTitle => switch (currentLocale) {
// //       SupportedLocale.en => 'Tap and hold to multiply your reaction',
// //       SupportedLocale.ar => "throw UnimplementedError()",
// //     };
//
//   static String get photo => switch (_currentLocale) {
//         SupportedLocale.en => 'Photo',
//         SupportedLocale.ar => 'صورة',
//       };
//
//   static String get send => switch (_currentLocale) {
//         SupportedLocale.en => 'Send',
//         SupportedLocale.ar => 'أرسل',
//       };
//
//   static String get you => switch (_currentLocale) {
//         SupportedLocale.en => 'You',
//         SupportedLocale.ar => 'أنت',
//       };
}
