import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../Shared/Services/l10n/helper_widgets.dart';
import '../../Shared/Utilities/Responsiveness/break_points.dart';
import '../../Shared/Utilities/SessionData/session_data.dart';
import '../../Shared/Widgets/riverpod_helper_widgets.dart';
import 'Widgets/home_content.dart';
import 'Widgets/home_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Selector<double>(
        selector: LiveData.deviceWidthSelector(ref),
        builder: (context, width, __) =>
            BreakPoints.isMobile(width) ? const _MobileLayout() : const _LargeLayout(),
      );
}

class _LargeLayout extends ConsumerWidget {
  const _LargeLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) => const Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              SizedBox(width: 220, child: HomeDrawer()),
              Expanded(child: _HomeContentWithAppBar()),
            ],
          ),
        ),
      );
}

class _HomeContentWithAppBar extends ConsumerWidget {
  const _HomeContentWithAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(title: const L10nRText(L10nR.tHomePageTitle)),
        body: const HomeContent(),
      );
}

class _MobileLayout extends ConsumerWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(title: const L10nRText(L10nR.tHomePageTitle)),
        drawer: const HomeDrawer(),
        body: const HomeContent(),
      );
}
