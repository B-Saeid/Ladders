import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Extensions/on_context.dart';
import '../../../Shared/Services/Database/Hive/hive_listenable.dart';
import '../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../Shared/Services/l10n/assets/enums.dart';
import '../Provider/setting_provider.dart';

class ChangeLanguage extends ConsumerWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: HiveListenable<String>(
          box: HiveService.settings,
          chosenKey: SettingsKeys.locale,
          builder: (context, storedSettings) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: LocaleSetting.values
                .map(
                  (element) => ChoiceChip(
                    label: Text(element.displayName(ref)),
                    selected: element == LocaleSetting.fromStored(storedSettings),
                    onSelected: (_) => context.read(settingProvider).setLocaleSetting(element),
                  ),
                )
                .toList(),
          ),
        ),
      );
}
