part of '../overlay.dart';

/// internal class [_MyEntry] which maintains
/// each [OverlayEntry] and [Duration] for every overlay user
/// triggered
class _MyEntry {
  final int id;
  final OverlayEntry entry;
  final Duration? duration;
  final BoolCallback? onDismiss;

  _MyEntry({
    required this.id,
    required this.entry,
    this.duration,
    this.onDismiss,
  });
}

abstract class _MyOverlay {
  static _MyEntry? _current;
  static final List<_MyEntry> _overlayQueue = [];
  static Timer? _timer;
  static Timer? _animationTimer;
  static const Duration _animationDuration = Duration(milliseconds: 850);

  /// If any active overlay present
  /// call [removeAndGoToNext] to hide it immediately
  static void resetAndGoToNext({bool manualDismiss = false}) {
    if (manualDismiss) {
      /// TODO : try to reach hideIt function or something to avoid harsh hiding
    }

    _timer?.cancel();
    _animationTimer?.cancel();
    _timer = null;
    _animationTimer = null;

    _current?.onDismiss?.call(manualDismiss);

    /// This line harshly removes the overlay But In Case of normal behaviour - no force removal -
    /// It is hidden with animation in [_ContentWidget] before executing this line.
    _current?.entry.remove();
    _current = null;
    _showOverlay();
  }

  /// Internal function which handles the actual showing of contentWidget
  /// by adding the overlay to the screen
  ///
  static void _showOverlay() {
    /// As this method is called recursively from [[removeAndGoToNext]]
    /// It has to have a way of exiting .. and That is it,
    /// When _overlayQueue is Empty i.e. no more toasts are in the queue
    if (_overlayQueue.isEmpty) return;

    try {
      /// get the first arriving toastEntry in the queue
      final toastEntry = _overlayQueue.removeAt(0);
      _current = toastEntry;

      /// This is THE LINE that actually SHOW the overlay
      RoutesBase.globalNavigatorKey.currentState!.overlay!.insert(_current!.entry); // Line of Interest

      /// Waiting a couple period of time == the current overlay specified durations
      /// [toastEntry.duration] the showing duration +
      /// [toastEntry.fadeDuration] the duration the overlay takes to fadeOut
      ///
      /// In case of toastEntry.duration == null then no timeout will be applied
      /// instead the caller should handle the dismiss of the overlay
      /// by calling [resetAndGoToNext]
      ///
      /// however mostly this type of overlay is using [MyPriority.replaceAll]
      /// so no next would be waiting in the queue
      if (toastEntry.duration != null) {
        _timer = Timer(
          toastEntry.duration!,
          () => _animationTimer = Timer(
            _animationDuration,
            () => resetAndGoToNext(), // Removes current and go to next in queue If It has any
          ),
        );
      }
    } catch (error, stackTrace) {
      clearAllOverlays();
      print('Error While _showOverlay ${error.toString()} with ${stackTrace.toString()}');
    }
  }

  /// **FToast** - Name of inspiring package - maintains a queue for every overlay
  /// if we called showOverlay for 3 times we all to queue
  /// and show them one after another
  ///
  /// call [removeAndGoToNext] to hide the overlay immediately
  static void clearAllOverlays() {
    _timer?.cancel();
    _animationTimer?.cancel();
    _timer = null;
    _animationTimer = null;
    for (var element in _overlayQueue) {
      element.onDismiss?.call(false);
    }
    _overlayQueue.clear();
    _current?.entry.remove();
    _current = null;
  }

  /// showToast accepts all the required parameters
  /// and prepares the child i.e. Widget
  /// and calls _showOverlay to display overlay
  ///
  /// Parameter [child] is required
  /// toastDuration default is 2 seconds
  /// fadeDuration default is 350 milliseconds
  static void showOverlay({
    required Widget child,
    MyGravity? gravity,
    required int id,
    Duration? duration,
    bool ignorePointer = false,
    bool dismissOnTap = false,
    MyPriority priority = MyPriority.regular,
    BoolCallback? onDismiss,
  }) {
    /// Building the widget only
    Widget newChild = _CoreWidget(
      duration: duration,
      ignorePointer: ignorePointer,
      onDismiss: dismissOnTap ? () => resetAndGoToNext(manualDismiss: true) : null,
      gravity: gravity,
      child: child,
    );

    /// Creating an [OverlayEntry] instance
    final newEntry = OverlayEntry(builder: (_) => gravity?.positionedBuilder(newChild) ?? newChild);

    /// Embedding the [OverlayEntry] inside a _ToastEntry instance
    final myEntry = _MyEntry(
      id: id,
      entry: newEntry,
      duration: duration,
      onDismiss: onDismiss,
    );

    /// Adding our _ToastEntry to the serving queue
    switch (priority) {
      case MyPriority.regular:
        _overlayQueue.add(myEntry);
      case MyPriority.ifEmpty:
        if (_timer == null && _overlayQueue.isEmpty) _overlayQueue.add(myEntry);
      case MyPriority.noRepeat:
        if (_overlayQueue.isEmpty) {
          if (_current?.id != id) _overlayQueue.add(myEntry);
        } else {
          if (_overlayQueue.last.id != id) _overlayQueue.add(myEntry);
        }
      case MyPriority.nowNoRepeat:
        if (_overlayQueue.isEmpty) {
          if (_current?.id != id) {
            _overlayQueue.insert(0, myEntry);
            resetAndGoToNext();
          }
        } else {
          if (_overlayQueue.last.id != id) {
            _overlayQueue.insert(0, myEntry);
            resetAndGoToNext();
          }
        }
      case MyPriority.now:
        _overlayQueue.insert(0, myEntry);
        resetAndGoToNext();
      case MyPriority.replaceAll:
        _overlayQueue.clear();
        _overlayQueue.insert(0, myEntry);
        resetAndGoToNext();
    }

    /// This to check if a previous overlay is being shown
    /// If so we do nothing, But Do Not Worry,
    /// when current overlay finishes its timer will call [_showOverlay]
    /// and it will serve the first _ToastEntry in the queue until It is empty.
    /// So we are sure that our overlay will be shown As we add its _ToastEntry to the queue above.
    if (_timer == null) _showOverlay();
  }
}
