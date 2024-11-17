import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../Shared/Services/l10n/helper_widgets.dart';
import '../../Shared/Services/l10n/l10n_service.dart';
import '../../Shared/Utilities/Responsiveness/responsive_layout.dart';
import '../Home/utilities/Speech/speech_service.dart';
import 'Package/settings_ui.dart';
import 'Sections/General/language_change_tile.dart';
import 'Sections/General/theme_mode_tile.dart';
import 'Sections/Timer/half_total_time_reminder.dart';
import 'Sections/Timer/near_end_reminder_tile.dart';
import 'Sections/Timer/say_go_when_rest_is_over.dart';
import 'Sections/Timer/say_ready_before_go_tile.dart';
import 'Sections/Timer/speak_start_count_tile.dart';
import 'Sections/Timer/start_count_tile.dart';
import 'Sections/Voice Actions/available_microphones_tile.dart';
import 'Sections/Voice Actions/available_voice_actions_tile.dart';
import 'Sections/Voice Actions/rest_mic_trigger_tile.dart';
import 'Sections/Voice Actions/rest_only_trigger_tile.dart';
import 'Sections/Voice Actions/voice_actions_enabled_tile.dart';
import 'Sections/reset_to_defaults.dart';

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
                  ],
                )
              : const SettingsSection(
                  header: L10nRText(L10nR.tVoiceTriggerCAPS),
                  tiles: [
                    MicRestTriggerTile(),
                    AvailableMicrophonesTile(),
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
