import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../../Shared/Styles/adaptive_icons.dart';
import '../../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../../Models/mic_type_enum.dart';
import '../../Models/microphone_model.dart';
import '../../Package/settings_ui.dart';
import '../../Provider/setting_provider.dart';

class AvailableMicrophonesTile extends AbstractSettingsTile {
  const AvailableMicrophonesTile({super.key});

  static List<Microphone> microphones(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.microphones),
      );

  static Microphone? microphone(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.microphone),
      );

  static bool enabled(WidgetRef ref) => ref.watch(
        settingProvider.select((p) => p.enableVoiceActions || p.restOnlyTrigger),
      );

  @override
  bool get hasLeading => false;

  // @override
  // Widget? get description => const _AvailableMicsDescription();

  @override
  Widget build(BuildContext context) => RefWidget(
        (ref) => SettingsTile(
          // leading: leading(ref),
          enabled: enabled(ref) && microphones(ref).isNotEmpty,
          trailing: IconButton(
            onPressed: () => ref.read(settingProvider).updateInputDevices(toast: true),
            icon: Icon(AdaptiveIcons.reload),
          ),
          title: _InputDevicesDropDown(
            microphones(ref),
            microphone(ref),
            enabled(ref),
          ),
          // description: description,
        ),
      );

// Widget leading(WidgetRef ref) {
//   final micType = microphone(ref)?.type;
//   return micType == null || micType == MicType.builtIn
//       ? Icon(AdaptiveIcons.microphoneCircle)
//       : micType.icon(false);
// }
}

// class _AvailableMicsDescription extends ConsumerWidget {
//   const _AvailableMicsDescription();
//
//   static bool enabled(WidgetRef ref) => ref.watch(
//         settingProvider.select((p) => p.enableVoiceActions || p.restOnlyTrigger),
//       );
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) => CustomAnimatedSize(
//         child: enabled(ref) ? const SizedBox() : Text(L10nR.tEitherRestTriggerOrVoiceActions(ref)),
//       );
// }

class _InputDevicesDropDown extends ConsumerWidget {
  const _InputDevicesDropDown(
    this.microphones,
    this.microphone,
    this.enabled,
  );

  final List<Microphone> microphones;
  final Microphone? microphone;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) => LayoutBuilder(
        builder: (_, constraints) => DropdownMenu(
          width: constraints.maxWidth,
          dropdownMenuEntries: microphones
              .map(
                (e) => DropdownMenuEntry(
                  value: e,
                  label: e.name,
                  leadingIcon: e.type?.icon(false),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              )
              .toList(),
          enabled: enabled,
          // enabled: enabled && microphones.length > 1,
          leadingIcon: leading(ref),
          label: Text(L10nR.tVoiceInput(ref)),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            filled: microphones.length > 1 ? true : false,
          ),
          /// Super nice documentation of this attribute.
          requestFocusOnTap: false,
          onSelected: (value) => value != null ? ref.read(settingProvider).setMicrophone(value) : null,
          trailingIcon: Icon(AdaptiveIcons.arrowDown),
          selectedTrailingIcon: Icon(AdaptiveIcons.arrowUp),
          initialSelection: microphone,
          /// If allowed it threw:
          /// Unhandled Exception: 'package:flutter/src/rendering/object.dart': Failed assertion: line 3347 pos 14: 'renderer.parent != null': is not true.
          /// encountered on Windows.
          ///
          /// we did allowed it to highlight the currently selected mic
          /// we can do this by another way. TODO
          enableSearch: false,
          menuStyle: const MenuStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 10)),
          ),
        ),
      );

  Widget leading(WidgetRef ref) {
    final micType = microphone?.type;
    return micType == null || micType == MicType.builtIn ? Icon(AdaptiveIcons.microphoneCircle) : micType.icon(false);
  }

  /// [PopupMenuButton] was not updating lively with microphone list changes
  /// the thing that would allow a Meticulous user like me ^^ to open the popup and
  /// force a change in the list like disconnecting a headset or airpods and trying
  /// to select it, the thing that can lead to an unexpected behavior.
  ///
  /// This was Experienced.
// @override
// Widget build(BuildContext context, WidgetRef ref) => PopupMenuButton<Microphone>(
//       onSelected: (value) => ref.read(settingProvider).setMicrophone(value),
//
//       /// null: will display the default: 'Show Menu'
//       tooltip: microphones(ref).length > 1 ? null : '',
//       // enabled: microphones.length > 1,
//       position: PopupMenuPosition.under,
//
//       child: buildTextContainer(ref),
//       itemBuilder: (_) => microphones(ref)
//           .map(
//             (mic) => buildPopupMenuItem(mic, ref),
//           )
//           .toList(),
//     );
//
// TextContainer buildTextContainer(WidgetRef ref) => TextContainer(
//       animated: true,
//       margin: EdgeInsets.zero,
//       color: microphones.length > 1 && enabled ? AppColors.adaptivePrimary(ref) : null,
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//       child: Text(
//         microphone?.name ?? '---',
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: LiveData.textTheme(ref).bodyMedium?.copyWith(
//               color: enabled ? null : LiveData.themeData(ref).disabledColor,
//             ),
//       ),
//     );
//
// PopupMenuItem<Microphone> buildPopupMenuItem(
//   Microphone mic,
//   WidgetRef ref,
// ) =>
//     PopupMenuItem(
//       padding: EdgeInsets.zero,
//       value: mic,
//       child: ListTile(
//         leading: mic.type?.icon(false),
//         // OPTIONALLY LATER ON
//         title: Text(
//           mic.name,
//           style: LiveData.textTheme(ref).titleMedium,
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         visualDensity: VisualDensity.compact,
//         selected: microphone == mic,
//         selectedTileColor: AppColors.adaptivePrimary(ref).withAlpha(100),
//       ),
//     );
}
