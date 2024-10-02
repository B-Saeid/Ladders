import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Constants/assets_strings.dart';
import '../../../Shared/Services/l10n/assets/enums.dart';
import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Services/l10n/helper_widgets.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Styles/app_themes.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../Package/settings_ui.dart';
import '../Provider/setting_provider.dart';

class LanguageChangeTile extends AbstractSettingsTile {
  const LanguageChangeTile({super.key});

  String currentLanguage(WidgetRef ref) => ref.watch(settingProvider).localeSettings.displayName(ref);

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile(
          leading: Icon(AdaptiveIcons.language),
          title: const L10nRText(L10nR.tLanguage),
          value: Text(currentLanguage(ref)),
          onPressed: () => StaticData.platform.isApple
              ? _showAppleActionSheet(context, ref)
              : _showMaterialBottomSheet(context, ref),
        ),
      );

  void _showAppleActionSheet(BuildContext context, WidgetRef ref) => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(
            L10nR.tChangeLanguage(ref),
            style: TextStyle(fontFamily: ref.read(stylesProvider).topLevelFamily),
          ),
          message: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                L10nR.tDeviceLanguage(ref),
                style: TextStyle(fontFamily: ref.read(stylesProvider).topLevelFamily),
              ),
              Text(
                deviceLanguage,
                style: TextStyle(
                  fontFamily: deviceLanguage == SupportedLocale.ar.displayName
                      ? ref.read(stylesProvider).arabicFontFamily
                      : ref.read(stylesProvider).topLevelFamily,
                ),
              ),
            ],
          ),
          actions: LocaleSetting.values
              .map(
                (setting) => CupertinoActionSheetAction(
                  onPressed: () => _onPressed(ref, setting, context),
                  child: Text(
                    setting.displayName(ref),
                    style: _cupertinoActionSheetTextStyle(ref, setting),
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

  String get deviceLanguage => SupportedLocale.fromLocale(LocaleSetting.auto.locale!).displayName;

  /// Since CupertinoThemeData until now does not follow up with global ThemeData
  TextStyle _cupertinoActionSheetTextStyle(WidgetRef ref, LocaleSetting setting) =>
      LiveData.textTheme(ref).titleLarge!.copyWith(
            fontFamily: setting.isArabic ? ref.read(stylesProvider).arabicFontFamily : null,
            color: currentLanguage(ref) == setting.displayName(ref)
                ? StaticData.themeData.colorScheme.primary
                : null,
          );

  TextStyle _destructiveTextStyle(WidgetRef ref) => LiveData.textTheme(ref)
          .titleLarge! /*.copyWith(
        color: CupertinoColors.destructiveRed,
      )*/
      ;

  void _onPressed(WidgetRef ref, LocaleSetting element, BuildContext context) {
    ref.read(settingProvider).setLocaleSetting(element);
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
          children: LocaleSetting.values
              .map(
                (setting) => RadioListTile(
                  onChanged: (_) => _onPressed(ref, setting, context),
                  title: Text(
                    setting.displayName(ref),
                    style: TextStyle(fontFamily: setting.isArabic ? AssetFonts.cairo : null),
                  ),
                  value: setting.displayName(ref),
                  groupValue: currentLanguage(ref),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
