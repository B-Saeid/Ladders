import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../Package/settings_ui.dart';
import '../../Provider/setting_provider.dart';

class SayGoWhenRestIsOver extends AbstractSettingsTile {
  const SayGoWhenRestIsOver({super.key});

  bool switchValue(WidgetRef ref) => ref.watch(settingProvider).sayGoWhenRestIsOver;

  bool available(WidgetRef ref) => ref.watch(settingProvider).ttsAvailable;

  @override
  bool get hasLeading => false;

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile.switchTile(
          on: switchValue(ref),
          enabled: available(ref),
          // onToggle: ref.read(settingProvider).setSayGoWhenRestIsOver,
          onToggle: (value) => ref.read(settingProvider).setSayGoWhenRestIsOver(value),
          title: const L10nRText(L10nR.tSayGoWhenRestIsOver),
        ),
      );
}
