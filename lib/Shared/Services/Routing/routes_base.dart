import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../Modules/Home/home_screen.dart';
import '../../../Modules/Settings/settings_screen.dart';
import 'routes.dart';

export 'routes.dart';

part 'Home/home_rs.dart';
part 'top_level_screen.dart';

abstract class RoutesBase {
  static RouteConfiguration? baseConfiguration;

  static ValueNotifier<String?> startLocationNotifier = ValueNotifier(null);

  static GoRouter? _router;

  static final globalNavigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get activeContext => globalNavigatorKey.currentContext;

  static String get currentRoute => router.routeInformationProvider.value.uri.toString();

  static GoRouter get router => _router ??= GoRouter(
        navigatorKey: globalNavigatorKey,
        initialLocation: RootRoute.path,
        routes: [
          // onBoardingRoutes,
          _rootRoute,
          ..._Home.routes,
        ],
      );

  static GoRoute get _rootRoute => GoRoute(
        name: RootRoute.name,
        path: RootRoute.path,
        // redirect: _topLevelRedirect,
        redirect: (_, __) => _Home.redirect,
        // redirect: (_, __) => '/Test',
      );

  /// TODO : Place this where necessary
// AlertDialog(
//   title: Text('You have unsaved data'),
//   content: Text('Do you want to save your changes before exiting?'),
//   actions: [
//     TextButton(
//       onPressed: () => saveData(),
//       child: Text('Save'),
//     ),
//     TextButton(
//       onPressed: () => exitApp(),
//       child: Text('Discard'),
//     ),
//   ],
// );
}
