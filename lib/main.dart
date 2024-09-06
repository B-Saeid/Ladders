import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Modules/Settings/Provider/setting_provider.dart';
import 'Shared/Components/provider_observer.dart';
import 'Shared/Constants/global_constants.dart';
import 'Shared/Services/Routing/routes_base.dart';
import 'Shared/Services/init_app_and_services.dart';
import 'Shared/Services/l10n/l10n_service.dart';
import 'Shared/Styles/app_themes.dart';
import 'Shared/Utilities/session_data.dart';

Future<void> main() async {
  await initServices();
  runApp(
    ProviderScope(
      observers: [AppProviderObserver()],
      child: const Ladders(),
    ),
  );
}

class Ladders extends StatelessWidget {
  const Ladders({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => MaterialApp.router(
        title: GlobalConstants.appName,
        theme: LaddersStyles.light,
        darkTheme: LaddersStyles.dark,
        themeMode: ref.watch(settingProvider.select((value) => value.themeMode)),
        builder: (context, child) {
          // As this is the first context under MaterialApp that have Localization
          /// Copied From this attribute Docs
          // from the BuildContext passed to this method,
          // the Directionality, Localizations, DefaultTextStyle, MediaQuery, etc,
          // are all available
          // Internet.context = context;
          SessionData.init(context);
          L10nService.initDeviceLocalIfAuto(context);
          // The Above For Assuring localeSettings not null even if set to auto
          return child!; // This is [RoutesBase.router]
        },
        routerConfig: RoutesBase.router,
        localizationsDelegates: L10nService.delegates,
        locale: L10nService.localeSettings.locale,
        supportedLocales: L10nService.supportedLocales,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10nR.tHomePageTitle),
      ),
    );
  }
}
