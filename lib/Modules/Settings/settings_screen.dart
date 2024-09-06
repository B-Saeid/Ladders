import 'package:flutter/material.dart';

import '../../Shared/Constants/global_constants.dart';
import '../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../Home/Widgets/home_drawer.dart';
import 'Widgets/change_language.dart';
import 'Widgets/change_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const HomeDrawer(),
      appBar: AppBar(title: Text(L10nR.tSettings)),
      body: const Padding(
        padding: GlobalConstants.screensHPadding,
        child: Center(
          child: Column(
            children: [
              ChangeLanguage(),
              ChangeThemeMode(),
            ],
          ),
        ),
      ),
    );
  }
}
