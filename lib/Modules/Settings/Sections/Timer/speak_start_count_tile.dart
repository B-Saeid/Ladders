import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../Package/settings_ui.dart';
import '../../Provider/setting_provider.dart';

class SpeakCountBeforeStartTile extends AbstractSettingsTile {
  const SpeakCountBeforeStartTile({super.key});

  bool available(WidgetRef ref) => ref.watch(settingProvider).ttsAvailable;

  bool enabled(WidgetRef ref) => ref.watch(settingProvider).enableStartCount;

  bool switchValue(WidgetRef ref) => ref.watch(settingProvider).speakStartCount;

  @override
  bool get hasLeading => false;

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile.switchTile(
          on: switchValue(ref),
          enabled: available(ref) && enabled(ref),
          onToggle: ref.read(settingProvider).setSpeakStartCount,
          title: const L10nRText(L10nR.tSpeakCountBeforeStart),
        ),
      );
}
