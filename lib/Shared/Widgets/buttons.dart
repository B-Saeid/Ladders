import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utilities/SessionData/session_data.dart';
import 'neat_circular_indicator.dart';
import 'riverpod_helper_widgets.dart';

enum CustomButtonType { filled, outlined, text, elevated }

class CustomButton extends StatelessWidget {
  final bool adaptive;
  final Object child;
  final VoidCallback? onPressed;

  // final bool requireInternet;
  final bool actionable;
  final bool? hidden;

  // final bool? crystal;
  final bool? loadingIndicator;
  final CustomButtonType type;
  final TextStyle? textStyle;
  final double? childHeight;
  final double? width;
  final Widget? icon;
  final IconAlignment iconAlignment;
  final Color? color;
  final EdgeInsets? padding;
  final VoidCallback? onLongPressed;

  const CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
    // this.requireInternet = false,
    this.actionable = true,
    this.hidden,
    // this.crystal,
    this.loadingIndicator,
    this.type = CustomButtonType.filled,
    this.textStyle,
    this.childHeight,
    this.width,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.color,
    this.padding,
    this.onLongPressed,
  })  : adaptive = false,
        assert(child is String || child is Widget);

  const CustomButton.adaptive({
    super.key,
    required this.child,
    required this.onPressed,
    // this.requireInternet = false,
    this.actionable = true,
    this.hidden,
    // this.crystal,
    this.loadingIndicator,
    this.type = CustomButtonType.filled,
    this.textStyle,
    this.childHeight,
    this.width,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.color,
    this.padding,
    this.onLongPressed,
  })  : adaptive = true,
        assert(child is String || child is Widget);

  bool get iconExists => icon != null;

  @override
  Widget build(BuildContext context) {
    /// Priority Order regarding button wrappers
    // hidden or not ... i.e. if hidden != null
    // we have to wrap with opacity to hide and show according to hidden bool
    /// and then regarding onPressed
    // actionable
    // requireInternet

    // Important note in here when actionable is set to false
    // onPressed will also be null regardless of requireInternet bool
    // as actionable is setting the onPressed at the very start
    // of the build method to take effect in any case which
    // satisfies the top priority for the actionable flag
    final onPressed = actionable ? this.onPressed : null;

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInCubic,
      child: SizedBox(
        width: width,
        child: loadingIndicator ?? false ? const NeatCircularIndicator() : determineChild(onPressed),
      ),
    );
  }

  // ValueListenableBuilder<bool> _internetListenerWrapper(VoidCallback? onPressed) =>
  //     ValueListenableBuilder(
  //       valueListenable: Internet.statusNotifier,
  //       builder: (context, connected, _) => determineChild(connected ? onPressed : null),
  //     );

  Widget determineChild(VoidCallback? onPressed) {
    // final shouldCallOpacityWrapper = crystal != null;
    final mustCallOpacityWrapper = hidden != null;

    if (mustCallOpacityWrapper) {
      final button = determineButton(onPressed);
      return _opacityWrapper(button);
    } else {
      return determineButton(onPressed);
    }
  }

  Widget determineButton(VoidCallback? onPressed) =>
      adaptive ? _buildAdaptiveButton(onPressed) : _buildCustomButton(onPressed);

  Widget _buildAdaptiveButton(VoidCallback? callToAction) {
    final isIOS = Platform.isIOS;
    final textPart = FittedBox(
      child: child is String ? Text(child as String, style: textStyle) : child as Widget,
    );
    final iconPart = RefWidget((ref) => SizedBox(
          width: LiveData.getScaledValue(ref, baseValue: 32, maxValue: 50),
          height: LiveData.getScaledValue(ref, baseValue: 32, maxValue: 50),
          child: FittedBox(child: icon),
        ));
    final zChild = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: childHeight,
        child: textPart,
      ),
    );
    if (isIOS) {
      if (color != null) {
        return CupertinoButton(onPressed: callToAction, color: color, child: zChild);
      }
      if ([CustomButtonType.elevated, CustomButtonType.filled].contains(type)) {
        return CupertinoButton.filled(onPressed: callToAction, child: zChild);
      }
      if (type == CustomButtonType.text) {
        return CupertinoButton(onPressed: callToAction, child: zChild);
      }
    }
    return switch (type) {
      CustomButtonType.filled => iconExists
          ? FilledButton.icon(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              icon: iconPart,
              iconAlignment: iconAlignment,
              label: zChild,
            )
          : FilledButton(onPressed: callToAction, onLongPress: onLongPressed, child: zChild),
      CustomButtonType.outlined => iconExists
          ? OutlinedButton.icon(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              icon: iconPart,
              iconAlignment: iconAlignment,
              label: zChild,
            )
          : OutlinedButton(onPressed: callToAction, onLongPress: onLongPressed, child: zChild),
      CustomButtonType.text => iconExists
          ? TextButton.icon(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              icon: iconPart,
              iconAlignment: iconAlignment,
              label: zChild,
            )
          : TextButton(onPressed: callToAction, onLongPress: onLongPressed, child: zChild),
      CustomButtonType.elevated => iconExists
          ? ElevatedButton.icon(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              icon: iconPart,
              iconAlignment: iconAlignment,
              label: zChild,
            )
          : ElevatedButton(onPressed: callToAction, onLongPress: onLongPressed, child: zChild),
    };
  }

  Widget _buildCustomButton(VoidCallback? callToAction) {
    final textPart = FittedBox(
      child: child is String ? Text(child as String, style: textStyle) : child as Widget,
    );

    final iconPart = RefWidget((ref) => SizedBox(
          width: LiveData.getScaledValue(ref, baseValue: 32, maxValue: 50),
          height: LiveData.getScaledValue(ref, baseValue: 32, maxValue: 50),
          child: FittedBox(child: icon),
        ));

    final zChild = Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: RefWidget((ref) => SizedBox(
            height: LiveData.getScaledValue(ref, baseValue: childHeight ?? 28),
            child: textPart,
          )),
    );

    final filledStyle = FilledButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
    final outlinedStyle = OutlinedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
    return switch (type) {
      CustomButtonType.filled => iconExists
          ? FilledButton.icon(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              icon: iconPart,
              iconAlignment: iconAlignment,
              label: zChild,
              style: filledStyle,
            )
          : FilledButton(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              style: filledStyle,
              child: zChild,
            ),
      CustomButtonType.outlined => iconExists
          ? OutlinedButton.icon(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              style: outlinedStyle,
              icon: iconPart,
              iconAlignment: iconAlignment,
              label: zChild,
            )
          : OutlinedButton(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              style: outlinedStyle,
              child: zChild,
            ),

      /// TODO : LATER >>> Text AND Elevated ARE NOT CUSTOMIZED YET
      CustomButtonType.text => icon == null
          ? TextButton(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              child: zChild,
            )
          : TextButton.icon(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              icon: icon!,
              iconAlignment: iconAlignment,
              label: zChild,
            ),
      CustomButtonType.elevated => icon == null
          ? ElevatedButton(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              child: zChild,
            )
          : ElevatedButton.icon(
              onPressed: callToAction,
              onLongPress: onLongPressed,
              icon: icon!,
              iconAlignment: iconAlignment,
              label: zChild,
            ),
    };
  }

  Widget _opacityWrapper(Widget button) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
      opacity: hidden ?? false ? 0 : 1,
      child: button,
    );
  }
}

