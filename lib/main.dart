import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Modules/Settings/Provider/setting_provider.dart';
import 'Shared/Constants/global_constants.dart';
import 'Shared/Services/Routing/routes_base.dart';
import 'Shared/Services/init_app_and_services.dart';
import 'Shared/Services/l10n/l10n_service.dart';
import 'Shared/Styles/app_themes.dart';
import 'Shared/Utilities/SessionData/session_data.dart';
import 'Shared/Utilities/provider_observer.dart';

Future<void> main() async {
  await initServices();
  runApp(
    ProviderScope(
      observers: [AppProviderObserver()],
      child: const Ladders(),
    ),
  );
}

class Ladders extends ConsumerStatefulWidget {
  const Ladders({super.key});

  @override
  ConsumerState<Ladders> createState() => _LaddersState();
}

class _LaddersState extends ConsumerState<Ladders> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState: $state');
    // final provider = ref.watch(homeProvider);
    switch (state) {
      case AppLifecycleState.hidden:
      // if (provider.totalState.isRunning) provider.pauseLadder(voiced: true);

      case AppLifecycleState.detached:
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: GlobalConstants.appName,
        theme: ref.read(stylesProvider).light,
        darkTheme: ref.read(stylesProvider).dark,
        themeMode: ref.watch(settingProvider.select((p) => p.themeMode)),
        builder: (context, child) {
          Future(() => ref.read(liveData).keepSynced(context));
          return child!;
        },
        routerConfig: RoutesBase.router,
        localizationsDelegates: L10nService.delegates,
        locale: ref.watch(settingProvider).localeSettings.locale,
        supportedLocales: L10nService.supportedLocales,
      );
}
