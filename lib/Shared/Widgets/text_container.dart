import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Styles/app_colors.dart';

class TextContainer extends ConsumerWidget {
  const TextContainer({
    super.key,
    required this.child,
    this.color,
    this.animated = false,
    this.onTap,
    this.padding,
    this.margin,
  });

  final Widget child;
  final Color? color;
  final bool animated;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final container = animated
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            margin: margin ?? const EdgeInsets.symmetric(horizontal: 15),
            padding: padding ?? const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: color ?? AppColors.adaptiveGrey(ref),
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
              child: child,
            ),
          )
        : Container(
            margin: margin ?? const EdgeInsets.symmetric(horizontal: 15),
            padding: padding ?? const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: color ?? AppColors.adaptiveGrey(ref),
            ),
            child: child,
          );
    return onTap == null
        ? container
        : ActionChip.elevated(
            onPressed: onTap,
            label: child,
            padding: padding,
          );
  }
}
