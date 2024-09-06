import 'dart:math';

import 'package:flutter/material.dart';

import '../../../Shared/Utilities/session_data.dart';
import 'drawer_body.dart';
import 'name_rating_card.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  static final double drawerWidth = min(450, SessionData.deviceWidth * 0.6);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: drawerWidth,
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
