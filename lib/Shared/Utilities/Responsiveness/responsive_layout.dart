import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Modules/Home/Widgets/home_drawer.dart';
import '../../Services/l10n/helper_widgets.dart';
import '../../Widgets/riverpod_helper_widgets.dart';
import '../SessionData/session_data.dart';
import 'break_points.dart';

class ResponsiveLayout extends ConsumerWidget {
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
        selector: LiveData.deviceWidthSelector(ref),
        builder: (context, width, __) => BreakPoints.isMobile(width)
            ? _MobileLayout(content, title, endDrawer)
            : _LargeLayout(content, title),
      );
}

class _LargeLayout extends ConsumerWidget {
  const _LargeLayout(this.content, this.title);

  final Widget content;
  final StringRef title;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              const SizedBox(width: 220, child: HomeDrawer()),
              Expanded(child: _ContentWithAppBar(content, title)),
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
        appBar: AppBar(title: L10nRText(title)),
        body: content,
      );
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
