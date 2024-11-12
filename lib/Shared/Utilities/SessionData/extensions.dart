part of 'session_data.dart';

extension LiveScaledValue on num {
  double scalable(
    WidgetRef ref, {
    bool allowBelow = true,
    double? maxValue,
    double? maxFactor,
  }) {
    assert((maxValue ?? double.infinity) > this, 'maxValue $maxValue must be greater than $this');
    return LiveData._getScaledValue(
      ref,
      baseValue: toDouble(),
      allowBelow: allowBelow,
      maxFactor: maxFactor,
      maxValue: maxValue,
    );
  }

  double delayedScale(
    WidgetRef ref, {
    required double startFrom,
    double? beforeStart,
    double? maxValue,
    double? maxFactor,
  }) {
    _safetyAssertion(startFrom, maxValue, maxFactor);
    return LiveData._getScaledValue(
      ref,
      startFrom: startFrom,
      beforeStart: beforeStart,
      baseValue: toDouble(),
      maxFactor: maxFactor,
      maxValue: maxValue,
    );
  }

  void _safetyAssertion(double startFrom, double? maxValue, double? maxPercentage) {
    assert(
      startFrom.isFinite && !startFrom.isNegative,
      'startFrom must be finite and non-negative',
    );
    // assert(
    //   (maxValue ?? double.infinity) >= this * startFrom,
    //   'maxValue $maxValue must be greater than ${this * startFrom}',
    // );
    assert(
      (maxPercentage ?? double.infinity) > startFrom && !startFrom.isNegative,
      'maxPercentage $maxPercentage must be greater than $startFrom',
    );
  }
}

extension LiveStringWidth on String {
  TextPainter _getPainter(TextStyle style, {bool ltr = true}) {
    final textSpan = TextSpan(text: this, style: style);
    final tp = TextPainter(
      text: textSpan,
      textDirection: ltr ? TextDirection.ltr : TextDirection.rtl,
    )..layout();

    return tp;
  }

  Size getSize(TextStyle style, {bool ltr = true}) {
    final size = _getPainter(style, ltr: ltr).size;
    // print('size $size');
    return size;
  }

  double getWidth(TextStyle style, {bool ltr = true}) => getSize(style, ltr: ltr).width;

  double getHeight(TextStyle style, {bool ltr = true}) => getSize(style, ltr: ltr).height;
}
