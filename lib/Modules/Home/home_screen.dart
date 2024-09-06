import 'package:flutter/material.dart';

import '../../Shared/Extensions/time_package.dart';
import '../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../Shared/Styles/app_colors.dart';
import '../../Shared/Utilities/session_data.dart';
import '../../Shared/Widgets/custom_animated_size.dart';
import '../../Shared/Widgets/text_container.dart';
import 'Widgets/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10nR.tHomePageTitle)),
      drawer: const HomeDrawer(),
      body: Column(
        children: [
          CustomAnimatedSize(
            appearDelay: 1.seconds,
            origin: Alignment.bottomLeft,
            child: TextContainer(
              animated: false,
              color: AppColors.adaptiveGreen(context),
              child: Text(
                L10nR.accountCreatedSuccessfully,
                style: SessionData.textTheme.titleLarge,
              ),
            ),
          )
        ],
      ),
    );
  }
}
