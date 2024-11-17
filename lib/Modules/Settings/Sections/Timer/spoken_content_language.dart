// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../Shared/Services/l10n/assets/enums.dart';
// import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
// import '../../../../Shared/Styles/adaptive_icons.dart';
// import '../../../../Shared/Styles/app_themes.dart';
// import '../../../../Shared/Utilities/SessionData/session_data.dart';
// import '../../../../Shared/Widgets/apple_action_sheet.dart';
// import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
// import '../../Package/settings_ui.dart';
// import '../../Provider/setting_provider.dart';
//
// class SpokenContentLanguage extends AbstractSettingsTile {
//   const SpokenContentLanguage({super.key});
//
//   // String current(WidgetRef ref) {
//   //   TTSService.init();
//   //   return ref.watch(settingProvider).ttsLocale?.displayName ?? L10nR.tAppLanguage(ref);
//   // }
//
//   LocaleSetting languageSettings(WidgetRef ref) => ref.read(settingProvider).localeSettings;
//
//   @override
//   Widget build(BuildContext context) => RefWidget(
//         (ref) => SettingsTile(
//           leading: AdaptiveIcons.wSpeakingHead(ref: ref),
//           title: Text(L10nR.tSpokenContentLanguage(ref)),
//           value: Text(
//             // current(ref),
//             'current(ref)',
//             style: TextStyle(
//               fontFamily: 'current(ref)' == SupportedLocale.ar.displayName
//                   ? ref.read(stylesProvider).arabicFontFamily
//                   : null,
//             ),
//           ),
//           onPressed: () => StaticData.platform.isApple
//               ? _showAppleActionSheet(context, ref)
//               : _showMaterialBottomSheet(context, ref),
//         ),
//       );
//
//   void _showAppleActionSheet(BuildContext context, WidgetRef ref) => showCupertinoModalPopup(
//         context: context,
//         builder: (context) => CupertinoActionSheet(
//           title: Text(
//             L10nR.tChangeSpokenContentLanguage(ref),
//             style: LiveData.textTheme(ref).titleLarge!,
//           ),
//           message: Wrap(
//             alignment: WrapAlignment.center,
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               Text(
//                 L10nR.tAppLanguage(ref) + L10nR.tColonSpace,
//                 style: TextStyle(fontFamily: ref.read(stylesProvider).topLevelFamily),
//               ),
//               Text(
//                 languageSettings(ref).displayName(ref),
//                 style: TextStyle(
//                   fontFamily: (SupportedLocale.fromLocale(languageSettings(ref).locale!)).isArabic
//                       ? ref.read(stylesProvider).arabicFontFamily
//                       : ref.read(stylesProvider).topLevelFamily,
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             AppleSheetAction(
//               context: context,
//               title: L10nR.tAppLanguage,
//               style: _highlightSelected(ref, false, L10nR.tAppLanguage(ref)),
//               onPressed: () => _action(ref, null),
//             ),
//           ]
//               .followedBy(
//                 SupportedLocale.values.map(
//                   (locale) => AppleSheetAction(
//                     context: context,
//                     title: (_) => locale.displayName,
//                     style: _highlightSelected(ref, locale.isArabic, locale.displayName),
//                     onPressed: () => _action(ref, locale),
//                   ),
//                 ),
//               )
//               .toList(),
//           cancelButton: AppleSheetAction(context: context, title: L10nR.tDone),
//         ),
//       );
//
//   /// Since CupertinoThemeData until now does not follow up with global ThemeData
//   TextStyle _highlightSelected(WidgetRef ref, bool isArabic, String name) =>
//       LiveData.textTheme(ref).titleLarge!.copyWith(
//             fontFamily: isArabic ? ref.read(stylesProvider).arabicFontFamily : null,
//             color: 'current(ref)' == name ? StaticData.themeData.colorScheme.primary : null,
//           );
//
//   void _action(WidgetRef ref, SupportedLocale? locale) =>
//       ref.read(settingProvider) /*.setTtsLocale(locale)*/;
//
//   void _showMaterialBottomSheet(BuildContext context, WidgetRef ref) {
//     showModalBottomSheet(
//       showDragHandle: true,
//       context: context,
//       builder: (context) => Padding(
//         padding: const EdgeInsets.only(bottom: 20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             RadioListTile(
//               onChanged: (_) {
//                 Navigator.of(context).pop();
//                 _action(ref, null);
//               },
//               title: Text(L10nR.tAppLanguage(ref)),
//               value: L10nR.tAppLanguage(ref),
//               groupValue: 'current(ref)',
//             )
//           ]
//               .followedBy(
//                 SupportedLocale.values.map(
//                   (locale) => RadioListTile(
//                     onChanged: (_) {
//                       Navigator.of(context).pop();
//                       _action(ref, locale);
//                     },
//                     title: Text(
//                       locale.displayName,
//                       style: TextStyle(
//                         fontFamily: locale.isArabic ? ref.read(stylesProvider).arabicFontFamily : null,
//                       ),
//                     ),
//                     value: locale.displayName,
//                     groupValue: 'current(ref)',
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       ),
//     );
//   }
// }
