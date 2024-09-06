import 'package:flutter/material.dart';

import '../../../Shared/Extensions/time_package.dart';
import '../../../Shared/Services/Routing/routes_base.dart';

abstract class InAppHelpers {
  static void closeDrawerThenGo(BuildContext context, {required String to}) {
    Scaffold.of(context).closeDrawer();
    300.milliseconds.delay.then((_) => RoutesBase.router.go(to));
  }
}
