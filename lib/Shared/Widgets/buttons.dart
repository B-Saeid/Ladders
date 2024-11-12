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
        child: Stack(
          children: [
            Visibility.maintain(
              visible: !(loadingIndicator ?? false),
              child: IgnorePointer(
                ignoring: loadingIndicator ?? false,
                child: determineChild(onPressed),
              ),
            ),
            Positioned.fill(
              child: Visibility(
                visible: loadingIndicator ?? false,
                child: const NeatCircularIndicator(),
              ),
            ),
          ],
        ),
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
    final isApple = StaticData.platform.isApple;
    final textPart = FittedBox(
      child: child is String ? Text(child as String, style: textStyle) : child as Widget,
    );
    final iconPart = RefWidget((ref) => SizedBox(
          width: 32.scalable(ref, maxValue: 50),
          height: 32.scalable(ref, maxValue: 50),
          child: FittedBox(child: icon),
        ));
    final zChild = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: childHeight,
        child: textPart,
      ),
    );
    if (isApple) {
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
          width: 32.scalable(ref, maxValue: 50),
          height: 32.scalable(ref, maxValue: 50),
          child: FittedBox(child: icon),
        ));

    final zChild = Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: iconExists ? 0 : 12,
            vertical: 10,
          ),
      child: RefWidget((ref) => SizedBox(
            height: (childHeight ?? 28).scalable(ref),
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
