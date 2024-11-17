import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../../Shared/Styles/app_colors.dart';
import '../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../../Shared/Widgets/apple_action_sheet.dart';
import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../../../Shared/Widgets/text_container.dart';
import '../../Package/settings_ui.dart';
import '../../Provider/setting_provider.dart';
import '../../Widgets/my_wheel.dart';

class SayReadyBeforeGoTile extends AbstractSettingsTile {
  const SayReadyBeforeGoTile({super.key});

  bool switchValue(WidgetRef ref) => ref.watch(settingProvider).enableReadyB4Go;

  int countValue(WidgetRef ref) => ref.watch(settingProvider).readyB4Go;

  bool available(WidgetRef ref) => ref.watch(settingProvider).ttsAvailable;

  static const _min = 3;
  static const _max = 15;

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile.switchTile(
          on: switchValue(ref),
          enabled: available(ref),
          onToggle: ref.read(settingProvider).setEnableReadyB4Go,
          onPressed: switchValue(ref) ? () => onTilePressed(context, ref) : null,
          leading: buildLeading(context, ref),
          title: const L10nRText(L10nR.tSayReadyBeforeGo),
        ),
      );

  Widget? buildLeading(BuildContext context, WidgetRef ref) => TextContainer(
        animated: true,
        margin: EdgeInsets.zero,
        color: switchValue(ref) ? AppColors.adaptivePrimary(ref) : null,
        padding: EdgeInsets.symmetric(horizontal: 8.scalable(ref, maxValue: 12)),
        child: Text(
          countValue(ref).toString(),
          style: LiveData.textTheme(ref).titleLarge!.copyWith(
                color: switchValue(ref) ? null : SettingsTheme.of(context).themeData.inactiveTitleColor,
              ),
        ),
      );

  Future<void> onTilePressed(BuildContext context, WidgetRef ref) async {
    final controller = FixedExtentScrollController(initialItem: countValue(ref) - _min);
    await _showAdaptiveActionSheet(context, ref, controller);
    controller.dispose();
  }

  Future<void> _showAdaptiveActionSheet(
    BuildContext context,
    WidgetRef ref,
    FixedExtentScrollController controller,
  ) async =>
      StaticData.platform.isApple
          ? await showCupertinoModalPopup(
              context: context,
              builder: (context) => _MyCupertinoActionSheet(controller),
            )
          : await showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (_) => MyWheel(
                min: _min,
                max: _max,
                controller: controller,
                action: ref.read(settingProvider).setReadyB4Go,
              ),
            );
}

class _MyCupertinoActionSheet extends ConsumerWidget {
  const _MyCupertinoActionSheet(this.controller);

  final FixedExtentScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) => CupertinoActionSheet(
        title: Text(
          L10nR.tSayReadyBeforeGo(ref),
          style: LiveData.textTheme(ref).titleLarge!,
        ),
        actions: [
          MyWheel(
            min: SayReadyBeforeGoTile._min,
            max: SayReadyBeforeGoTile._max,
            controller: controller,
            action: ref.read(settingProvider).setReadyB4Go,
          ),
        ],
        cancelButton: AppleSheetAction(
          context: context,
          title: L10nR.tDone,
        ),
      );
}
