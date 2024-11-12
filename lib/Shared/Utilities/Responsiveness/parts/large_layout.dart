part of '../responsive_layout.dart';

class _LargeLayout extends ConsumerWidget {
  const _LargeLayout(
    this.content,
    this.title,
    this.endDrawer,
    this.useSafeArea,
  );

  final Widget content;
  final bool endDrawer;
  final StringRef title;
  final bool useSafeArea;
  static ValueNotifier<bool> drawerHidden = ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final row = Row(
      children: [
        const _LargeLayoutDrawer(),
        Expanded(child: _ContentWithAppBar(content, title)),
      ],
    );
    return Scaffold(
      body: useSafeArea ? SafeArea(child: row) : row,
    );
  }
}

class _LargeLayoutDrawer extends StatelessWidget {
  const _LargeLayoutDrawer();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _LargeLayout.drawerHidden,
        builder: (context, hidden, child) => CustomAnimatedSize(
          child: hidden ? const SizedBox() : child!,
        ),
        child: const SizedBox(
          width: 220,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              HomeDrawer(),
              _HideDrawerButton(),
            ],
          ),
        ),
      );
}

class _HideDrawerButton extends ConsumerWidget {
  const _HideDrawerButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 5,
        ),
        child: ActionChip(
          label: ScaleControlledText(L10nR.tHide(ref), maxFactor: 2),
          avatar: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? AdaptiveIcons.arrowLeft
                : AdaptiveIcons.arrowRight,
            size: 24.scalable(ref, maxValue: 32),
          ),
          onPressed: () => _LargeLayout.drawerHidden.value = true,
          tooltip: L10nR.tHideMenu(ref),
          visualDensity: VisualDensity.compact,
          shape: const StadiumBorder(),
        ),
      );
}

class _ContentWithAppBar extends ConsumerWidget {
  const _ContentWithAppBar(this.content, this.title);

  final Widget content;
  final StringRef title;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: _LargeLayoutAppBar(
          title: title,
        ),

        /// TODO : LEARN Shell navigation in Navigator 2.0
        body: content,
      );
}

class _LargeLayoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _LargeLayoutAppBar({
    required this.title,
  });

  final StringRef title;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _LargeLayout.drawerHidden,
        builder: (context, hidden, child) => hidden
            ? AppBar(
                leading: DrawerButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    _LargeLayout.drawerHidden.value = false;
                  },
                ),
                title: L10nRText(title),
              )
            : AppBar(
                // To prevent back button at all if drawer is persistent
                leading: const SizedBox(),
                title: L10nRText(title),
              ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
