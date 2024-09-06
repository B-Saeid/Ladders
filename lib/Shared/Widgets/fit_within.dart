import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FitWithin extends StatelessWidget {
  const FitWithin({
    super.key,
    required this.child,
    required this.size,
    this.boxFit = BoxFit.contain,
    this.alignment = AlignmentDirectional.centerStart,
  });

  final Widget child;
  final Size size;
  final BoxFit boxFit;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(size),
      child: FittedBox(
        fit: boxFit,
        alignment: alignment,
        child: child,
      ),
    );
  }
}
