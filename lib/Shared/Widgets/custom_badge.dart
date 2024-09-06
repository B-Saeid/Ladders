import 'package:flutter/material.dart';

import '../Styles/app_colors.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.child,
    required this.label,
    this.backgroundColor,
    this.comfort = true,
    this.textColor,
    this.offset,
    this.alignment,
  }) : assert(label is Widget || label is String);

  final Widget child;
  final Object label;
  final Color? backgroundColor;
  final bool comfort;
  final Color? textColor;
  final Offset? offset;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: label is String ? Text(label as String) : label as Widget,
      backgroundColor: backgroundColor ?? (comfort ? AppColors.primary : null),
      offset: offset ?? const Offset(0, -5),
      alignment: alignment ?? Alignment.topLeft,
      child: child,
    );
  }
}
