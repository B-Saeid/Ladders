// part of 'android_parts.dart';
//
// enum AndroidNChannel {
//   /// Driver Mode
//   pendingBookings,
//   cancelledBookings,
//
//   /// Rider Mode
//   acceptedBookings,
//   rejectedBookings,
//   cancelledTrips,
//   arrangedTrips,
//
//   /// Common
//   general,
//   gentle,
//   messages,
//   important;
//
//   // the .split('ed') is to separate the two-word types i.e. the bookings channels
//   // and make them return for ex:  'Accept Bookings' instead of 'AcceptedBookings'
//   // And the 'ed' happened to be common between them -- if not I would return different string
//   // for each booking state using switch like the others below .. and since split('ed') removes the 'ed'
//   // I added it back
//   String get camelCasedName => switch (this) {
//         /// Driver Mode
//         AndroidNChannel.pendingBookings => 'Pending Bookings',
//         AndroidNChannel.cancelledBookings => 'Cancelled Bookings',
//
//         /// Rider Mode
//         AndroidNChannel.acceptedBookings => 'Accepted Bookings',
//         AndroidNChannel.rejectedBookings => 'Rejected Bookings',
//         AndroidNChannel.cancelledTrips => 'Cancelled Trips',
//         AndroidNChannel.arrangedTrips => 'Arranged Trips',
//
//         /// Common
//         AndroidNChannel.general => name.upperFirstLetter,
//         AndroidNChannel.gentle => name.upperFirstLetter,
//         AndroidNChannel.messages => name.upperFirstLetter,
//         AndroidNChannel.important => name.upperFirstLetter,
//       };
//
//   // {
//   // final result = name.upperFirstLetter().split('ed');
//   // return result.length > 1 ? '${result[0]}ed ${result[1]}' : result.first;
//   // }
//
//   /// TODO : Make it return a more professional string
//   String get id => '${name.trim()}ChannelId';
//
//   /// The channel's description.
//   ///
//   /// This property is only applicable to Android versions 8.0 or newer.
//   String get description => L10nR.androidNChannelsDescription(this);
//
//   /// The importance of the notification.
//   Importance get importance =>
//       this == AndroidNChannel.general ? Importance.defaultImportance : Importance.max;
//
//   /// The priority of the notification
//   /// On Android 7.1 (API level 25) and lower, the importance of a notification
//   /// is determined by the notification's priority.
//   /// On Android 8.0 (API level 26) and higher, the importance of a notification
//   /// is determined by the importance of the channel the notification is posted to.
//   Priority get priority =>
//       importance == Importance.defaultImportance ? Priority.defaultPriority : Priority.max;
//
//   /// Indicates if a sound should be played when the notification is displayed.
//   ///
//   /// For Android 8.0 or newer, this is tied to the specified channel and cannot
//   /// be changed after the channel has been created for the first time.
//   bool get playSound => this == AndroidNChannel.gentle ? false : true;
//
//   /// The sound to play for the notification.
//   ///
//   /// Requires setting [playSound] to true for it to work.
//   /// If [playSound] is set to true but this is not specified then the default
//   /// sound is played.
//   ///
//   /// For Android 8.0 or newer, this is tied to the specified channel and cannot
//   /// be changed after the channel has been created for the first time.
//   String? get soundFileName => switch (this) {
//         /// Driver Mode
//         AndroidNChannel.pendingBookings => AndroidNSound.pendingBooking,
//         AndroidNChannel.cancelledBookings => AndroidNSound.cancelledBooking,
//
//         /// Rider Mode
//         AndroidNChannel.acceptedBookings => AndroidNSound.acceptedBooking,
//         AndroidNChannel.rejectedBookings => AndroidNSound.rejectedBooking,
//         AndroidNChannel.cancelledTrips => AndroidNSound.tripCancelled,
//         AndroidNChannel.arrangedTrips => AndroidNSound.tripArranged,
//
//         /// Common
//         AndroidNChannel.general => AndroidNSound.standard,
//         AndroidNChannel.gentle => null, // silent
//         AndroidNChannel.messages => AndroidNSound.newMessage,
//         AndroidNChannel.important => AndroidNSound.important,
//       };
//
//   /// The id of the group that the channel belongs to.
//   String? get _groupId {
//     switch (this) {
//       /// Driver Mode
//       case AndroidNChannel.pendingBookings:
//       case AndroidNChannel.cancelledBookings:
//
//         /// This condition was put to handle an exception occurred:
//         /// ... Cannot find a group for the id ... as we do the same condition
//         /// when creating the group in the [NotificationService] file
//         final isUserDriver = HiveService.userVolt.get(Vehicle.mVehicles) != null;
//         return isUserDriver ? AndroidNChannelGroups.bookingsFromRiders.id : null;
//
//       /// Rider Mode
//       case AndroidNChannel.acceptedBookings:
//       case AndroidNChannel.rejectedBookings:
//       case AndroidNChannel.cancelledTrips:
//       case AndroidNChannel.arrangedTrips:
//         return AndroidNChannelGroups.bookingsFromDrivers.id;
//       default:
//         return null;
//     }
//   }
//
//   /// Specifies the light color of the notification.
//   ///
//   /// Tied to the specified channel and cannot be changed after the channel has
//   /// been created for the first time.
//   Color? get ledColor => switch (this) {
//         /// TODO : Handle This later on
//         /// Driver Side
//         AndroidNChannel.pendingBookings => null,
//         AndroidNChannel.cancelledBookings => null,
//
//         /// Rider Side
//         AndroidNChannel.acceptedBookings => null,
//         AndroidNChannel.rejectedBookings => null,
//         AndroidNChannel.cancelledTrips => null,
//         AndroidNChannel.arrangedTrips => null,
//
//         /// Common
//         AndroidNChannel.general => null,
//         AndroidNChannel.gentle => null,
//         AndroidNChannel.messages => null,
//         AndroidNChannel.important => null,
//       };
//
//   /// Indicates if vibration should be enabled when the notification is
//   /// displayed.
//   ///
//   /// For Android 8.0 or newer, this is tied to the specified channel and cannot
//   /// be changed after the channel has been created for the first time.
//   bool get enableVibration => playSound;
//
//   /// Indicates if lights should be enabled when the notification is displayed.
//   ///
//   /// For Android 8.0 or newer, this is tied to the specified channel and cannot
//   /// be changed after the channel has been created for the first time.
//   bool get enableLights => playSound;
//
//   /// Configures the vibration pattern.
//   ///
//   /// Requires setting [enableVibration] to true for it to work.
//   /// For Android 8.0 or newer, this is tied to the specified channel and cannot
//   /// be changed after the channel has been created for the first time.
// // final Int64List? vibrationPattern;
//
//   /// Whether notifications posted to this channel can appear as application
//   /// icon badges in a Launcher
//   bool get showBadge => playSound;
//
//   AndroidNotificationChannel get packageChannel => AndroidNotificationChannel(
//         id,
//         camelCasedName,
//         description: description,
//         importance: importance,
//         // a bug in FLN: [RawResourceAndroidNotificationSound] must accept a String not an optional one
//         sound: soundFileName == null ? null : RawResourceAndroidNotificationSound(soundFileName),
//         playSound: playSound,
//         ledColor: ledColor,
//         groupId: _groupId,
//         enableVibration: enableVibration,
//         enableLights: enableLights,
//         showBadge: showBadge,
//         // vibrationPattern: vibrationPattern,
//       );
// }
