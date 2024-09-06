part of 'toast.dart';

abstract class _ToastPackage {
  static _ToastEntry? _current;
  static final List<_ToastEntry> _overlayQueue = [];
  static Timer? _timer;
  static Timer? _animationTimer;
  static const Duration _animationDuration = Duration(milliseconds: 850);

  /// If any active toast present
  /// call removeCustomToast to hide the toast immediately
  static void resetAndGoToNext() {
    _timer?.cancel();
    _animationTimer?.cancel();
    _timer = null;
    _animationTimer = null;

    /// This line harshly removes the toast But In Case of normal behaviour - no force removal -
    /// It is hidden with animation in [_ToastWidget] before executing this line.
    _current?.entry.remove();
    _current = null;
    _showOverlay();
  }

  /// Internal function which handles the actual showing of toast
  /// by adding the overlay to the screen
  ///
  static void _showOverlay() {
    /// As this method is called recursively from [removeCustomToast]
    /// It has to have a way of exiting .. and That is it,
    /// When _overlayQueue is Empty i.e. no more toasts are in the queue
    if (_overlayQueue.isEmpty) return;

    try {
      /// get the first arriving toastEntry in the queue
      final toastEntry = _overlayQueue.removeAt(0);
      _current = toastEntry;

      /// This is THE LINE that actually SHOW the toast
      RoutesBase.globalNavigatorKey.currentState!.overlay!.insert(_current!.entry); // Line of Interest

      /// Waiting a couple period of time == the current toast specified durations
      /// [toastEntry.duration] the showing duration
      /// [toastEntry.fadeDuration] the duration the toast takes to fadeOut
      _timer = Timer(
        toastEntry.duration,
        () => _animationTimer = Timer(
          _animationDuration,
          () => resetAndGoToNext(), // Removes current and go to next in queue If It has any
        ),
      );
    } catch (error, stackTrace) {
      clearAllToasts();
      print('Error While _showOverlay ${error.toString()} with ${stackTrace.toString()}');
    }
  }

  /// FToast maintains a queue for every toast
  /// if we called showToast for 3 times we all to queue
  /// and show them one after another
  ///
  /// call removeCustomToast to hide the toast immediately
  static void clearAllToasts() {
    _timer?.cancel();
    _animationTimer?.cancel();
    _timer = null;
    _animationTimer = null;
    _overlayQueue.clear();
    _current?.entry.remove();
    _current = null;
  }

  /// showToast accepts all the required parameters
  /// and prepares the child i.e. Widget
  /// and calls _showOverlay to display toast
  ///
  /// Parameter [child] is required
  /// toastDuration default is 2 seconds
  /// fadeDuration default is 350 milliseconds
  static void showToast({
    required Widget child,
    required ToastGravity gravity,
    Duration duration = const Duration(seconds: 2),
    bool ignorePointer = false,
    bool dismissOnTap = false,
    ToastPriority priority = ToastPriority.regular,
    required int id,
  }) {
    /// Building the widget only
    Widget newChild = _ToastWidget(
      duration: duration,
      ignorePointer: ignorePointer,
      onDismiss: dismissOnTap ? resetAndGoToNext : null,
      gravity: gravity,
      child: child,
    );

    /// Creating an [OverlayEntry] instance
    final newEntry = OverlayEntry(builder: (_) => gravity.positionedBuilder(newChild));

    /// Embedding the [OverlayEntry] inside a _ToastEntry instance
    final toastEntry = _ToastEntry(
      id: id,
      entry: newEntry,
      duration: duration,
    );

    /// Adding our _ToastEntry to the serving queue
    switch (priority) {
      case ToastPriority.regular:
        _overlayQueue.add(toastEntry);
      case ToastPriority.ifEmpty:
        if (_timer == null && _overlayQueue.isEmpty) _overlayQueue.add(toastEntry);
      case ToastPriority.noRepeat:
        if (_overlayQueue.isEmpty) {
          if (_current?.id != id) _overlayQueue.add(toastEntry);
        } else {
          if (_overlayQueue.last.id != id) _overlayQueue.add(toastEntry);
        }
      case ToastPriority.nowNoRepeat:
        if (_overlayQueue.isEmpty) {
          if (_current?.id != id) {
            _overlayQueue.insert(0, toastEntry);
            resetAndGoToNext();
          }
        } else {
          if (_overlayQueue.last.id != id) {
            _overlayQueue.insert(0, toastEntry);
            resetAndGoToNext();
          }
        }
      case ToastPriority.now:
        _overlayQueue.insert(0, toastEntry);
        resetAndGoToNext();
      case ToastPriority.replaceAll:
        _overlayQueue.clear();
        _overlayQueue.insert(0, toastEntry);
        resetAndGoToNext();
    }

    /// This to check if a previous toast is being shown
    /// If so we do nothing, But Do Not Worry,
    /// when current toast finishes its timer will call [_showOverlay]
    /// and it will serve the first _ToastEntry in the queue until It is empty.
    /// So we are sure that our toast will be shown As we add its _ToastEntry to the queue above.
    if (_timer == null) _showOverlay();
  }
}

