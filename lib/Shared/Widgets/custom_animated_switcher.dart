import 'dart:async';

import 'package:flutter/material.dart';

import '../Extensions/on_connection_state.dart';
import '../Extensions/time_package.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  static Future<bool>? show = Future.value(true);

  const CustomAnimatedSwitcher({
    super.key,
    required this.child,
    this.scaleTransition = true,
    this.duration,
    this.appearDelay,
  });

  final Widget child;

  /// If false it will default to Fade Transition
  final bool scaleTransition;
  final Duration? duration;
  final Duration? appearDelay;

  @override
  Widget build(BuildContext context) =>
      appearDelay == null
      ? buildAnimatedSwitcher(child)
      : buildAnimatedSwitcher(
          FutureBuilder(
            future: appearDelay!.delay,
            builder: (context, snapshot) => !snapshot.connectionState.isDone ? const SizedBox() : child,
          ),
        );

  AnimatedSwitcher buildAnimatedSwitcher(Widget child) => AnimatedSwitcher(
        duration: duration ?? const Duration(milliseconds: 500),
        transitionBuilder: scaleTransition
            ? (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                )
            : AnimatedSwitcher.defaultTransitionBuilder,
        switchInCurve: Curves.easeInOutCubicEmphasized,
        switchOutCurve: Curves.easeInOutCubic,
        child: child,
      );
}
