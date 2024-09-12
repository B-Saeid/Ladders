import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Shared/Constants/global_constants.dart';
import '../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../Shared/Utilities/Responsiveness/responsive_layout.dart';
import '../../Shared/Widgets/bottom_padding.dart';
import 'Widgets/actions_buttons.dart';
import 'Widgets/inner_go_rest.dart';
import 'Widgets/timer_scroll_wheels.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const ResponsiveLayout(
        title: L10nR.tHomePageTitle,
        content: _HomeContent(),
      );
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) => const Center(
        child: Padding(
          padding: GlobalConstants.screensHPadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LadderTimerScrollWheels(),
                InnerGoRestCycles(),
                StartAbortButton(),
                BottomPadding()
              ],
            ),
          ),
        ),
      );
}
