import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Shared/Constants/assets_strings.dart';
import '../../../Shared/Services/Routing/routes_base.dart';
import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Styles/adaptive_icons.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../utilities/helper_methods.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
        width: 220,
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                /// T O D O : DONE Have logo pattern background and the name in the center as nice design
                child: SvgPicture.asset(
                  VectorAssets.drawerPatternOutlinedWide,
                  fit: BoxFit.cover,
                ),
              ),
              const _DrawerBody(),
            ],
          ),
        ),
      );
}

class _DrawerBody extends ConsumerWidget {
  const _DrawerBody();

  static List<_DrawerItem> mainGroup(WidgetRef ref) => [
        _DrawerItem(
          title: L10nR.tHomePageTitle(ref).toUpperCase(),
          iconData: AdaptiveIcons.home,
          path: Routes.home.path,
        ),
        _DrawerItem(
          title: L10nR.tSettings(ref).toUpperCase(),
          iconData: AdaptiveIcons.settings,
          path: Routes.settings.path,
        ),
      ];

  static List<_DrawerItem> subGroup(WidgetRef ref) => [
        _DrawerItem(
          title: L10nR.tRateUs(ref),
          iconData: AdaptiveIcons.star,
          path: Routes.home.path, // todo
        ),
        _DrawerItem(
          title: L10nR.tAbout(ref),
          iconData: AdaptiveIcons.info,
          path: Routes.home.path, // todo
        ),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) => Expanded(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                mainGroup(ref).map((e) => _OurDrawerItem(e)).toList(),
              ),
            ),
            const SliverToBoxAdapter(child: Divider(height: 20)),
            SliverList(
              delegate: SliverChildListDelegate(
                subGroup(ref).map((e) => _OurDrawerItem(e)).toList(),
              ),
            ),
          ],
        ),
      );
}

class _DrawerItem {
  final String title;
  final IconData iconData;
  final String path;

  _DrawerItem({required this.title, required this.iconData, required this.path});
}

class _OurDrawerItem extends ConsumerWidget {
  const _OurDrawerItem(this.item);

  final _DrawerItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: ListTile(
          leading: FittedBox(child: Icon(item.iconData, size: 24.scalable(ref, maxFactor: 1.5))),
          title: FittedBox(fit: BoxFit.scaleDown, child: Text(item.title)),
          selected: Scaffold.of(context).hasDrawer ? RoutesBase.currentRoute == item.path : false,
          style: ListTileStyle.drawer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          onTap: () => onTileTapped(context, item.path),
        ),
      );

  void onTileTapped(
    BuildContext context,
    String to,
  ) =>
      InAppHelpers.adaptiveDrawerNavigation(
        context,
        to: to,
      );
}
