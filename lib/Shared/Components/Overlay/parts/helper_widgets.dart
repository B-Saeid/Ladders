part of '../overlay.dart';

class _DimmedWrapper extends StatelessWidget {
  const _DimmedWrapper(
    this.child, {
    this.showCloseIcon = false,
  });

  final Object child;
  final bool showCloseIcon;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => RefWidget(
          (ref) => Container(
            color: Colors.black87.withOpacity(0.8),
            width: LiveData.deviceWidth(ref),
            height: LiveData.deviceHeight(ref),
            child: Stack(
              alignment: Alignment.center,
              children: [
                MyDialogue(title: child),
                if (showCloseIcon) const _DismissIconButton(),
              ],
            ),
          ),
        ),
      );
}

class _DismissIconButton extends ConsumerWidget {
  const _DismissIconButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final direction = Directionality.of(context);
    final viewPadding = LiveData.viewPadding(ref);
    final baseEndPadding = direction == TextDirection.ltr ? viewPadding.right : viewPadding.left;
    return Positioned.directional(
      textDirection: direction,
      top: viewPadding.top + 10,
      end: baseEndPadding + 10,
      child: IconButton.filledTonal(
        onPressed: _MyOverlay.resetAndGoToNext,
        icon: Icon(AdaptiveIcons.close),
      ),
    );
  }
}
