import 'dart:async';

import 'package:flutter/material.dart';

import '../Extensions/on_connection_state.dart';
import '../Extensions/time_package.dart';

class CustomAnimatedSize extends StatelessWidget {
  static Future<bool>? show = Future.value(true);

  const CustomAnimatedSize({
    super.key,
    required this.child,
    this.duration,
    this.appearDelay,
    this.origin,
  });

  final Widget child;
  final Duration? duration;
  final Duration? appearDelay;
  final Alignment? origin;

  @override
  Widget build(BuildContext context) {
    if (appearDelay == null) {
      return buildAnimatedSize(child);
    } else {
      return buildAnimatedSize(
        FutureBuilder(
          future: appearDelay!.delay,
          builder: (context, snapshot) => !snapshot.connectionState.isDone ? const SizedBox() : child,
        ),
      );
    }
  }

  AnimatedSize buildAnimatedSize(Widget child) {
    return AnimatedSize(
      duration: duration ?? const Duration(seconds: 1),
      curve: Curves.easeInOutCubicEmphasized,
      alignment: origin ?? Alignment.topCenter,
      child: child,
    );
  }
}
