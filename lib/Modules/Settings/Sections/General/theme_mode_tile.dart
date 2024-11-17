import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../../../Shared/Styles/adaptive_icons.dart';
import '../../../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../../../Shared/Widgets/apple_action_sheet.dart';
import '../../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../Package/src/tiles/abstract_settings_tile.dart';
import '../../Package/src/tiles/settings_tile.dart';
import '../../Provider/setting_provider.dart';

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
            L10nR.tChangeThemeMode(ref),
            style: LiveData.textTheme(ref).titleLarge!,
          ),
          actions: ThemeMode.values
              .map(
                (mode) => AppleSheetAction(
                  context: context,
                  onPressed: () => _action(ref, mode),
                  title: mode.displayName,
                  style: _highlightSelected(ref, mode),
                ),
              )
              .toList(),
          cancelButton: AppleSheetAction(
            context: context,
            title: L10nR.tDone,
          ),
        ),
      );

  /// Since CupertinoThemeData until now does not follow up with global ThemeData
  TextStyle _highlightSelected(WidgetRef ref, ThemeMode mode) =>
      LiveData.textTheme(ref).titleLarge!.copyWith(
            color: currentThemeMode(ref) == mode ? StaticData.themeData.colorScheme.primary : null,
          );

  void _action(WidgetRef ref, ThemeMode mode) => ref.read(settingProvider).setThemeMode(mode);

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
                  onChanged: (_) {
                    Navigator.of(context).pop();
                    _action(ref, mode);
                  },
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
