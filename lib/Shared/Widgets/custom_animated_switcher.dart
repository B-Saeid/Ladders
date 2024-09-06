import 'dart:async';

import 'package:flutter/material.dart';

import '../Extensions/on_connection_state.dart';
import '../Extensions/time_package.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  static Future<bool>? show = Future.value(true);

  const CustomAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration,
    this.appearDelay,
  });

  final Widget child;
  final Duration? duration;
  final Duration? appearDelay;

  @override
  Widget build(BuildContext context) {
    if (appearDelay == null) {
      return buildAnimatedSwitcher(child);
    } else {
      return buildAnimatedSwitcher(
        FutureBuilder(
          future: appearDelay!.delay,
          builder: (context, snapshot) => !snapshot.connectionState.isDone ? const SizedBox() : child,
        ),
      );
    }
  }

  AnimatedSwitcher buildAnimatedSwitcher(Widget child) {
    return AnimatedSwitcher(
      duration: duration ?? const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOutCubicEmphasized,
      switchOutCurve: Curves.easeInOutCubic,
      child: child,
    );
  }
}
