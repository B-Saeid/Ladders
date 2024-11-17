import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/l10n/l10n_service.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Utilities/Responsiveness/responsive_layout.dart';
import '../../Home/utilities/Speech/speech_service.dart';
import '../../Home/utilities/dialogues.dart';
import '../../Home/utilities/enums.dart';
import '../Provider/setting_provider.dart';

class VoiceActionsScreen extends ConsumerWidget {
  const VoiceActionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const ResponsiveLayout(
        title: L10nR.tVoiceActions,
        content: _VoiceActionsContent(),
        endDrawer: true,
      );
}

class _VoiceActionsContent extends ConsumerWidget {
  const _VoiceActionsContent();

  bool available(WidgetRef ref) => ref.watch(settingProvider).ttsAvailable;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView(
        shrinkWrap: true,
        children: VoiceAction.values
            .map(
              (e) => ListTile(
                leading: e.icon,
                title: Text(e.word),
                subtitle: Text(e.description),
                trailing: IconButton(
                  icon: Icon(AdaptiveIcons.speaker),
                  onPressed: () => available(ref)
                      ? TTSService.speak(e.spokenWord, now: true)
                      : Dialogues.showSpokenContentNotAvailable(context),
                ),
              ),
            )
            .toList(),
      );
}
