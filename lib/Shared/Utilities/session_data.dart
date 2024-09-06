//
// import 'dart:async';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:rxdart/rxdart.dart';
//
// import '../../Models/nearest_points.dart';
// import '../../Models/place_model.dart';
// import '../../Models/route_model.dart';
// import '../../Models/trip_model.dart';
// import '../../Models/rider_model.dart';
//
// String? uId;
// String? isBoarded;
//
// PickUpUser? kModel;
// String? fcmToken;
// StreamSubscription<RemoteMessage>? onMessageSubscription;
// StreamSubscription<RemoteMessage>? onMessageOpenedAppSubscription;
// final FlutterLocalNotificationsPlugin globalFltLocNotificationsPlugin = FlutterLocalNotificationsPlugin();
// List<String> rangerAcceptedBookingsList = [];
// List<String> rangerRejectedBookingList = [];
// List<String> rangerArrangedBookingList = [];
// final notificationTapRx = BehaviorSubject<String?>();
// StreamSubscription? onChangeOccursInUserBookings;
//
//
// LatLng? destinationLocation;
// LatLng? pickUpLocation;
// LatLng? meetingLocation;
// LatLng? dropOffLocation;
// LatLng? globalLastKnownLatLng;
//
// RouteDetails? routeDetails;
// List<Place> autoCompletePlacesList = [];
// List<Trip> publishedTripsList = [];
// List<Trip> bookedTripsList = [];
// List<Trip> arrangedTripsList = [];
// List<Trip> historyTripsList = [];
// List<NearestPoints> nearestPointsList = [];
// List<NearestPoints> nearestDestinationPointsList = [];
//
// double screenWidth = 0;
// double screenHeight = 0;
//
// /// Filter Settings
// double globalMaxPickUpDistanceM = 2000;
// double globalMaxDropOffDistanceM = 5000;
// int globalMinAvailableSeats = 1;

import 'package:flutter/material.dart';

abstract class SessionData {
  static void init(BuildContext context) {
    _init(context);
    _initLiveScalePercentage(context);
  }

  static void _init(BuildContext context) {
    // if (!_initializedBefore) {
    _setMediaQuery(context);
    _setThemeData(context);
    _setSizeQuery(context);
    _setViewPadding(context);
    _setViewInsets(context);
    _setPadding(context);
    allListenable.value = !allListenable.value;
    // _initializedBefore = true;
    // }
  }

  static MediaQueryData _setMediaQuery(BuildContext context) {
    mediaQueryListenable.value = MediaQuery.of(context);
    return mediaQuery;
    // Provider.of<SessionProvider>(_staticContext).setMediaQuery(mediaQuery);

    // if (mediaQuery != newMediaQuery) {
    //   mediaQuery = newMediaQuery;
    // }
  }

  static ThemeData _setThemeData(BuildContext context) {
    themeDataListenable.value = Theme.of(context);
    textThemeListenable.value = themeData.textTheme;
    _normalSize = textTheme.bodyMedium!;
    isLightListenable.value = themeData.brightness == Brightness.light;
    return themeData;
  }

  static Size _setSizeQuery(BuildContext context) {
    sizeQueryListenable.value = MediaQuery.sizeOf(context);
    deviceWidth = sizeQuery.width;
    deviceHeight = sizeQuery.height;
    return sizeQuery;
  }

  static EdgeInsets _setViewPadding(BuildContext context) {
    viewPaddingListenable.value = MediaQuery.viewPaddingOf(context);
    return viewPadding;
  }

  static EdgeInsets _setViewInsets(BuildContext context) {
    viewInsetsListenable.value = MediaQuery.viewInsetsOf(context);
    return viewInsets;
  }

  static EdgeInsets _setPadding(BuildContext context) {
    paddingListenable.value = MediaQuery.paddingOf(context);
    return padding;
  }

  static ValueNotifier<double> scalePercentageListenable = ValueNotifier(1.0);

  static double get scalePercentage => scalePercentageListenable.value;

