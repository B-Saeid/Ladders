import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Utilities/SessionData/session_data.dart';

class ScaleControlledText extends ConsumerWidget {
  final String text;
  final TextStyle? style;
  final double? maxSize;
  final double? maxPercentage;
  final bool allowBelow;
  final String? sizeWrapString;

  const ScaleControlledText(
    this.text, {
    super.key,
    this.style,
    this.maxSize,
    this.maxPercentage,
    this.allowBelow = true,
    this.sizeWrapString,
  });

  bool get shouldScale => maxSize != null || maxPercentage != null || !allowBelow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultStyle = LiveData.textTheme(ref).bodyMedium!;
    TextStyle? scaledStyle;
    if (shouldScale) scaledStyle = getScaledStyle(ref, style ?? defaultStyle);
    return SizedBox(
      width: sizeWrapString?.getWidth(scaledStyle ?? style ?? defaultStyle),
      child: RichText(
        text: TextSpan(text: text, style: scaledStyle ?? style ?? defaultStyle),
      ),
    );
  }

  // double
  TextStyle getScaledStyle(WidgetRef ref, TextStyle style) {
    assert((maxSize ?? style.fontSize!) >= style.fontSize!);
    final scaledSize = style.fontSize!.scalable(
      ref,
      maxValue: maxSize,
      maxPercentage: maxPercentage,
      allowBelow: allowBelow,
    );
    return style.copyWith(fontSize: scaledSize);
  }
}
