import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/Routing/routes_base.dart';
import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../utilities/helper_methods.dart';

class OurDrawerBody extends ConsumerWidget {
  const OurDrawerBody({super.key});

  static List<String> titles(WidgetRef ref) => [
        // [0,3]
        L10nR.tHomePageTitle(ref).toUpperCase(),
        'MAP',
        'CHATS',
        L10nR.tSettings(ref).toUpperCase(),
        // [4-7]
        L10nR.tPrivacyPolicy(ref),
        L10nR.tTermsOfUse(ref),
        L10nR.tContactUs(ref),
        L10nR.tAbout(ref),
      ];
  static List<IconData> iconData = [
    // [0,3]
    AdaptiveIcons.home,
    AdaptiveIcons.sms,
    AdaptiveIcons.sms,
    AdaptiveIcons.settings,
    // [4-7]
    AdaptiveIcons.sms,
    AdaptiveIcons.sms,
    AdaptiveIcons.sms,
    AdaptiveIcons.info,
  ];
  static List<String> paths = [
    // [0,3]
    Routes.home.path,
    Routes.home.path,
    Routes.home.path,
    Routes.settings.path,
    // [4-7]
    Routes.home.path,
    Routes.home.path,
    Routes.home.path,
    Routes.home.path,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ...List.generate(
          4,
          (index) => _OurDrawerItem(
            title: titles(ref)[index],
            iconData: iconData[index],
            onPressed: () => regularHandler(context, index),
            selected: RoutesBase.currentRoute == paths[index],
          ),
        ),
        const Divider(height: 30),
        ...List.generate(
          4,
          (index) => _OurDrawerItem(
            title: titles(ref)[index + 4],
            iconData: iconData[index + 4],
            onPressed: () => regularHandler(context, index + 4),
            selected: RoutesBase.currentRoute == paths[index + 4],
          ),
        ),
      ],
    );
  }

  void regularHandler(
    BuildContext context,
    int index,
  ) =>
      InAppHelpers.closeDrawerThenGo(
        context,
        to: paths[index],
      );
}

class _OurDrawerItem extends StatelessWidget {
  const _OurDrawerItem({
    required this.title,
    this.iconData,
    this.selected,
    this.onPressed,
  });

  final String title;
  final IconData? iconData;
  final bool? selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ListTile(
        leading: iconData != null ? Icon(iconData) : null,
        title: Text(title),
        selected: selected ?? false,
        style: ListTileStyle.drawer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        onTap: onPressed,
      ),
    );
  }
}
