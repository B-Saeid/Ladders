import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Utilities/SessionData/session_data.dart';
import 'drawer_body.dart';
import 'name_rating_card.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  static double drawerWidth(WidgetRef ref) => min(450, LiveData.deviceWidth(ref) * 0.6);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      width: drawerWidth(ref),
      child: const Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                NameRatingCard(),
                SizedBox(height: 8),
              ],
            ),
          ),
          OurDrawerBody(),
        ],
      ),
    );
  }
}
