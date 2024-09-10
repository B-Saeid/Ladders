import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Services/Routing/routes_base.dart';
import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../utilities/helper_methods.dart';
import 'name_rating_card.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SizedBox(
        width: 220,
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: NameAndImage(),
                ),
              ),
              _DrawerBody(),
            ],
          ),
        ),
      );
}

class _DrawerBody extends ConsumerWidget {
  const _DrawerBody();

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
  Widget build(BuildContext context, WidgetRef ref) => Expanded(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _OurDrawerItem(
                  title: titles(ref)[index],
                  iconData: iconData[index],
                  onPressed: () => onTileTapped(context, index),
                  selected: RoutesBase.currentRoute == paths[index],
                ),
                childCount: 4,
              ),
            ),
            const SliverToBoxAdapter(child: Divider(height: 20)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _OurDrawerItem(
                  title: titles(ref)[index + 4],
                  iconData: iconData[index + 4],
                  onPressed: () => onTileTapped(context, index + 4),
                  selected: RoutesBase.currentRoute == paths[index + 4],
                ),
                childCount: 4,
              ),
            ),
          ],
        ),
      );

  void onTileTapped(
    BuildContext context,
    int index,
  ) =>
      InAppHelpers.adaptiveDrawerNavigation(
        context,
        to: paths[index],
      );
}

class _OurDrawerItem extends ConsumerWidget {
  const _OurDrawerItem({
    required this.title,
    required this.iconData,
    this.selected,
    this.onPressed,
  });

  final String title;
  final IconData iconData;
  final bool? selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: ListTile(
          leading: FittedBox(child: Icon(iconData, size: 24.scalable(ref, maxPercentage: 1.5))),
          title: FittedBox(fit: BoxFit.scaleDown, child: Text(title)),
          selected: selected ?? false,
          style: ListTileStyle.drawer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          onTap: onPressed,
        ),
      );
}
