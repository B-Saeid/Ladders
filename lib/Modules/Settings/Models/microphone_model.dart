import 'dart:convert';

import 'package:record/record.dart';

import 'mic_type_enum.dart';

class Microphone {
  final String id;
  final String name;
  final MicType? type;

  Microphone({required this.id, required this.name, this.type});

  InputDevice get inputDevice => InputDevice(id: id, label: name);

  factory Microphone.fromInputDevice(InputDevice device, {MicType? type}) => Microphone(
        id: device.id,
        name: device.label,
        type: type,
      );

  InputDevice toInputDevice() => InputDevice(
        id: id,
        label: name,
      );

  String get toJson => jsonEncode(
        {
          'id': id,
          'name': name,
          if (type != null) 'type': type!.name,
        },
      );

  factory Microphone.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return Microphone(
      id: map['id'],
      name: map['name'],
      type: MicType.fromString(map['type']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Microphone &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => Object.hashAll([id, name, type]);

  @override
  String toString() => 'Microphone(id: $id, name: $name, type: $type)';
}