  // static bool _initializedBefore = false;
  /// SWEET SWEET SWEET
  /// When a [ValueListenableBuilder] is used with this [allListenable] it can use any data
  /// like [SessionData.viewInsets.bottom] and it will be LIVE data as [allListenable]
  /// is updated each and every time eny thing updates.
  ///
  /// NOTE: This can be equal to listening on [mediaQueryListenable] the only difference
  ///  will be like
  ///  [SessionData.viewInsets.bottom] for [allListenable] .. SHORTER
  ///  [SessionData.mediaQuery.viewInsets.bottom] for [mediaQueryListenable]
  ///  but the builder of both will called equally
  static final ValueNotifier<bool> allListenable = ValueNotifier(false);

  static MediaQueryData get mediaQuery => mediaQueryListenable.value;
  static ValueNotifier<MediaQueryData> mediaQueryListenable = ValueNotifier(const MediaQueryData());

  static ThemeData get themeData => themeDataListenable.value;
  static ValueNotifier<ThemeData> themeDataListenable = ValueNotifier(ThemeData());

  static TextTheme get textTheme => textThemeListenable.value;
  static ValueNotifier<TextTheme> textThemeListenable = ValueNotifier(const TextTheme());
  static late TextStyle _normalSize;

  static bool get isLight => isLightListenable.value;
  static ValueNotifier<bool> isLightListenable = ValueNotifier(true);

  static Size get sizeQuery => sizeQueryListenable.value;
  static ValueNotifier<Size> sizeQueryListenable = ValueNotifier(Size.zero);
  static late double deviceWidth;
  static late double deviceHeight;

  static EdgeInsets get viewPadding => viewPaddingListenable.value;
  static ValueNotifier<EdgeInsets> viewPaddingListenable = ValueNotifier(EdgeInsets.zero);

  static EdgeInsets get viewInsets => viewInsetsListenable.value;
  static ValueNotifier<EdgeInsets> viewInsetsListenable = ValueNotifier(EdgeInsets.zero);

  static EdgeInsets get padding => paddingListenable.value;
  static ValueNotifier<EdgeInsets> paddingListenable = ValueNotifier(EdgeInsets.zero);

  static TextScaler watchScalePercentage(BuildContext context) => MediaQuery.textScalerOf(context);

  static MediaQueryData watchMediaQuery(BuildContext context) => _setMediaQuery(context);

  static ThemeData watchTheme(BuildContext context) => _setThemeData(context);

  static Size watchSize(BuildContext context) => _setSizeQuery(context);

  static EdgeInsets watchViewPadding(BuildContext context) => _setViewPadding(context);

  static EdgeInsets watchViewInsets(BuildContext context) => _setViewInsets(context);

  static EdgeInsets watchPadding(BuildContext context) => _setPadding(context);

  static double _initLiveScalePercentage(BuildContext context) {
    final scaledSize = MediaQuery.textScalerOf(context).scale(_normalSize.fontSize!);
    final newPercentage = scaledSize / _normalSize.fontSize!;
    if (scalePercentageListenable.value != newPercentage) {
      scalePercentageListenable.value = newPercentage;
      print('scalePercentage $scalePercentage');
    }
    return scalePercentage;
  }

  /// In case of life scaledValue is required
  /// [SessionData.watchScalePercentage(context)] Should be called
  /// and if it does not work wrap with [ValueListenableBuilder]
  /// and use [SessionData.scalePercentageListenable] and discard the
  /// value if you want, when [SessionData.getScaledValue] is used
  /// in this builder it will be lifeScaledValue.
  static double getScaledValue(
    double baseValue, {
    bool allowBelow = true,
    double? maxValue,
    double? maxPercentage,
  }) {
    var scaledValue = baseValue * scalePercentage.clamp(0, maxPercentage ?? double.infinity);
    if (scaledValue < baseValue) {
      return allowBelow ? scaledValue : baseValue;
    } else {
      return scaledValue.clamp(baseValue, maxValue ?? scaledValue);
    }
  }
}
