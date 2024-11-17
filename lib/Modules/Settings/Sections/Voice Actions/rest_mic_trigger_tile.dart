import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../../Shared/Styles/adaptive_icons.dart';
import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../Package/settings_ui.dart';
import '../../Provider/setting_provider.dart';

class MicRestTriggerTile extends AbstractSettingsTile {
  const MicRestTriggerTile({super.key});

  bool _switchValue(WidgetRef ref) => ref.watch(settingProvider.select((p) => p.restOnlyTrigger));

  bool _loading(WidgetRef ref) => ref.watch(settingProvider.select((p) => p.restOnlyTriggerLoading));

  @override
  Widget? get description => const L10nRText(L10nR.tRestOnlyTriggerDescription);

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile.switchTile(
          on: _switchValue(ref),
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
