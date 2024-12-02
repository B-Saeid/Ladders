import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:collection/collection.dart';
import 'package:record/record.dart';

import '../../../Modules/Settings/Models/mic_type_enum.dart';
import '../../../Modules/Settings/Models/microphone_model.dart';
import '../../../Modules/Settings/Provider/setting_provider.dart';
import '../../Components/Toast/toast.dart';
import '../../Extensions/on_context.dart';
import '../../Utilities/SessionData/session_data.dart';
import '../Database/Hive/hive_service.dart';
import '../Routing/routes_base.dart';
import '../l10n/assets/l10n_resources.dart';

abstract class AudioSessionService {
  static final AudioRecorder _recorder = AudioRecorder();

  static StreamSubscription? _sub;

  static bool get _isMobile => StaticData.platform.isMobile;

  static bool get _shouldContinue {
    final restOnlyTrigger = HiveService.settings.get(SettingsKeys.restOnlyTrigger) ?? false;
    final enableVoiceActions = HiveService.settings.get(SettingsKeys.enableVoiceActions) ?? false;
    return restOnlyTrigger || enableVoiceActions;
  }

  static Future<void> listenOnDeviceChanges() async {
    print('==================== listenOnDeviceChanges');
    final session = await AudioSession.instance;

    final provider = RoutesBase.activeContext!.read(settingProvider);
    if (_isMobile) {
      print('CHECK ============== Entered mobile');
      // _sub ??= session.devicesStream.listen(_onDevicesChanges);
      _sub ??= session.devicesStream.listen(
        (event) async {
          if (!_shouldContinue) {
            print('Event captured but !Processed since _shouldContinue: $_shouldContinue}');
            print('==================== !Processed event = $event');
            return;
          }
          print('==================== Processed event = $event');
          await provider.updateInputDevices(
            sessionInputDevices: event,
            userAction: false,
          );
        },
      );
    } /*else {
      if (!_shouldContinue || noLoop) return;
      await provider.updateInputDevices(userAction: false);
    }*/

    // listen to *any device* connection state changes
    // _sub3 ??= FlutterBluePlus.events.onConnectionStateChanged.listen(
    //   (event) {
    //     print('FROM FlutterBluePlus ${event.device} ${event.connectionState}');
    //   },
    // );
  }

  // static Future<void> _craftedListen() async {
  //   /// T O D O : DONE! LATER ON and keep monitoring your issue
  //   /// https://github.com/ryanheise/audio_session/issues/148
  //   /// REPLY: https://github.com/ryanheise/audio_session/issues/149#issuecomment-2472482879
  // }

  static Future<List<Microphone>?> currentInputDevices({
    List<Microphone> oldList = const [],
    Set<AudioDevice>? sessionInputDevices,
    bool toast = false,
  }) async {
    // if (!_shouldContinue) return oldList;

    final devices = sessionInputDevices ?? await _sessionInputDevices();

    return await _updateVoiceInputs(
      devices,
      oldList,
      toast: toast,
    );
  }

  static Future<Set<AudioDevice>> _sessionInputDevices() async {
    final session = await AudioSession.instance;
    final devices = await session.getDevices();
    return devices.where((element) => element.isInput).toSet();
  }

  static Future<List<Microphone>?> _updateVoiceInputs(
    Set<AudioDevice> audioSessionInputDevices,
    List<Microphone> oldList, {
    bool toast = false,
  }) async {
    final permission = await _recorder.hasPermission();

    if (!permission) {
      print('In _updateVoiceInputs: Microphone permission is not granted');
      return null;
    }

    print('In _updateVoiceInputs -- > audioSessionInputDevices: \n${audioSessionInputDevices.map(
      (e) => '$e\n',
    )}');

    final inputDevices = (await _recorder.listInputDevices())
        .whereNot(
          /// This was encountered on macOS, and it was a duplicate input device
          /// representing the default mic, which is being used by the OS
          /// while the default device is also listed as another input device
          /// with its normal label  "MacBook Air Microphone".
          ///
          /// It appeared right after we granted the permission of a speech recognition.
          ///
          /// for detail about possible reasons of that [CADefaultDeviceAggregate] check:
          /// https://forums.developer.apple.com/forums/thread/124316?answerId=389263022#389263022
          (e) => e.label.contains('CADefaultDeviceAggregate'),
        )
        .toList();

    print('old microphones = $oldList');
    print('In updateInputDevices: new inputDevices = $inputDevices');

    final oldInputDevices = oldList.map((e) => (e.inputDevice)).toList();
    print('old inputDevices = $oldInputDevices');