// class PickUpButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final VoidCallback? onLongPressed;
//   final Object child;
//   final Color? color;
//   final Widget? icon;
//   final double? width;
//   final bool? isOutline;
//
//   const PickUpButton(
//       {Key? key,
//         required this.onPressed,
//         required this.child,
//         this.color,
//         this.icon,
//         this.width,
//         this.isOutline,
//         this.onLongPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(width: width ?? double.infinity, child: determineChild(context: context));
//   }
//
//   Widget determineChild({required BuildContext context}) {
//     var defaultColor = Theme.of(context).colorScheme.primary;
//
//     if (isOutline == null) {
//       return icon == null
//           ? ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             shape: const StadiumBorder(), elevation: 3, backgroundColor: color ?? defaultColor),
//         onPressed: onPressed,
//         onLongPress: onLongPressed,
//         child: Padding(
//             padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 8),
//             child: child.runtimeType == String
//                 ? Text(child as String, style: Theme.of(context).textTheme.titleLarge)
//                 : child as Widget),
//       )
//           : ElevatedButton.icon(
//         style: ElevatedButton.styleFrom(
//             shape: const StadiumBorder(), elevation: 3, backgroundColor: color ?? defaultColor),
//         onPressed: onPressed,
//         onLongPress: onLongPressed,
//         icon: icon!,
//         label: Padding(
//             padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 8),
//             child: child.runtimeType == String
//                 ? Text(child as String, style: Theme.of(context).textTheme.titleLarge)
//                 : child as Widget),
//       );
//     } else {
//       return icon == null
//           ? OutlinedButton(
//         style: OutlinedButton.styleFrom(
//             shape: const StadiumBorder(), side: BorderSide(color: color ?? defaultColor)),
//         onPressed: onPressed,
//         onLongPress: onLongPressed,
//         child: Padding(
//             padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 8),
//             child: child.runtimeType == String
//                 ? Text(child as String, style: Theme.of(context).textTheme.titleLarge)
//                 : child as Widget),
//       )
//           : OutlinedButton.icon(
//         style: OutlinedButton.styleFrom(
//             shape: const StadiumBorder(), side: BorderSide(color: color ?? defaultColor)),
//         onPressed: onPressed,
//         onLongPress: onLongPressed,
//         icon: icon!,
//         label: Padding(
//             padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 8),
//             child: child.runtimeType == String
//                 ? Text(child as String, style: Theme.of(context).textTheme.titleLarge)
//                 : child as Widget),
//       );
//     }
//   }
// }
//
// class PickUpTextButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String child;
//
//   const PickUpTextButton({
//     Key? key,
//     required this.onPressed,
//     required this.child,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//           textStyle: const TextStyle(
//             fontWeight: FontWeight.bold,
//           )),
//       onPressed: onPressed,
//       child: Text(child),
//     );
//   }
// }
// Widget appButton({
//   double minWidth = 150,
//   double height = 50,
//   required VoidCallback? onPressed,
//   required Widget child,
// }) {
//   return MaterialButton(
//     minWidth: minWidth,
//     height: 50,
//     disabledColor: Colors.grey[300],
//     color: pickUpThemeColor,
//     splashColor: pickUpThemeColor[400],
//     shape: const StadiumBorder(),
//     elevation: 3,
//     onPressed: onPressed,
//     child: child,
//   );
// }
