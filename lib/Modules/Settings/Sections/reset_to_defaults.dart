import 'package:flutter/material.dart';

import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../Package/src/tiles/abstract_settings_tile.dart';
import '../Package/src/tiles/settings_tile.dart';
import '../Provider/setting_provider.dart';

class ResetToDefaults extends AbstractSettingsTile {
  const ResetToDefaults({super.key});

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile(
          title: Text(L10nR.tRestToDefaultSettings(ref)),
          leading: Icon(AdaptiveIcons.reset),
          onPressed: () => ref.read(settingProvider).resetDefaults(ref),
        ),
      );
}
