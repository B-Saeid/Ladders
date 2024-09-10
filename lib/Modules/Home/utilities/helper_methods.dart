import 'package:flutter/material.dart';

import '../../../Shared/Extensions/time_package.dart';
import '../../../Shared/Services/Routing/routes_base.dart';

abstract class InAppHelpers {
  static void adaptiveDrawerNavigation(BuildContext context, {required String to}) {
    if (Scaffold.of(context).hasDrawer) {
      Scaffold.of(context).closeDrawer();
      300.milliseconds.delay.then((_) => RoutesBase.router.go(to));
    } else {
      RoutesBase.router.go(to);
    }
  }
}
