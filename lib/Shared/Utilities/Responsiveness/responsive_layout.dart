import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Modules/Home/Widgets/home_drawer.dart';
import '../../Constants/type_def.dart';
import '../../Services/l10n/assets/l10n_resources.dart';
import '../../Services/l10n/helper_widgets.dart';
import '../../Styles/adaptive_icons.dart';
import '../../Widgets/custom_animated_size.dart';
import '../../Widgets/riverpod_helper_widgets.dart';
import '../../Widgets/scale_controlled_text.dart';
import '../SessionData/session_data.dart';
import 'break_points.dart';

part 'parts/large_layout.dart';
part 'parts/mobile_layout.dart';

class ResponsiveLayout extends ConsumerWidget {
  final StringRef title;
  final Widget content;
  final bool endDrawer;
  final bool useSafeArea;

  const ResponsiveLayout({
    super.key,
    required this.title,
    required this.content,
    this.endDrawer = false,
    this.useSafeArea = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Selector<double>(
        selector: LiveData.deviceWidthSelector,
        builder: (context, width, __) => BreakPoints.isMobile(width)
            ? _MobileLayout(content, title, endDrawer, useSafeArea)
            : _LargeLayout(content, title, endDrawer, useSafeArea),
      );
}