    final newMicrophones = inputDevices
        .map((recordInputDevice) {
          /// Note: we check if the platform is mobile before performing the mapping and matching
          /// because AudioSession only works on mobile devices.
          if (!_isMobile) {
            return Microphone.fromInputDevice(recordInputDevice);
          } else {
            final matchedInputDevice = audioSessionInputDevices.firstWhereOrNull(
              (audioSessionInputDevice) => audioSessionInputDevice.id == recordInputDevice.id,
            );

            if (matchedInputDevice == null) return null;

            /// That is added because - on HTC Desire 10 Pro Android 6 - the list contained devices
            /// that are not capable of recording like:
            ///
            /// HTC Desire 10 Pro (built-in microphone) - OK!
            /// HTC Desire 10 Pro (FM tuner) ??!
            /// HTC Desire 10 Pro (IP) ??!
            ///
            /// So we are going to remove them from the list as long as their type is other than
            /// the known ones i.e. null see [Microphone.from]
            final type = MicType.from(matchedInputDevice.type);
            if (type == null) return null;

            return Microphone.fromInputDevice(
              recordInputDevice,
              type: MicType.from(matchedInputDevice.type),
            );
          }
        })
        .nonNulls
        .toList();

    final newInputDevices = newMicrophones.map((e) => (e.inputDevice)).toList();
    print('FILTERED new inputDevices = $newInputDevices');
    final oldEqualsNew = newInputDevices.equals(oldInputDevices);
    print('oldEqualsNew $oldEqualsNew');

    if (oldEqualsNew) {
      if (toast) Toast.show(L10nR.tVoiceInputsAreUpToDate());
      return oldList;
    } else {
      if (toast) Toast.showSuccess(L10nR.tUpdatedVoiceInputDevice());
      return newMicrophones;
    }
  }

  // static void _onDevicesChanges(Set<AudioDevice> devices) => _checkPermission().then(
//       (hasPermission) {
//         if (!hasPermission) {
//           print('In _onDevicesChanges: Microphone permission is not granted');
//           return;
//         }
//
//         print('FROM devicesStream -- > devices: \n$devices');
//
//         final notBuiltInDevice = _determineIfNotBuiltIn(devices);
//
//         _recorder!.listInputDevices().then(
//           (List<InputDevice> list) {
//             print('inputDevices: \n$list');
//             print('notBuiltInDevice: $notBuiltInDevice');
//
//             /// Updating microphones list
//             microphones.value = list.map<Microphone>(
//               (inputDevice) {
//                 final matchInputDevice = devices.firstWhereOrNull(
//                   (audioDevice) => audioDevice.id == inputDevice.id,
//                 );
//
//                 final type =
//                     matchInputDevice == null ? MicType.builtIn : MicType.from(matchInputDevice.type);
//
//                 return Microphone.fromInputDevice(inputDevice, type);
//               },
//             ).toList();
//
//             /// Updating micType
//             if (notBuiltInDevice == null) {
//               micTypeNotifier.value = MicType.builtIn;
//             } else {
//               final recordPackageCheck = list.any((element) => element.id == notBuiltInDevice.id);
//               if (recordPackageCheck) micTypeNotifier.value = MicType.from(notBuiltInDevice.type);
//             }
//           },
//         );
//       },
//     );

// static AudioDevice? _determineIfNotBuiltIn(Set<AudioDevice> devices) {
//   AudioDevice? notBuiltInDevice;
//
//   /// Determining if there is a device other than the built-in microphone
//   /// as if there is one it is used by default - [EXPERIENCED] on Android & iOS
//   devices.any((element) {
//     // print('element: $element');
//     if (!element.isInput) return false; // since devices contains outputs
//
//     /// This line was a bug as Some bluetooth devices are output and input [Experienced]
//     // if (element.isOutput) return false;
//
//     final (id, name, type) = (element.id, element.name, element.type);
//     print('id: $id, name: $name, type: $type');
//
//     final micType = MicType.from(element.type);
//
//     if (micType != MicType.builtIn) notBuiltInDevice = element;
//
//     return notBuiltInDevice != null;
//   });
//   return notBuiltInDevice;
// }

// static void printRecorderInputDevices() {
//   _recorder!.listInputDevices().then(
//     (value) async {
//       print('inputDevices: \n$value');
//       final session = await AudioSession.instance;
//       final devices = await session.getDevices(includeOutputs: false);
//
//       print('devices: \n$devices');
//     },
//   );
// }

  static Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
    // await _sub3?.cancel();
    // _sub3 = null;
    // micTypeNotifier?.dispose();
    // micTypeNotifier = null;
  }
}
