import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Styles/app_colors.dart';
import '../../Utilities/SessionData/session_data.dart';
import '../../Utilities/device_platform.dart';
import '../cupertino_well.dart';
import '../fit_within.dart';

part 'parts/android_list_tile.dart';
part 'parts/apple_list_tile.dart';
part 'parts/others_list_tile.dart';

class AdaptiveListTile extends ConsumerWidget {
  final Widget? leading;
  final Widget title;
  final Widget? description;
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget? trailing;

  @protected
  final DevicePlatform? platform;

  const AdaptiveListTile({
    super.key,
    this.platform,
    this.leading,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => switch (platform ?? StaticData.platform) {
        DevicePlatform.android => AndroidListTile(
            leading: leading,
            title: title,
            trailing: trailing,
            onPressed: onPressed,
            enabled: enabled,
            description: description,
          ),
        DevicePlatform.iOS => AppleListTile(
            leading: leading,
            title: title,
            trailing: trailing,
            onPressed: onPressed,
            enabled: enabled,
            description: description,
          ),
        DevicePlatform.macOS => AppleListTile(
            leading: leading,
            title: title,
            trailing: trailing,
            onPressed: onPressed,
            enabled: enabled,
            description: description,
          ),
        DevicePlatform.device => throw UnimplementedError(),
        _ => OthersListTile(
            leading: leading,
            title: title,
            trailing: trailing,
            onPressed: onPressed,
            enabled: enabled,
            description: description,
          ),
      };
}
