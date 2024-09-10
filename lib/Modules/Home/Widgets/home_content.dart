import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Constants/global_constants.dart';
import '../../../Shared/Widgets/bottom_padding.dart';
import 'inner_go_rest.dart';
import 'timer_scroll_wheels.dart';
import 'actions_buttons.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

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
