import 'package:flutter/material.dart';

import '../Extensions/time_package.dart';
import '../Utilities/SessionData/session_data.dart';
import 'riverpod_helper_widgets.dart';

class CupertinoWell extends StatefulWidget {
  const CupertinoWell({
    super.key,
    this.onPressed,
    required this.child,
    this.pressedColor,
    this.color,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? pressedColor;
  final Color? color;

  @override
  State<CupertinoWell> createState() => _CupertinoWellState();
}

class _CupertinoWellState extends State<CupertinoWell> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.onPressed == null
            ? null
            : () {
                setIsPressed(true);
                widget.onPressed!.call();
                100.milliseconds.delay.then((_) => setIsPressed(false));
              },
        onTapDown: (_) => widget.onPressed == null ? null : setIsPressed(true),
        onTapUp: (_) => widget.onPressed == null ? null : setIsPressed(false),
        onTapCancel: () => widget.onPressed == null ? null : setIsPressed(false),
        child: RefWidget(
          (ref) => Container(
            color:
                isPressed ? widget.pressedColor ?? LiveData.themeData(ref).highlightColor : widget.color,
            child: widget.child,
          ),
        ),
      );

  void setIsPressed(bool isPressed) {
    if (mounted) {
      setState(() => this.isPressed = isPressed);
    }
  }
}
