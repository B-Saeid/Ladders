import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Styles/app_colors.dart';
import '../Provider/setting_provider.dart';

class ChangeThemeMode extends ConsumerWidget {
  const ChangeThemeMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingProvider.select((p) => p.themeMode));
    final provider = ref.read(settingProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (AppColors.isDarkModeSupported)
          ChoiceChip(
            label: Text(L10nR.tAuto(ref)),
            selected: themeMode.isAuto,
            onSelected: (_) => provider.setThemeMode(ThemeMode.system),
          ),
        ChoiceChip(
          label: Text(L10nR.tLight(ref)),

          /// This is for showing the selection on light mode by default for ANDROID devices
          /// that do not support dark mode they are the same devices which do not
          /// show the Automatic Chip above
          selected: themeMode.isLight || (!AppColors.isDarkModeSupported ? themeMode.isAuto : false),
          onSelected: (_) => provider.setThemeMode(ThemeMode.light),
        ),
        ChoiceChip(
          label: Text(L10nR.tDark(ref)),
          selected: themeMode.isDark,
          onSelected: (_) => provider.setThemeMode(ThemeMode.dark),
        ),
      ],
    );
  }
}
