import 'package:flutter/material.dart';

class CardWell extends StatelessWidget {
  const CardWell({super.key, required this.child, required this.onPressed, this.shape});

  final Widget child;
  final ShapeBorder? shape;
  final VoidCallback onPressed;

  BorderRadius get borderRadius12 => BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
            side: const BorderSide(width: 0.2),
            borderRadius: borderRadius12,
          ),
      child: InkWell(
        borderRadius: borderRadius12,
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
