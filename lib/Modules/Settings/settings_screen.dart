import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../Shared/Services/l10n/helper_widgets.dart';
import '../../Shared/Utilities/Responsiveness/responsive_layout.dart';
import 'Package/settings_ui.dart';
import 'Widgets/language_change_tile.dart';
import 'Widgets/theme_mode_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const ResponsiveLayout(
        title: L10nR.tSettings,
        content: _SettingContent(),
        endDrawer: true,
      );
}

class _SettingContent extends ConsumerWidget {
  const _SettingContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SettingsList(
      sections: [
        SettingsSection(
          title: L10nRText(L10nR.tGENERAL),
          tiles: [
            LanguageChangeTile(),
            ThemeModeTile(),
          ],
        ),
      ],
    );
  }

// @override
// Widget build(BuildContext context, WidgetRef ref) => const Padding(
//       padding: GlobalConstants.screensHPadding,
//       child: Center(
//         child: Column(
//           children: [
//             ChangeLanguage(),
//             ChangeThemeMode(),
//           ],
//         ),
//       ),
//     );
}
