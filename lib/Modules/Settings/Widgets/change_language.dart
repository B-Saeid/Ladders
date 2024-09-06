import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/Database/Hive/hive_listenable.dart';
import '../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../Shared/Services/l10n/assets/enums.dart';
import '../Provider/setting_provider.dart';

class ChangeLanguage extends ConsumerWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(settingProvider.select((value) => value.localeSettings));
    final provider = ref.read(settingProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: HiveListenable<String>(
          box: HiveService.settings,
          chosenKey: SettingsKeys.locale,
          builder: (context, storedSettings) {
            final currentStoredSettings = LocaleSetting.fromStored(storedSettings) ??
                LocaleSetting.auto /*This is returned when language settings is never changed*/;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Badge(
                  isLabelVisible: currentStoredSettings.isAuto && !selected.isAuto,
                  label: const FittedBox(child: Icon(Icons.refresh_rounded)),
                  child: ChoiceChip(
                    label: const Text('Device Default'),
                    selected: selected.isAuto,
                    onSelected: (_) => provider.scheduleLocaleSettingUpdate(LocaleSetting.auto),
                  ),
                ),
                Badge(
                  isLabelVisible: currentStoredSettings.isEnglish && !selected.isEnglish,
                  label: const FittedBox(child: Icon(Icons.refresh_rounded)),
                  child: ChoiceChip(
                    label: const Text('EN'),
                    selected: selected.isEnglish,
                    onSelected: (_) => provider.scheduleLocaleSettingUpdate(LocaleSetting.english),
                  ),
                ),
                Badge(
                  isLabelVisible: currentStoredSettings.isArabic && !selected.isArabic,
                  label: const FittedBox(child: Icon(Icons.refresh_rounded)),
                  child: ChoiceChip(
                    label: const Text('AR'),
                    selected: selected.isArabic,
                    onSelected: (_) => provider.scheduleLocaleSettingUpdate(LocaleSetting.arabic),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
