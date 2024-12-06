import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';

import '../../../../../Shared/Components/Toast/toast.dart';
import '../../../../../Shared/Extensions/on_text_direction.dart';
import '../../../../../Shared/Extensions/time_package.dart';
import '../../../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../../../Shared/Styles/adaptive_icons.dart';
import '../../../../../Shared/Styles/app_colors.dart';
import '../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../../../Shared/Widgets/custom_animated_size.dart';
import '../../../../../Shared/Widgets/my_handle.dart';
import '../../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../../../../Shared/Widgets/text_container.dart';
import '../../../../Home/provider/home_provider.dart';
import '../../../Package/settings_ui.dart';
import '../../../Provider/setting_provider.dart';

part 'providers/amplitude_stream_provider.dart';
part 'providers/handle_position_provider.dart';
part 'providers/trigger_percentage_provider.dart';
part 'sensitivity_tile_constants.dart';
part 'widgets/bars_List_widget.dart';
part 'widgets/gradient_box_widget.dart';
part 'widgets/limit_dull_handle_widget.dart';
part 'widgets/my_positioned_handle_widget.dart';
part 'widgets/sensitivity_gauge_widget.dart';
part 'widgets/tile_description_widget.dart';

class TriggerSensitivityTile extends AbstractSettingsTile {
  const TriggerSensitivityTile({super.key});

  static bool enabled(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.enableVoiceActions || p.restOnlyTrigger),
      );

  static bool timerIsRunning(WidgetRef ref) => ref.watch(
        homeProvider.select((p) => p.recognizing || p.monitoring || p.loading),
      );

  static bool restOnly(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.restOnlyTrigger),
      );

  static bool recognition(WidgetRef ref) => restOnly(ref)
      ? false
      : ref.watch(
          homeProvider.select((p) => p.recognizing || p.monitoring || p.loading),
        );

  @override
  Widget? get description => const _TileDescription();

  static bool useBarsList(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.useBarsList),
      );

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile(
          leading: Icon(AdaptiveIcons.speakWave),
          enabled: enabled(ref),
          title: Wrap(
            // alignment: WrapAlignment.spaceBetween,
            // runAlignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const L10nRText(L10nR.tTriggerSensitivity),
              _percentageContainer(ref),
              _barsGradientSwitcherIcon(ref)
            ],
          ),
          description: recognition(ref) ? description : null,
          value: Padding(
            /// This is because we do take full control in designing how the value
            /// is placed in [AppleSettingsTile] but not for the other platforms
            /// AND SINCE this is a special tile with a custom value i.e. not just text
            /// so IT IS OK to do this.
            padding: EdgeInsets.only(top: StaticData.platform.isApple ? 0 : 5.0.scalable(ref)),
            child: const _SensitivityGauge(),
          ),
        ),
      );

  TextContainer _percentageContainer(WidgetRef ref) => TextContainer(
        animated: true,
        color: enabled(ref) ? AppColors.adaptivePrimary(ref) : null,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Text('${((ref.watch(triggerPercentageProvider)).clamp(0, 1) * 100).round()} %'),
      );

  GestureDetector _barsGradientSwitcherIcon(WidgetRef ref) => GestureDetector(
        onTap: ref.read(settingProvider.notifier).toggleBarsList,
        child: !useBarsList(ref)
            ? _BarsListIcon(
                24.scalable(ref, maxFactor: 2),
                enabled(ref),
              )
            : _GradientBoxIcon(
                24.scalable(ref, maxFactor: 2),
                enabled(ref),
              ),
      );
}

class _BarsListIcon extends ConsumerWidget {
  const _BarsListIcon(this.dimension, this.enabled);

  final double dimension;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox.square(
        dimension: dimension,
        // width: dimension,
        // height: dimension,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        // decoration: ShapeDecoration(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(dimension / 10),
        //   ),
        // ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: SensitivityConstants._colorsList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Container(
            // width: dimension * _Constants._colorsPercentageList[index],
            width: dimension / SensitivityConstants._colorsList.length,
            decoration: ShapeDecoration(
              color: enabled
                  ? SensitivityConstants._colorsList[index]
                  : SensitivityConstants._fadedColorsList[index],
              shape: const StadiumBorder(
                side: BorderSide(width: 0.1),
              ),
            ),
          ),
        ),
      );
}

class _GradientBoxIcon extends StatelessWidget {
  const _GradientBoxIcon(this.dimension, this.enabled);

  final double dimension;
  final bool enabled;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: dimension,
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(dimension / 10),
            ),
            gradient: LinearGradient(
              colors: enabled ? SensitivityConstants._colorsList : SensitivityConstants._fadedColorsList,
              // stops: _Constants._accumulatedPercentageList,
              begin: AlignmentDirectional.centerStart,
              end: AlignmentDirectional.centerEnd,
            ),
          ),
        ),
      );
}
