// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../../../Styles/app_colors.dart';
// import 'android_parts.dart';
//
// abstract class MyAndroidNBaseDetails {
//   /// The icon that should be used when displaying the notification.
//   ///
//   /// When this is set to `null`, the default icon given to
//   /// [AndroidInitializationSettings.defaultIcon] will be used.
//   final String? icon;
//
//   /// Specifies the group that this notification belongs to.
//   ///
//   /// For Android 7.0 or newer.
//   final String? groupKey;
//
//   /// Specifies if this notification will function as the summary for grouped
//   /// notifications.
//   final bool setAsGroupSummary;
//
//   /// Specifies the group alert behavior for this notification.
//   ///
//   /// Default is AlertAll.
//   /// See https://developer.android.com/reference/android/support/v4/app/NotificationCompat.Builder.html#setGroupAlertBehavior(int) for more details.
//   final GroupAlertBehavior groupAlertBehavior;
//
//   /// Specifies if the notification should automatically dismissed upon tapping
//   /// on it.
//   final bool dismissOnTap;
//
//   /// Specifies if the notification will be "ongoing".
//   ///
//   /// Note: If set to [true] and [dismissOnTap] is set [false]
//   ///
//   /// User can't dismiss it .. In this case It can ONLY be cancelled programmatically.
//   final bool notDismissible;
//
//   /// Should be used apart of [dismissOnTap] and [notDismissible]
//   ///
//   /// Since it sets them both to [true] in order to achieve what's needed
//   final bool mustTapToDismiss;
//
//   /// Specifies if the notification will be "silent".
//   final bool silent;
//
//   /// Specifies the color.
//   final Color? color;
//
//   /// Specifics the large icon to use.
//   final AndroidBitmap<Object>? largeIcon;
//
//   /// Specifies if you would only like the sound, vibrate and ticker to be
//   /// played if the notification is not already showing.
//   final bool onlyAlertOnce;
//
//   /// Specifies if the notification should display the timestamp of when it
//   ///  occurred.
//   ///
//   /// To control the actual timestamp of the notification, use [atTime].
//   final bool showAtTime;
//
//   /// Specifies the timestamp of the notification.
//   ///
//   /// To control whether the timestamp is shown in the notification, use
//   /// [showAtTime].
//   ///
//   /// The timestamp is expressed as the number of milliseconds since the
//   /// "Unix epoch" 1970-01-01T00:00:00Z (UTC). If it's not specified but a
//   /// timestamp should be shown (i.e. [showAtTime] is set to `true`),
//   /// then Android will default to showing when the notification occurred.
//   final DateTime? atTime;
//
//   /// Show [atTime] as a stopwatch.
//   ///
//   /// Instead of presenting [atTime] as a timestamp, the notification will show an
//   /// automatically updating display of the minutes and seconds since [atTime].
//   /// Useful when showing an elapsed time (like an ongoing phone call).
//   final bool usesChronometer;
//
//   /// Sets the chronometer to count down instead of counting up.
//   ///
//   /// This property is only applicable to Android 7.0 and newer versions.
//   final bool chronometerCountDown;
//
//   /// Specifies if the notification will be used to show progress.
//   final bool showProgress;
//
//   /// The maximum progress value.
//   final int maxProgress;
//
//   /// The current progress value.
//   final int progress;
//
//   /// Specifies if an indeterminate progress bar will be shown.
//   final bool indeterminate;
//
//   /// Specifies how long the light colour will remain on.
//   ///
//   /// This property is only applicable to Android versions older than 8.0.
//   final int? ledOnMs;
//
//   /// Specifies how long the light colour will remain off.
//   ///
//   /// This property is only applicable to Android versions older than 8.0.
//   final int? ledOffMs;
//
//   /// Specifies the "ticker" text which is sent to accessibility services.
//   final String? ticker;
//
//   /// Defines the notification visibility on the lockscreen.
//   final NotificationVisibility? visibility;
//
//   /// The duration in milliseconds after which the notification will be
//   /// cancelled if it hasn't already.
//   final DateTime? disappearAfter;
//
//   /// The notification category.
//   final AndroidNotificationCategory? category;
//
//   /// Specifies whether the notification should launch a full-screen intent as
//   /// soon as it triggers.
//   ///
//   /// Note: The system UI may choose to display a heads-up notification,
//   /// instead of launching your full-screen intent, while the user is using the
//   /// device. When the full-screen intent occurs, the plugin will act as though
//   /// the user has tapped on a notification so handle it the same way
//   /// (e.g. via `onSelectNotification` callback) to display the appropriate
//   /// page for your application.
//   final bool fullScreenIntent;
//
//   /// Specifies the additional flags.
//   ///
//   /// These flags will get added to the native Android notification's flags field: https://developer.android.com/reference/android/app/Notification#flags
//   /// For a list of a values, refer to the documented constants prefixed with "FLAG_" (without the quotes) at https://developer.android.com/reference/android/app/Notification.html#constants_1.
//   /// For example, use a value of 4 to allow the audio to repeat as documented at https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTEN
//   final Int32List? additionalFlags;
//
//   /// The notification tag.
//   ///
//   /// Showing notification with the same (tag, id) pair as a currently visible
//   /// notification will replace the old notification with the new one, provided
//   /// the old notification was one that was not one that was scheduled. In other
//   /// words, the (tag, id) pair is only applicable for notifications that were
//   /// requested to be shown immediately. This is because the Android
//   /// AlarmManager APIs used for scheduling notifications only allow for using
//   /// the id to uniquely identify alarms.
//   // final String? tag;
//
//   /// Specify coloring background should be enabled, if false, color will be
//   /// applied to app icon.
//   ///
//   /// For most styles, the coloring will only be applied if the notification is
//   /// or a foreground service notification.
//   final bool colorized;
//
//   /// Set custom notification count.
//   ///
//   /// Numbers are only displayed if the launcher application supports the
//   /// display of badges and numbers. If not supported, this value is ignored.
//   /// See https://developer.android.com/training/notify-user/badges#set_custom_notification_count
//   final int? appIconNumber;
//
//   /// The attribute describing what is the intended use of the audio signal,
//   /// such as alarm or ringtone set in [`AudioAttributes.Builder`](https://developer.android.com/reference/android/media/AudioAttributes.Builder#setUsage(int))
//   /// https://developer.android.com/reference/android/media/AudioAttributes
//   final AudioAttributesUsage audioAttributesUsage;
//
//   const MyAndroidNBaseDetails({
//     this.icon,
//     this.groupKey = AndroidNGroupKeys.general,
//     this.setAsGroupSummary = false,
//     this.groupAlertBehavior = GroupAlertBehavior.all,
//     this.dismissOnTap = true,
//     this.notDismissible = false,
//     this.mustTapToDismiss = false,
//     this.silent = false,
//     this.color = AppColors.primary,
//     this.colorized = true,
//     this.largeIcon,
//     this.onlyAlertOnce = false,
//     this.showAtTime = true,
//     this.atTime,
//     this.usesChronometer = false,
//     this.chronometerCountDown = false,
//     this.showProgress = false,
//     this.maxProgress = 0,
//     this.progress = 0,
//     this.indeterminate = false,
//     this.ledOnMs,
//     this.ledOffMs,
//     this.ticker,
//     this.visibility,
//     this.disappearAfter,
//     this.fullScreenIntent = false,
//     this.appIconNumber,
//     this.category,
//     this.audioAttributesUsage = AudioAttributesUsage.notification,
//     this.additionalFlags,
//   });
// }