/// internal class [_ToastEntry] which maintains
/// each [OverlayEntry] and [Duration] for every toast user
/// triggered
class _ToastEntry {
  final int id;
  final OverlayEntry entry;
  final Duration duration;

  _ToastEntry({
    required this.id,
    required this.entry,
    required this.duration,
  });
}

/// internal [StatefulWidget] which handles the show and hide animations.
class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.child,
    required this.duration,
    required this.ignorePointer,
    required this.gravity,
    this.onDismiss,
  });

  final Widget child;
  final Duration duration;
  final bool ignorePointer;
  final ToastGravity gravity;
  final VoidCallback? onDismiss;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  /// Start the showing animations for the toast
  void showIt() => _animationController!.forward();

  /// Start the hiding animations for the toast
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
    _timer = Timer(widget.duration, () => hideIt());
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
    if (widget.gravity.isBottomSafe || widget.gravity.isSnackBar) {
      // SWEET Observation:
      // on both Android & iOS: When the keyboard is dismissed while the
      // toast is shown it animates down nicely with the keyboard.
      return ValueListenableBuilder(
        valueListenable: SessionData.viewInsetsListenable,
        builder: (_, currentViewInsets, child) => Padding(
          padding: EdgeInsets.only(
            bottom: widget.gravity.isBottomSafe
                ? currentViewInsets.bottom
                : currentViewInsets.bottom == 0
                    ? SessionData.viewPadding.bottom
                    : currentViewInsets.bottom,
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

enum ToastGravity {
  top,
  bottomSafe,
  center,
  snackBar;

  bool get isBottomSafe => this == ToastGravity.bottomSafe;

  bool get isSnackBar => this == ToastGravity.snackBar;

  Widget positionedBuilder(Widget child) => switch (this) {
        ToastGravity.top => Positioned(
            top: 100.0,
            left: 16.0,
            right: 16.0,
            child: child,
          ),
        ToastGravity.center => Positioned(
            top: 50.0,
            bottom: 50.0,
            left: 16.0,
            right: 16.0,
            child: child,
          ),

        /// SHOWING TOAST BEHIND Keyboard BUG FIXED
        /// This was Copied from the orig package
        // Check for keyboard open
        //             /// If open will ignore the gravity bottom and change it to center
        //             if (gravity == ToastGravity.BOTTOM) {
        //           if (MediaQuery.of(context!).viewInsets.bottom != 0) {
        //             gravity = ToastGravity.CENTER;
        //           }
        //         }
        /// However sometimes it works and sometimes it does not
        /// and we Already discussed the cause of this bug but to recap
        /// when MediaQuery.of(context) is called from some deeply nested widget
        /// especially in build methods with const widgets it may not reflect current values.
        /// So we use here our [SessionData] ValueListenables as we use the context of the root app
        /// to keep it updated so no chance In Sha' Allah for anything to go wrong.
        ToastGravity.bottomSafe => Positioned(
            // this 50.0 is the default space used by the plugin when
            // [ToastGravity.BOTTOM] is used.
            bottom: /* This is handled in the widget /// SessionData.viewInsets.bottom + */ 50.0,
            left: 16.0,
            right: 16.0,
            child: child,
          ),
        ToastGravity.snackBar => Positioned(
            bottom: 0,
            left: 16.0,
            right: 16.0,
            child: child,
          ),
      };
}
