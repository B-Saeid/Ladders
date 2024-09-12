import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Shared/Services/l10n/assets/enums.dart';
import '../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../Shared/Styles/adaptive_icons.dart';
import '../../Shared/Utilities/Responsiveness/responsive_layout.dart';
import '../../Shared/Utilities/SessionData/session_data.dart';
import 'Package/settings_ui.dart';
import 'Provider/setting_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const ResponsiveLayout(
        title: L10nR.tHomePageTitle,
        content: _SettingContent(),
        endDrawer: true,
      );
}

SettingsThemeData overriddenSettingTheme(WidgetRef ref) => SettingsThemeData(
      settingsListBackground: LiveData.themeData(ref).scaffoldBackgroundColor,
    );

class _SettingContent extends ConsumerWidget {
  const _SettingContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsList(
      lightTheme: overriddenSettingTheme(ref),
      darkTheme: overriddenSettingTheme(ref),
      sections: [
        SettingsSection(
          title: const Text('General'),
          tiles: <SettingsTile>[
            SettingsTile(
              leading: Icon(AdaptiveIcons.language),
              title: const Text('Language'),
              value: Text(currentLanguage(ref)),
              onPressed: (context) {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: LocaleSetting.values
                          .map(
                            (element) => CupertinoActionSheetAction(
                              onPressed: () {
                                ref.read(settingProvider).setLocaleSetting(element);
                                Navigator.of(context).pop();
                              },
                              isDefaultAction: currentLanguage(ref) == element.displayName(ref),
                              child: Text(
                                element.displayName(ref),
                                // style: LiveData.textTheme(ref).titleLarge!.copyWith(
                                //     fontFamily: element.isArabic
                                //         ? AssetFonts.cairo
                                //         : null /*ref.read(stylesProvider).topLevelFamily,
                                //       fontWeight: currentLanguage(ref) == element.displayName(ref)
                                //           ? FontWeight.bold
                                //           : null,*/
                                //     ),
                              ),
                            ),
                          )
                          .toList(),
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: Navigator.of(context).pop,
                        isDestructiveAction: true,
                        child: Text(
                          L10nR.tDismiss(ref),
                          // style: LiveData.textTheme(ref).titleLarge!.copyWith(
                          //     fontFamily: ref.read(stylesProvider).topLevelFamily,
                          //     color: CupertinoColors.destructiveRed),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SettingsTile.switchTile(
              onToggle: (value) {},
              initialValue: true,
              leading: const Icon(Icons.format_paint),
              title: const Text('Enable custom theme'),
            ),
          ],
        ),
      ],
    );
  }

  String currentLanguage(WidgetRef ref) => ref.watch(settingProvider).localeSettings.displayName(ref);

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
