import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../../Shared/Styles/adaptive_icons.dart';
import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../Package/settings_ui.dart';
import '../../Provider/setting_provider.dart';

class RestOnlyTriggerTile extends AbstractSettingsTile {
  const RestOnlyTriggerTile({super.key});

  bool _switchValue(WidgetRef ref) => ref.watch(settingProvider.select((p) => p.restOnlyTrigger));

  bool _loading(WidgetRef ref) => ref.watch(settingProvider.select((p) => p.restOnlyTriggerLoading));

  @override
  Widget? get description => const L10nRText(L10nR.tRestOnlyTriggerDescription);

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile.switchTile(
          on: _switchValue(ref),

          /// When the setting provider is invalidated - disposed and recalculated -
          /// the [onToggle] threw: " A SettingsProvider was used after being disposed... "
          /// That occurs especially after the settings is reset to defaults
          /// whereas the [restOnlyTrigger] is off.
          ///
          /// Pre NOTE: This [RefWidget] will ONLY rebuild the tile
          /// if either the switch value [_switchValue] or the loading indicator [_loading] changes.
          ///
          /// As mentioned This bug showed up when we reset the settings to defaults, while the
          /// restOnlyTrigger is already off and of course no loading indicator, so neither
          /// [_loading] nor [_switchValue] has changed which causes the [onToggle] to
          /// maintain the old callBack of [setRestOnlyTrigger] which is read from
          /// the disposed disposed [settingProvider].
          ///
          /// So, we need [onToggle] to read from the [settingProvider] ONLY when the tap
          /// event occurs, the thing that a closure - an anonymous function - does.
          ///
          /// if were using the lint unnecessary_lambdas
          /// https://dart.dev/tools/linter-rules/unnecessary_lambdas
          ///
          /// we would ignore it for this line
          ///
          /// A long and quite frustrating debugging YET GOOD EXPERIENCE <3
          // onToggle: ref.read(settingProvider).setRestOnlyTrigger,
          onToggle: (value) => ref.read(settingProvider).setRestOnlyTrigger(value),
          loading: _loading(ref),
          // leading: buildLeading(context, ref),
          // leading: AdaptiveIcons.wResting(size: 24.scalable(ref, maxFactor: 2)),
          leading: Icon(AdaptiveIcons.microphone),
          title: const L10nRText(L10nR.tRestTriggerByMicrophone),
          description: description,
        ),
      );

// Widget? buildLeading(BuildContext context, WidgetRef ref) => Stack(
//       alignment: Alignment.center,
//       children: [
//         Icon(AdaptiveIcons.speakWave),
//         Positioned(
//           child: Transform.rotate(
//             angle: pi / 4,
//             child: Container(
//               width: 2.scalable(ref, maxFactor: 2),
//               height: 24.scalable(ref, maxFactor: 2),
//               decoration: ShapeDecoration(
//                 shape: StadiumBorder(
//                   side: BorderSide(
//                     width: 0.5.scalable(ref, maxValue: 1.5),
//                   ),
//                 ),
//                 color: LiveData.themeData(ref).primaryIconTheme.color,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
}
