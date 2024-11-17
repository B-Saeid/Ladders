import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../../Shared/Styles/adaptive_icons.dart';
import '../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../../Shared/Widgets/custom_animated_size.dart';
import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../Package/settings_ui.dart';
import '../../Provider/setting_provider.dart';

class VoiceActionsEnabledTile extends AbstractSettingsTile {
  const VoiceActionsEnabledTile({super.key});

  bool _switchValue(BuildContext context, WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.enableVoiceActions),
      );

  bool _available(WidgetRef ref) => ref.watch(settingProvider.select((p) => p.speechAvailable));

  bool _loading(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.loadingEnablingVoiceActions),
      );

  bool _restOnlyValue(WidgetRef ref) => ref.watch(settingProvider.select((p) => p.restOnlyTrigger));

  bool _enabled(WidgetRef ref) => !_restOnlyValue(ref);

  @override
  Widget? get description => const _VoiceActionsStatusDescription();

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile.switchTile(
          on: _available(ref) && _switchValue(context, ref),
          // onToggle: (value) => ref.read(settingProvider).setEnableVoiceActions(value),
          onToggle: ref.read(settingProvider).setEnableVoiceActions,
          enabled: _enabled(ref),
          leading: AdaptiveIcons.wSpeakingHead(
            ref: ref,
            color: _enabled(ref) ? null : LiveData.themeData(ref).disabledColor,
          ),
          loading: _loading(ref),
          title: const L10nRText(L10nR.tEnableFeature),
          description: description,
        ),
      );
}

class _VoiceActionsStatusDescription extends ConsumerWidget {
  const _VoiceActionsStatusDescription();

  bool _restOnlyValue(WidgetRef ref) => ref.watch(settingProvider.select((p) => p.restOnlyTrigger));

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      StaticData.platform.isApple ? CustomAnimatedSize(child: _child(ref)) : _child(ref);

  Widget _child(WidgetRef ref) => !_restOnlyValue(ref)
      ? StaticData.platform.isApple
          ? const SizedBox()
          : Text(
              ref.watch(settingProvider).enableVoiceActions
                  ? L10nR.tVoiceActionsIsEnabled(ref)
                  : L10nR.tVoiceActionsIsDisabled(ref),
            )
      : Text(L10nR.tCannotBeEnabledWithRestOnly(ref));
}
