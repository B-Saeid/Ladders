import 'package:audio_session/audio_session.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../../../Shared/Styles/adaptive_icons.dart';

enum MicType {
  builtIn,
  bluetooth,
  wired;

  static MicType? from(AudioDeviceType type) => switch (type) {
        AudioDeviceType.wiredHeadset => MicType.wired,
        AudioDeviceType.headsetMic => MicType.wired,
        AudioDeviceType.bluetoothSco => MicType.bluetooth,
        // https://www.link-labs.com/blog/bluetooth-vs-bluetooth-low-energy
        //   AudioDeviceType.bluetoothLe => MicType.bluetooth,
        AudioDeviceType.builtInMic => MicType.builtIn,
        _ => null,
        // AudioDeviceType.unknown => throw UnimplementedError(),
        // AudioDeviceType.builtInEarpiece => throw UnimplementedError(),
        // AudioDeviceType.builtInSpeaker => throw UnimplementedError(),
        // AudioDeviceType.wiredHeadphones => throw UnimplementedError(),
        // AudioDeviceType.lineAnalog => throw UnimplementedError(),
        // AudioDeviceType.lineDigital => throw UnimplementedError(),
        // AudioDeviceType.bluetoothA2dp => throw UnimplementedError(),
        // AudioDeviceType.hdmi => throw UnimplementedError(),
        // AudioDeviceType.hdmiArc => throw UnimplementedError(),
        // AudioDeviceType.usbAudio => throw UnimplementedError(),
        // AudioDeviceType.dock => throw UnimplementedError(),
        // AudioDeviceType.fm => throw UnimplementedError(),
        // AudioDeviceType.fmTuner => throw UnimplementedError(),
        // AudioDeviceType.tvTuner => throw UnimplementedError(),
        // AudioDeviceType.telephony => throw UnimplementedError(),
        // AudioDeviceType.auxLine => throw UnimplementedError(),
        // AudioDeviceType.ip => throw UnimplementedError(),
        // AudioDeviceType.bus => throw UnimplementedError(),
        // AudioDeviceType.hearingAid => throw UnimplementedError(),
        // AudioDeviceType.airPlay => throw UnimplementedError(),
        // AudioDeviceType.avb => throw UnimplementedError(),
        // AudioDeviceType.displayPort => throw UnimplementedError(),
        // AudioDeviceType.carAudio => throw UnimplementedError(),
        // AudioDeviceType.fireWire => throw UnimplementedError(),
        // AudioDeviceType.pci => throw UnimplementedError(),
        // AudioDeviceType.thunderbolt => throw UnimplementedError(),
        // AudioDeviceType.virtual => throw UnimplementedError(),
        // AudioDeviceType.builtInSpeakerSafe => throw UnimplementedError(),
        // AudioDeviceType.remoteSubmix => throw UnimplementedError(),
      };

  IconData iconData(bool outlined) => switch (this) {
        MicType.builtIn => outlined ? AdaptiveIcons.microphoneOutlined : AdaptiveIcons.microphone,
        MicType.bluetooth => outlined ? AdaptiveIcons.bluetoothMicOutlined : AdaptiveIcons.bluetoothMic,
        MicType.wired => AdaptiveIcons.headSet,
      };

  static MicType? fromString(String? value) => MicType.values.firstWhereOrNull(
        (element) => element.name == value,
      );
}
