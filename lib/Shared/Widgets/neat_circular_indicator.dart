import 'package:flutter/material.dart';

class NeatCircularIndicator extends StatelessWidget {
  const NeatCircularIndicator({super.key, this.value});

  final double? value;

  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.scaleDown,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 2,
          strokeCap: StrokeCap.round,
          value: value,
        ),
      );
}
