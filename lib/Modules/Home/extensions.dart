import 'package:flutter/material.dart';

extension EasyComparison on ThemeMode {
  bool get isAuto => this == ThemeMode.system;

  bool get isLight => this == ThemeMode.light;

  bool get isDark => this == ThemeMode.dark;
}
