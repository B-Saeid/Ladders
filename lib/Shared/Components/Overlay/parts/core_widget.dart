part of '../overlay.dart';

/// internal [StatefulWidget] which handles the show and hide animations.
///
class _CoreWidget extends StatefulWidget {
  const _CoreWidget({
    required this.child,
    this.duration,
    required this.ignorePointer,
    this.gravity,
    this.onDismiss,
  });

  final Widget child;
  final Duration? duration;
  final bool ignorePointer;
  final MyGravity? gravity;
  final VoidCallback? onDismiss;

  @override
  _CoreWidgetState createState() => _CoreWidgetState();
}

class _CoreWidgetState extends State<_CoreWidget> with SingleTickerProviderStateMixin {
  /// Start the showing animations for the overlay
  void showIt() => _animationController!.forward();

  /// Start the hiding animations for the overlay
  void hideIt() {
    _animationController!.reverse();
    _timer?.cancel();
  }

  /// Controller to start and hide the animation
  AnimationController? _animationController;
  late final Animation<double> _fadeAnimation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: 350.milliseconds,
      reverseDuration: 500.milliseconds,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeInOutCubicEmphasized,
    );

    showIt();
    if (widget.duration != null) _timer = Timer(widget.duration!, () => hideIt());
  }

  @override
  void deactivate() {
    _timer?.cancel();
    _animationController!.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gravity = widget.gravity;
    if (gravity != null && (gravity.isBottomSafe || gravity.isSnackBar)) {
      // SWEET Observation:
      // on both Android & iOS: When the keyboard is dismissed while the
      // overlay is shown it animates down nicely with the keyboard.
      return Consumer(
        builder: (_, ref, child) => Padding(
          padding: EdgeInsets.only(
            bottom: gravity.isBottomSafe
                ? LiveData.viewInsets(ref).bottom
                : LiveData.viewInsets(ref).bottom == 0
                    ? LiveData.viewPadding(ref).bottom
                    : LiveData.viewInsets(ref).bottom,
          ),
          child: child!,
        ),
        child: buildGestureDetector(),
      );
    } else {
      return buildGestureDetector();
    }
  }

  GestureDetector buildGestureDetector() => GestureDetector(
        onTap: widget.onDismiss,
        behavior: HitTestBehavior.translucent,
        child: IgnorePointer(
          ignoring: widget.ignorePointer,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: widget.child,
              ),
            ),
          ),
        ),
      );
}
