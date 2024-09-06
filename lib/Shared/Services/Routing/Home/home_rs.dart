part of '../routes_base.dart';

abstract class _Home {
  static List<GoRoute> get routes => [
        GoRoute(
          name: Routes.home.name,
          path: Routes.home.path,
          builder: (context, state) => const HomeScreen(),
          routes: [
            // GoRoute(
            //   name: InAppRoutes.account.name,
            //   path: InAppRoutes.account.name,
            //   builder: (context, state) => const AccountScreen(),
            // ),
            GoRoute(
              name: Routes.settings.name,
              path: Routes.settings.name,
              builder: (context, state) => const SettingsScreen(),
            )
          ],
        )
      ];

  static String get redirect {
    // final isBoarded = await DataStore.getValue(key: DataStoreKeys.boarded);
    // if (isBoarded == null) {
    // return const OnBoardingScreen();
    // } else {
    return Routes.home.path;
    // }
  }
}
