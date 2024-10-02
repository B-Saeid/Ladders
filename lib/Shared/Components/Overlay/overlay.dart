import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Extensions/time_package.dart';
import '../../Services/Routing/routes_base.dart';
import '../../Styles/adaptive_icons.dart';
import '../../Utilities/SessionData/session_data.dart';
import '../../Widgets/dialogue.dart';
import '../../Widgets/riverpod_helper_widgets.dart';

part 'parts/core_widget.dart';
part 'parts/enums.dart';
part 'parts/helper_widgets.dart';
part 'parts/logic.dart';

abstract class MyOverlay {
  /// **content** is centered inside a dimmed container.
  ///
  /// **child** is passed as it is.
  static VoidCallback showTimed({
    Widget? content,
    Widget? child,
    int? id,
    Duration duration = const Duration(seconds: 2),
    MyGravity? gravity,
    bool ignorePointer = false,
    bool dismissOnTap = false,
    MyPriority priority = MyPriority.replaceAll,
  }) {
    assert(content != null || child != null, 'Either content or child must not be null');
    _MyOverlay.showOverlay(
      child: child ?? _DimmedWrapper(content!),
      gravity: gravity,
      id: id ?? child?.hashCode ?? content!.hashCode,
      duration: duration,
      priority: priority,
      ignorePointer: ignorePointer,
      dismissOnTap: dismissOnTap,
    );
    return _MyOverlay.resetAndGoToNext;
  }

  /// This method is used to show overlay without automatic dismiss
  /// you are to handle the dismiss manually by calling the returned voidCallback
  /// or set enableDismiss to be true in order to show a close button.
  ///
  /// **content** is centered inside a dimmed container.
  ///
  /// **child** is passed as it is
  static VoidCallback show({
    Object? content,
    Widget? child,
    int? id,
    bool ignorePointer = false,
    bool dismissOnTap = false,
    bool showCloseIcon = false,
  }) {
    assert(content != null || child != null, 'Either content or child must not be null');
    assert(content is String || content is Widget, 'content must be String or Widget');
    _MyOverlay.showOverlay(
      child: child ?? _DimmedWrapper(content!, showCloseIcon: showCloseIcon),
      id: id ?? child?.hashCode ?? content!.hashCode,
      priority: MyPriority.replaceAll,
      ignorePointer: ignorePointer,
      dismissOnTap: dismissOnTap,
    );

    return _MyOverlay.resetAndGoToNext;
  }
}
