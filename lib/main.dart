import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Modules/Settings/Provider/setting_provider.dart';
import 'Shared/Components/provider_observer.dart';
import 'Shared/Constants/global_constants.dart';
import 'Shared/Services/Routing/routes_base.dart';
import 'Shared/Services/init_app_and_services.dart';
import 'Shared/Services/l10n/l10n_service.dart';
import 'Shared/Styles/app_themes.dart';
import 'Shared/Utilities/SessionData/session_data.dart';

Future<void> main() async {
  await initServices();
  runApp(
    ProviderScope(
      observers: [AppProviderObserver()],
      child: const Ladders(),
    ),
  );
}

class Ladders extends ConsumerWidget {
  const Ladders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        title: GlobalConstants.appName,
        theme: ref.watch(stylesProvider.select((p) => p.light)),
        darkTheme: ref.watch(stylesProvider.select((p) => p.dark)),
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
