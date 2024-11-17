import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../Modules/Home/home_screen.dart';
import '../../../Modules/Settings/Widgets/voice_actions_screen.dart';
import '../../../Modules/Settings/settings_screen.dart';
import '../l10n/l10n_service.dart';
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
        builder: (context, state) => const _SplashScreen(),
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

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    Future(() {
      L10nService.init(context);
      RoutesBase.router.go(_Home.redirect);
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => const TEST(),
      //   ),
      // );
    });
    return const Scaffold();
  }
}

// class TEST extends StatelessWidget {
//   const TEST({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CustomButton(
//               icon: _ButtonIcon(outlined: true),
//               onPressed: AudioSessionService.printRecorderInputDevices,
//               child: Text('Ha poo'),
//             ),
//             CustomButton(
//               icon: _ButtonIcon(outlined: false),
//               onPressed: AudioSessionService.printRecorderInputDevices,
//               child: Text('Ha poo'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _ButtonIcon extends ConsumerStatefulWidget {
//   const _ButtonIcon({required this.outlined});
//
//   final bool outlined;
//
//   @override
//   ConsumerState<_ButtonIcon> createState() => _ButtonIconState();
// }
//
// class _ButtonIconState extends ConsumerState<_ButtonIcon> {
//   @override
//   void initState() {
//     super.initState();
//     AudioSessionService.listenOnDeviceChanges();
//   }
//
//   @override
//   void dispose() {
//     AudioSessionService.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => ValueListenableBuilder(
//         valueListenable: SpeechService.isTTSNotifier,
//         builder: (_, isTTS, __) => ValueListenableBuilder(
//           valueListenable: AudioSessionService.micTypeNotifier,
//           builder: (_, micType, __) => IconTheme.merge(
//             data: IconThemeData(
//               // color: isTTS || widget.outlined ? LiveData.themeData(ref).disabledColor : null,
//             ),
//             // child: micType.icon(isTTS || widget.outlined),
//             child: widget.outlined?MicType.builtIn.icon(true):MicType.bluetooth.icon(true),
//           ),
//         ),
//       );
// }
