import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Styles/app_themes.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../Package/src/tiles/abstract_settings_tile.dart';
import '../Package/src/tiles/settings_tile.dart';
import '../Provider/setting_provider.dart';

class ThemeModeTile extends AbstractSettingsTile {
  const ThemeModeTile({super.key});

  ThemeMode currentThemeMode(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.themeMode),
      );

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile(
          leading: Icon(AdaptiveIcons.theme),
          title: const L10nRText(L10nR.tThemeMode),
          value: Text(currentThemeMode(ref).displayName(ref)),
          onPressed: () => StaticData.platform.isApple
              ? _showAppleActionSheet(context, ref)
              : _showMaterialBottomSheet(context, ref),
        ),
      );

  void _showAppleActionSheet(BuildContext context, WidgetRef ref) => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(
            L10nR.tChangeTheme(ref),
            style: TextStyle(fontFamily: ref.read(stylesProvider).topLevelFamily),
          ),
          actions: ThemeMode.values
              .map(
                (mode) => CupertinoActionSheetAction(
                  onPressed: () => _onPressed(ref, mode, context),
                  child: Text(
                    mode.displayName(ref),
                    style: _cupertinoActionSheetTextStyle(ref, mode),
                  ),
                ),
              )
              .toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: Navigator.of(context).pop,
            isDestructiveAction: true,
            child: Text(
              L10nR.tDismiss(ref),
              style: _destructiveTextStyle(ref),
            ),
          ),
        ),
      );

  /// Since CupertinoThemeData until now does not follow up with global ThemeData
  TextStyle _cupertinoActionSheetTextStyle(WidgetRef ref, ThemeMode mode) =>
      LiveData.textTheme(ref).titleLarge!.copyWith(
            fontFamily: ref.read(stylesProvider).topLevelFamily,
            color: currentThemeMode(ref) == mode ? StaticData.themeData.colorScheme.primary : null,
          );

  TextStyle _destructiveTextStyle(WidgetRef ref) => LiveData.textTheme(ref)
          .titleLarge! /*.copyWith(
        fontFamily: ref.read(stylesProvider).topLevelFamily,
        color: CupertinoColors.destructiveRed,
      )*/
      ;

  void _onPressed(WidgetRef ref, ThemeMode mode, BuildContext context) {
    ref.read(settingProvider).setThemeMode(mode);
    Navigator.of(context).pop();
  }

  void _showMaterialBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values
              .map(
                (mode) => RadioListTile(
                  onChanged: (_) => _onPressed(ref, mode, context),
                  title: Text(mode.displayName(ref)),
                  value: mode,
                  groupValue: currentThemeMode(ref),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
