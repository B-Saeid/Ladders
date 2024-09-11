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
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'static_data.dart';

ChangeNotifierProvider<LiveData> liveData = ChangeNotifierProvider((_) => LiveData._());

class LiveData extends ChangeNotifier {
  LiveData._();

  void keepSynced(BuildContext context) => _init(context);

  void _init(BuildContext context) {
    print('Keep Synced Is called');
    _setThemeData(context);
    _setMediaQuery(context);
  }

  double _scalePercentage = 1.0;
  static double __scalePercentage = 1.0;

  MediaQueryData _mediaQuery = const MediaQueryData();
  static MediaQueryData __mediaQuery = const MediaQueryData();

  Size _sizeQuery = Size.zero;
  static Size __sizeQuery = Size.zero;

  late double _deviceWidth = _sizeQuery.width;
  static double __deviceWidth = __sizeQuery.width;

  late double _deviceHeight = _sizeQuery.height;
  static double __deviceHeight = __sizeQuery.height;

  EdgeInsets _viewPadding = EdgeInsets.zero;
  static EdgeInsets __viewPadding = EdgeInsets.zero;

  EdgeInsets _viewInsets = EdgeInsets.zero;
  static EdgeInsets __viewInsets = EdgeInsets.zero;

  EdgeInsets _padding = EdgeInsets.zero;
  static EdgeInsets __padding = EdgeInsets.zero;

  bool _isPortrait = true;
  static bool __isPortrait = true;

  void _setMediaQuery(BuildContext context) {
    final newMediaQuery = MediaQuery.of(context);
    if (_mediaQuery != newMediaQuery) {
      _mediaQuery = newMediaQuery;
      _updateMediaDependants();
      final notified = _updateLiveScalePercentage(_mediaQuery.textScaler);
      if (!notified) notifyListeners();
      print('Media dependants are updated');
    }
  }

  void _updateMediaDependants() {
    __mediaQuery = _mediaQuery;
    _sizeQuery = _mediaQuery.size;
    __sizeQuery = _sizeQuery;
    _deviceWidth = _sizeQuery.width;
    __deviceWidth = _deviceWidth;
    _deviceHeight = _sizeQuery.height;
    __deviceHeight = _deviceHeight;
    _viewPadding = _mediaQuery.viewPadding;
    __viewPadding = _viewPadding;
    _viewInsets = _mediaQuery.viewInsets;
    __viewInsets = _viewInsets;
    _padding = _mediaQuery.padding;
    __padding = _padding;
    _isPortrait = _mediaQuery.orientation == Orientation.portrait;
    __isPortrait = _isPortrait;
  }

  ThemeData _themeData = ThemeData();
  static ThemeData __themeData = ThemeData();

  TextTheme _textTheme = const TextTheme();
  static TextTheme __textTheme = const TextTheme();

  bool _isLight = true;
  static bool __isLight = true;

  void _setThemeData(BuildContext context) {
    final newThemeData = Theme.of(context);
    if (_themeData != newThemeData) {
      _themeData = newThemeData;
      _updateThemeDependants();
      notifyListeners();
      print('THEME dependants are updated');
    }
  }

  late TextStyle _normalSize;

  void _updateThemeDependants() {
    __themeData = _themeData;
    _textTheme = _themeData.textTheme;
    __textTheme = _textTheme;
    _normalSize = _textTheme.bodyMedium!; // you can use any textTheme
    _isLight = _themeData.brightness == Brightness.light;
    __isLight = _isLight;
  }

  bool _updateLiveScalePercentage(TextScaler textScaler) {
    final scaledSize = textScaler.scale(_normalSize.fontSize!);
    final newPercentage = scaledSize / _normalSize.fontSize!;
    if (_scalePercentage == newPercentage) return false;
    _scalePercentage = newPercentage;
    __scalePercentage = _scalePercentage;
    notifyListeners();
    print('updated scalePercentage $_scalePercentage');
    return true;
  }

