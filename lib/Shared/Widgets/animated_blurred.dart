import 'dart:ui';

import 'package:flutter/material.dart';

import '../Extensions/time_package.dart';

class AnimatedBlurred extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Future? awaitedFuture;
  final Duration? appearDelay;
  final Curve? curve;

  const AnimatedBlurred({
    super.key,
    required this.child,
    this.duration,
    this.awaitedFuture,
    this.appearDelay,
    this.curve,
  }) : assert(
          awaitedFuture == null || appearDelay == null,
          'Either awaitedFuture or appearDelay should be null',
        );

  @override
  State<AnimatedBlurred> createState() => _AnimatedBlurredState();
}

class _AnimatedBlurredState extends State<AnimatedBlurred> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  late final Animation<double> _tweenAnimation = _tween.animate(
    CurvedAnimation(
      parent: controller,
      curve: widget.curve ?? Curves.fastOutSlowIn,
    ),
  );

  late final Tween<double> _tween = Tween<double>(begin: 100, end: 0);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? 1.seconds,
    );
    if (widget.awaitedFuture != null || widget.appearDelay != null) {
      final Future future = widget.awaitedFuture ?? widget.appearDelay!.delay;
      future.then((value) => animate());
    } else {
      animate();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void animate() => controller.forward();

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _tweenAnimation,
        builder: (BuildContext context, Widget? child) => ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: _tweenAnimation.value,
            sigmaY: _tweenAnimation.value,
          ),
          child: child!,
        ),
        child: widget.child,
      );

  /// You can use this without the overhead of the StatefulWidget, AnimatedBuilder,
  /// AnimationController but It does not over control over the animation
  /// it just animates when It is build ... may reanimate on every build
// @override
// Widget build(BuildContext context) => TweenAnimationBuilder(
//       tween: _tween,
//       duration: widget.duration ?? 3.seconds,
//       curve: widget.curve ?? Curves.easeInOutCubicEmphasized,
//       builder: (BuildContext context, double value, Widget? child) => ImageFiltered(
//         imageFilter: ImageFilter.blur(
//           sigmaX: value,
//           sigmaY: value,
//         ),
//         child: child!,
//       ),
//       child: widget.child,
//     );
}
