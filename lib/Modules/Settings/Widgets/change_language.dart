import 'package:flutter/material.dart';

import '../../../Shared/Constants/assets_strings.dart';
import '../../../Shared/Extensions/on_context.dart';
import '../../../Shared/Services/Database/Hive/hive_listenable.dart';
import '../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../Shared/Services/l10n/assets/enums.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../Provider/setting_provider.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: HiveListenable<String>(
          box: HiveService.settings,
          chosenKey: SettingsKeys.locale,
          builder: (context, storedSettings) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: LocaleSetting.values
                .map(
                  (element) => ChoiceChip(
                    label: RefWidget(
                      (ref) => Text(
                        element.displayName(ref),
                        style: element.isArabic
                            ? LiveData.textTheme(ref).bodyMedium!.copyWith(fontFamily: AssetFonts.cairo)
                            : null,
                      ),
                    ),
                    selected: element == LocaleSetting.fromStored(storedSettings),
                    onSelected: (_) => context.read(settingProvider).setLocaleSetting(element),
                  ),
                )
                .toList(),
          ),
        ),
      );
}