  /// Watcher static methods

  static AlwaysAliveProviderListenable<double> scalePercentageSelector(WidgetRef ref) => liveData.select(
        (value) => value._scalePercentage,
      );

  static double scalePercentage(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._scalePercentage),
      );

  static AlwaysAliveProviderListenable<MediaQueryData> mediaQuerySelector(WidgetRef ref) =>
      liveData.select(
        (value) => value._mediaQuery,
      );

  static MediaQueryData mediaQuery(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._mediaQuery),
      );

  static AlwaysAliveProviderListenable<Size> sizeQuerySelector(WidgetRef ref) => liveData.select(
        (value) => value._sizeQuery,
      );

  static Size sizeQuery(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._sizeQuery),
      );

  static AlwaysAliveProviderListenable<double> deviceWidthSelector(WidgetRef ref) => liveData.select(
        (value) => value._deviceWidth,
      );

  static double deviceWidth(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._deviceWidth),
      );

  static AlwaysAliveProviderListenable<double> deviceHeightSelector(WidgetRef ref) => liveData.select(
        (value) => value._deviceHeight,
      );

  static double deviceHeight(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._deviceHeight),
      );

  static AlwaysAliveProviderListenable<EdgeInsets> viewPaddingSelector(WidgetRef ref) => liveData.select(
        (value) => value._viewPadding,
      );

  static EdgeInsets viewPadding(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._viewPadding),
      );

  static AlwaysAliveProviderListenable<EdgeInsets> viewInsetsSelector(WidgetRef ref) => liveData.select(
        (value) => value._viewInsets,
      );

  static EdgeInsets viewInsets(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._viewInsets),
      );

  static AlwaysAliveProviderListenable<EdgeInsets> paddingSelector(WidgetRef ref) => liveData.select(
        (value) => value._padding,
      );

  static EdgeInsets padding(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._padding),
      );

  static AlwaysAliveProviderListenable<bool> isPortraitSelector(WidgetRef ref) => liveData.select(
        (value) => value._isPortrait,
      );

  static bool isPortrait(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._isPortrait),
      );

  static AlwaysAliveProviderListenable<ThemeData> themeDataSelector(WidgetRef ref) => liveData.select(
        (value) => value._themeData,
      );

  static ThemeData themeData(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._themeData),
      );

  static AlwaysAliveProviderListenable<TextTheme> textThemeSelector(WidgetRef ref) => liveData.select(
        (value) => value._textTheme,
      );

  static TextTheme textTheme(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._textTheme),
      );

  static AlwaysAliveProviderListenable<bool> isLightSelector(WidgetRef ref) => liveData.select(
        (value) => value._isLight,
      );

  static bool isLight(WidgetRef ref) => ref.watch(
        liveData.select((p) => p._isLight),
      );

  static double _getScaledValue(
    WidgetRef ref, {
    required double baseValue,
    bool allowBelow = true,
    double? maxValue,
    double? maxPercentage,
  }) {
    final currentScalePercentage = ref.watch(liveData)._scalePercentage;
    var scaledValue = baseValue * currentScalePercentage.clamp(0, maxPercentage ?? double.infinity);
    if (scaledValue < baseValue) {
      return allowBelow ? scaledValue : baseValue;
    } else {
      return scaledValue.clamp(baseValue, maxValue ?? scaledValue);
    }
  }
}

extension LiveScaledValue on num {
  double scalable(
    WidgetRef ref, {
    bool allowBelow = true,
    double? maxValue,
    double? maxPercentage,
  }) =>
      LiveData._getScaledValue(
        ref,
        baseValue: toDouble(),
        allowBelow: allowBelow,
        maxPercentage: maxPercentage,
        maxValue: maxValue,
      );
}

extension LiveStringWidth on String {
  double getWidth(TextStyle style) {
    final textSpan = TextSpan(
      text: this,
      style: style,
    );
    final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
    return tp.width;
  }
}
