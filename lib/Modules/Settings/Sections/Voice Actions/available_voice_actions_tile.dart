import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Services/Routing/routes_base.dart';
import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../../Shared/Styles/adaptive_icons.dart';
import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../Package/settings_ui.dart';
import '../../Provider/setting_provider.dart';

class AvailableVoiceActionsTile extends AbstractSettingsTile {
  const AvailableVoiceActionsTile({super.key});

  bool _voiceActionsEnabled(WidgetRef ref) => ref.watch(settingProvider).enableVoiceActions;

  bool _restOnlyValue(WidgetRef ref) => ref.watch(settingProvider.select((p) => p.restOnlyTrigger));

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile.navigation(
          onPressed: () => RoutesBase.router.go(Routes.voiceActions.path),
          leading: Icon(AdaptiveIcons.list),
          enabled: _voiceActionsEnabled(ref) && !_restOnlyValue(ref),
          title: const L10nRText(L10nR.tActionsList),
        ),
      );
}
