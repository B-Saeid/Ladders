import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Modules/Home/Widgets/home_drawer.dart';
import '../../Constants/type_def.dart';
import '../../Services/l10n/assets/l10n_resources.dart';
import '../../Services/l10n/helper_widgets.dart';
import '../../Styles/adaptive_icons.dart';
import '../../Widgets/custom_animated_size.dart';
import '../../Widgets/riverpod_helper_widgets.dart';
import '../SessionData/session_data.dart';
import 'break_points.dart';

class ResponsiveLayout extends ConsumerWidget {
  static ValueNotifier<bool> drawerHidden = ValueNotifier(false);
  final StringRef title;
  final Widget content;
  final bool endDrawer;

  const ResponsiveLayout({
    super.key,
    required this.title,
    required this.content,
    this.endDrawer = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Selector<double>(
        selector: LiveData.deviceWidthSelector,
        builder: (context, width, __) => BreakPoints.isMobile(width)
            ? _MobileLayout(content, title, endDrawer)
            : _LargeLayout(content, title, endDrawer),
      );
}

class _LargeLayout extends ConsumerWidget {
  const _LargeLayout(this.content, this.title, this.endDrawer);

  final Widget content;
  final bool endDrawer;
  final StringRef title;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              const _LargeLayoutDrawer(),
              Expanded(child: _ContentWithAppBar(content, title)),
            ],
          ),
        ),
      );
}

class _LargeLayoutDrawer extends StatelessWidget {
  const _LargeLayoutDrawer();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: ResponsiveLayout.drawerHidden,
        builder: (context, hidden, child) => CustomAnimatedSize(
          child: hidden ? const SizedBox() : child!,
        ),
        child: SizedBox(
          width: 220,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              const HomeDrawer(),
              RefWidget(
                (ref) => IconButton(
                  tooltip: L10nR.tHide(ref),
                  icon: Directionality.of(context) == TextDirection.ltr
                      ? Icon(AdaptiveIcons.arrowLeft)
                      : Icon(AdaptiveIcons.arrowRight),
                  onPressed: () => ResponsiveLayout.drawerHidden.value = true,
                ),
              ),
            ],
          ),
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
        valueListenable: ResponsiveLayout.drawerHidden,
        builder: (context, hidden, child) => hidden
            ? AppBar(
                leading: DrawerButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    ResponsiveLayout.drawerHidden.value = false;
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

class _MobileLayout extends ConsumerWidget {
  const _MobileLayout(this.content, this.title, this.endDrawer);

  final Widget content;
  final StringRef title;
  final bool endDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(title: L10nRText(title)),
        drawer: endDrawer ? null : const HomeDrawer(),
        endDrawer: endDrawer ? const HomeDrawer() : null,
        body: content,
      );
}
