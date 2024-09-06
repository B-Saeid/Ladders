// part of 'android_parts.dart';
//
// /// Contains notification details specific to Android.
// class MyAndroidNDetails extends MyAndroidNBaseDetails {
//   final AndroidNChannel channel;
//
//   /// Specifies the information of the rich notification style to apply to the
//   /// notification.
//   final StyleInformation? styleInformation;
//
//   /// Specify a list of actions associated with this notifications.
//   ///
//   /// Users will be able tap on the actions without actually launching the App.
//   /// Note that tapping a action will spawn a separate isolate that runs
//   /// **independently** from the main app.
//   final List<AndroidNotificationAction>? actions;
//
//   /// Constructs an instance of [MyAndroidNDetails].
//   /// General
//   const MyAndroidNDetails({
//     this.channel = AndroidNChannel.general,
//     this.styleInformation = const DefaultStyleInformation(true, true),
//     this.actions,
//     // super.icon,
//     // super.groupKey,
//     // super.setAsGroupSummary,
//     // super.groupAlertBehavior,
//     // super.dismissOnTap,
//     // super.notDismissible,
//     // super.mustTapToDismiss,
//     // super.silent,
//     // super.color,
//     // super.colorized,
//     // super.largeIcon,
//     // super.onlyAlertOnce,
//     // super.showAtTime,
//     // super.atTime,
//     // super.usesChronometer,
//     // super.chronometerCountDown,
//     // super.showProgress,
//     // super.maxProgress,
//     // super.progress,
//     // super.indeterminate,
//     // super.ledOnMs,
//     // super.ledOffMs,
//     // super.ticker,
//     // super.visibility,
//     // super.disappearAfter,
//     // super.fullScreenIntent,
//     // super.appIconNumber,
//     // super.category,
//     // super.audioAttributesUsage,
//     // super.additionalFlags,
//   });
//
//   /// Messaging
//   static final List<AndroidNotificationAction> _messagesActions = [
//     AndroidNotificationAction(
//       NActions.markAsReadId,
//       NActions.markAsReadTitle,
//       titleColor: Colors.black,
//     ),
//
//     /// Super Detail_y lovely line __ SWEET
//     if (HiveService.userVolt.get(Vehicle.mVehicles) != null) ...[
//       /// i.e if user is a driver >> include these actions in a messages notification
//
//       AndroidNotificationAction(
//         NActions.fiveMinETAId,
//         NActions.fiveMinETATitle,
//         titleColor: Colors.blue,
//       ),
//       AndroidNotificationAction(
//         NActions.tenToFifteenMinETAId,
//         NActions.tenToFifteenMinETATitle,
//         titleColor: Colors.green,
//       ),
//     ]
//   ];
//
//   MyAndroidNDetails.messages({
//     required String senderName,
//     required List<String> messages,
//     required super.atTime,
//     this.channel = AndroidNChannel.messages,
//     super.visibility = NotificationVisibility.private,
//     super.category = AndroidNotificationCategory.message,
//     super.icon,
//     super.groupKey = AndroidNGroupKeys.messages,
//     // super.setAsGroupSummary,
//     // super.groupAlertBehavior,
//     // super.dismissOnTap,
//     // super.notDismissible,
//     // super.mustTapToDismiss,
//     // super.silent,
//     // super.colorized,
//     // super.largeIcon,
//     // super.onlyAlertOnce,
//     // super.showAtTime,
//     // super.usesChronometer,
//     // super.chronometerCountDown,
//     // super.showProgress,
//     // super.maxProgress,
//     // super.progress,
//     // super.indeterminate,
//     // super.ledOnMs,
//     // super.ledOffMs,
//     // super.ticker,
//     // super.disappearAfter,
//     // super.fullScreenIntent,
//     // super.appIconNumber,
//     // super.audioAttributesUsage,
//     // super.additionalFlags,
//   })  : actions = _messagesActions,
//         styleInformation = InboxStyleInformation(
//           messages,
//           htmlFormatTitle: true,
//           htmlFormatContent: true,
//           htmlFormatLines: true,
//           htmlFormatSummaryText: true,
//           htmlFormatContentTitle: true,
//           summaryText: NTemplates.newMessagesTitle(
//             howMany: messages.length,
//             atTime: atTime,
//             htmlFormat: true,
//           ),
//           contentTitle: '$senderName:',
//         );
//
//   /// Booking From Driver (Accepting , Rejecting, or CancelledTrip) >> No Actions
//
//   MyAndroidNDetails.bookingFromDriver({
//     required FromDriverBookingState fromDriverBookingState,
//     required super.atTime,
//     this.styleInformation = const DefaultStyleInformation(true, true),
//     super.visibility = NotificationVisibility.public,
//     super.category = AndroidNotificationCategory.transport,
//     super.groupKey = AndroidNGroupKeys.bookingsFromDrivers,
//     // super.icon,
//     // super.setAsGroupSummary,
//     // super.groupAlertBehavior,
//     // super.dismissOnTap,
//     // super.notDismissible,
//     // super.mustTapToDismiss,
//     // super.silent,
//     // super.color,
//     // super.colorized,
//     // super.largeIcon,
//     // super.onlyAlertOnce,
//     // super.showAtTime,
//     // super.usesChronometer,
//     // super.chronometerCountDown,
//     // super.showProgress,
//     // super.maxProgress,
//     // super.progress,
//     // super.indeterminate,
//     // super.ledOnMs,
//     // super.ledOffMs,
//     // super.ticker,
//     // super.disappearAfter,
//     // super.fullScreenIntent,
//     // super.additionalFlags,
//     // super.appIconNumber,
//     // super.audioAttributesUsage,
//   })  : actions = null,
//         channel = fromDriverBookingState.androidNChannel;
//
//   /// Booking From Riders (Pending or Cancelled)
//   ///
//   static List<AndroidNotificationAction> _bookingActions(FromRiderBookingState state) => switch (state) {
//         FromRiderBookingState.pending => _pendingBookingActions,
//         FromRiderBookingState.cancelled => _cancelledBookingActions,
//       };
//
//   static final List<AndroidNotificationAction> _pendingBookingActions = [
//     AndroidNotificationAction(
//       NActions.showBookingOnMapId,
//       NActions.showBookingOnMapTitle,
//       showsUserInterface: true,
//       titleColor: Colors.blue,
//     ),
//     AndroidNotificationAction(
//       NActions.acceptBookingId,
//       NActions.acceptBookingTitle,
//       titleColor: Colors.green,
//     ),
//     AndroidNotificationAction(
//       NActions.rejectBookingId,
//       NActions.rejectBookingTitle,
//       titleColor: Colors.red,
//     ),
//   ];
//
//   static final List<AndroidNotificationAction> _cancelledBookingActions = [
//     AndroidNotificationAction(
//       NActions.dismissBookingId,
//       NActions.dismissBookingTitle,
//       titleColor: Colors.red,
//     )
//   ];
//
//   MyAndroidNDetails.bookingFromRider({
//     required FromRiderBookingState fromRiderBookingState,
//     required super.atTime,
//     this.styleInformation = const DefaultStyleInformation(true, true),
//     super.visibility = NotificationVisibility.public,
//     super.category = AndroidNotificationCategory.transport,
//     super.groupKey = AndroidNGroupKeys.bookingsFromRiders,
//     // super.icon,
//     // super.setAsGroupSummary,
//     // super.groupAlertBehavior,
//     // super.dismissOnTap,
//     // super.notDismissible,
//     // super.mustTapToDismiss,
//     // super.silent,
//     // super.color,
//     // super.colorized,
//     // super.largeIcon,
//     // super.onlyAlertOnce,
//     // super.showAtTime,
//     // super.usesChronometer,
//     // super.chronometerCountDown,
//     // super.showProgress,
//     // super.maxProgress,
//     // super.progress,
//     // super.indeterminate,
//     // super.ledOnMs,
//     // super.ledOffMs,
//     // super.ticker,
//     // super.disappearAfter,
//     // super.fullScreenIntent,
//     // super.additionalFlags,
//     // super.appIconNumber,
//     // super.audioAttributesUsage,
//   })  : actions = _bookingActions(fromRiderBookingState),
//         channel = fromRiderBookingState.androidNChannel;
//
//   /// returns [AndroidNotificationDetails] with the properties of [MyAndroidNDetails]
//   AndroidNotificationDetails packageClass() => AndroidNotificationDetails(
//         channel.id,
//         channel.camelCasedName,
//         channelDescription: channel.description,
//         importance: channel.importance,
//         priority: channel.priority,
//         playSound: channel.playSound,
//         sound: RawResourceAndroidNotificationSound(channel.soundFileName),
//         enableVibration: channel.enableVibration,
//         channelShowBadge: channel.showBadge,
//         enableLights: channel.enableLights,
//         ledColor: channel.ledColor,
//         icon: icon,
//         styleInformation: styleInformation,
//         groupKey: groupKey,
//         setAsGroupSummary: setAsGroupSummary,
//         groupAlertBehavior: groupAlertBehavior,
//         autoCancel: mustTapToDismiss ? true : dismissOnTap,
//         ongoing: mustTapToDismiss ? true : notDismissible,
//         silent: silent,
//         color: color,
//         colorized: colorized,
//         largeIcon: largeIcon,
//         onlyAlertOnce: onlyAlertOnce,
//         showWhen: showAtTime,
//         when: atTime?.millisecondsSinceEpoch,
//         usesChronometer: usesChronometer,
//         chronometerCountDown: chronometerCountDown,
//         showProgress: showProgress,
//         maxProgress: maxProgress,
//         progress: progress,
//         indeterminate: indeterminate,
//         ledOnMs: ledOnMs,
//         ledOffMs: ledOffMs,
//         ticker: ticker,
//         visibility: visibility,
//         timeoutAfter: disappearAfter?.millisecond,
//         category: category,
//         fullScreenIntent: fullScreenIntent,
//         additionalFlags: additionalFlags,
//         actions: actions,
//         number: appIconNumber,
//         audioAttributesUsage: audioAttributesUsage,
//       );
// }
