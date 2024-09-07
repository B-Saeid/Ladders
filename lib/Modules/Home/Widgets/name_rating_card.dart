import 'package:flutter/material.dart';

import '../../../Shared/Constants/assets_strings.dart';
import '../../../Shared/Services/Routing/routes_base.dart';
import '../../../Shared/Styles/app_colors.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/card_well.dart';
import '../../../Shared/Widgets/profile_avatar.dart';
import '../../../Shared/Widgets/riverpod_helper_widgets.dart';
import '../utilities/helper_methods.dart';

class NameRatingCard extends StatelessWidget {
  const NameRatingCard({super.key});

  /// TODO: To AVOID
  /// This caused a bug that a user name is cached even after signing the user out
  /// This is VERY BAD and should be avoided
  /// TODO : Conclusion
  /// USE [static] on any class when you want it to stay unchanged during the
  /// lifecycle of the APP not the widget in this case [StatelessWidget].
  /// But in here when you use a GETTER and it is called within the build method
  /// so if the build method is called again the getter will reevaluate the value.
  // static final String name = HiveService.userVolt.get(BaseUser.mName);

  @override
  Widget build(BuildContext context) {
    return CardWell(
      onPressed: () => InAppHelpers.closeDrawerThenGo(
        context,
        to: Routes.account.path,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            RefWidget(
              (ref) => ProfileHero(
                radius: LiveData.deviceWidth(ref) * 0.08,

                /// TODO :fix this png and it is recommended to go for SVG
                path: ImageAssets.defaultProfileAvatar,
                backgroundColor: AppColors.scaffoldBackground(ref),
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'name',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
