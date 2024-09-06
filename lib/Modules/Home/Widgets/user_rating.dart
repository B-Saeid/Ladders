import 'package:flutter/material.dart';

import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Styles/app_colors.dart';

class UserRating extends StatelessWidget {
  const UserRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AdaptiveIcons.star,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          const Text(
            '- / 5',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          // Icon(
          //   AdaptiveIcons.info,
          //   color: AppColors.primary.withAlpha(150),
          // )
        ],
      ),
    );
  }
}
