import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../Shared/Services/l10n/helper_widgets.dart';
import '../../Shared/Services/l10n/l10n_service.dart';
import '../../Shared/Utilities/Responsiveness/responsive_layout.dart';
import '../Home/utilities/Speech/speech_service.dart';
import 'Package/settings_ui.dart';
import 'Sections/all_tiles.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const ResponsiveLayout(
        title: L10nR.tSettings,
        content: _SettingContent(),
        endDrawer: true,
        // useSafeArea: false,
      );
}

class _SettingContent extends ConsumerWidget {
  const _SettingContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) => SettingsList(
        sections: [
          const SettingsSection(
            header: L10nRText(L10nR.tGENERAL),
            tiles: [
              LanguageChangeTile(),
              ThemeModeTile(),
            ],
          ),
          const SettingsSection(
            header: L10nRText(L10nR.tTimerAndSpokenContentCAPS),
            tiles: [
              CountBeforeStartTile(),
              // SpokenContentLanguage(),
              SpeakCountBeforeStartTile(),
              SayReadyBeforeGoTile(),
              SayGoWhenRestIsOver(),
              HalfTotalTimeReminder(),
              NearEndReminderTile()
            ],
          ),
          SpeechService.isSupported
              ? const SettingsSection(
                  header: L10nRText(L10nR.tVoiceActionsCAPS),
                  tiles: [
                    VoiceActionsEnabledTile(),
                    AvailableVoiceActionsTile(),
                    RestOnlyTriggerTile(),
                    AvailableMicrophonesTile(),
                    TriggerSensitivityTile(),
                  ],
                )
              : const SettingsSection(
                  header: L10nRText(L10nR.tVoiceTriggerCAPS),
                  tiles: [
                    MicRestTriggerTile(),
                    AvailableMicrophonesTile(),
                    TriggerSensitivityTile(),
                  ],
                ),
          const SettingsSection(
            header: L10nRText(L10nR.tRESET),
            tiles: [ResetToDefaults()],
          ),
        ],
      );

// @override
// Widget build(BuildContext context, WidgetRef ref) => const Padding(
//       padding: GlobalConstants.screensHPadding,
//       child: Center(
//         child: Column(
//           children: [
//             ChangeLanguage(),
//             ChangeThemeMode(),
//           ],
//         ),
//       ),
//     );
}
