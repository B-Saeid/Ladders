import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Utilities/SessionData/session_data.dart';

class ScaleControlledText extends ConsumerWidget {
  final String text;
  final TextStyle? style;
  final bool scale;
  final List<InlineSpan>? spans;
  final double? maxSize;
  final double? maxFactor;
  final bool allowBelow;
  final String? sizeWrapString;

  const ScaleControlledText(
    this.text, {
    super.key,
    this.spans,
    this.scale = false,
    this.style,
    this.maxSize,
    this.maxFactor,
    this.allowBelow = true,
    this.sizeWrapString,
  });

  bool get shouldScale => scale || maxSize != null || maxFactor != null || !allowBelow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultStyle = LiveData.textTheme(ref).bodyMedium!;
    TextStyle? scaledStyle;
    if (shouldScale) scaledStyle = getScaledStyle(ref, style ?? defaultStyle);
    return SizedBox(
      width: sizeWrapString?.getWidth(scaledStyle ?? style ?? defaultStyle),
      /// Check out later - It behaves similarly todo
      // child: ExcludeSemantics(
      //   child: Text(
      //     text,
      //     style: scaledStyle ?? style ?? defaultStyle,
      //     // children: spans,
      //   ),
      // ),
      child: RichText(
        text: TextSpan(
          text: text,
          style: scaledStyle ?? style ?? defaultStyle,
          children: spans,
        ),
      ),
    );
  }

  // double
  TextStyle getScaledStyle(WidgetRef ref, TextStyle style) {
    assert((maxSize ?? style.fontSize!) >= style.fontSize!);
    final scaledSize = style.fontSize!.scalable(
      ref,
      maxValue: maxSize,
      maxFactor: maxFactor,
      allowBelow: allowBelow,
    );
    return style.copyWith(fontSize: scaledSize);
  }
}
