part of 'tile.dart';

abstract class SensitivityConstants {
  static const int maxDBValue = 80;

  // static final _colorsAndPercentageList = [
  //   (Colors.grey, 0.2),
  //   (Colors.blue, 0.35),
  //   (Colors.lightGreen, 0.2),
  //   (Colors.lime, 0.15),
  //   (Colors.red, 0.1),
  // ];

  static final _colorsList = [
    Colors.grey,
    Colors.blue,
    Colors.lightGreen,
    Colors.lime,
  ];

  static final _fadedColorsList = _colorsList.map((e) => e.withOpacity(0.2)).toList();

  // static final _colorsPercentageList = [
  //   0.2,
  //   0.45,
  //   0.2,
  //   0.15,
  // ];

  static final _accumulatedPercentageList = [
    0.2,
    0.65,
    0.85,
    1.0,
  ];
}
