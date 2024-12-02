import 'dart:ui';

extension TextDirectionExtension on TextDirection {
  bool get isRTL => this == TextDirection.rtl;
  bool get isLTR => this == TextDirection.ltr;
}
