import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Extensions/time_package.dart';

class LottieControlled extends StatefulWidget {
  const LottieControlled({
    super.key,
    required this.asset,
    required this.duration,
    this.startAfter = Duration.zero,
    this.stopAfter = const Duration(seconds: 3),
  });

  final String asset;
  final Duration duration;
  final Duration startAfter;
  final Duration stopAfter;

  @override
  State<LottieControlled> createState() => _LottieControlledState();
}

class _LottieControlledState extends State<LottieControlled> with SingleTickerProviderStateMixin {
  late AnimationController? _controller;

  AnimationController? get controller => _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    controlAnimation();
  }

  Future<void> controlAnimation() async {
    await widget.startAfter.delay;
    controller?.forward();
    await widget.stopAfter.delay;
    controller?.stop();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.asset,
      controller: controller,
    );
  }
}
