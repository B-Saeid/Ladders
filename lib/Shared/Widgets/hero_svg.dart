import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

import '../Styles/app_colors.dart';

class HeroChild extends ConsumerWidget {
  const HeroChild({super.key, required this.child, this.tag});

  final String? tag;
  final Widget child;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoView.customChild(
        backgroundDecoration: BoxDecoration(color: AppColors.scaffoldBackground(ref)),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
        heroAttributes: PhotoViewHeroAttributes(tag: tag ?? child.hashCode),
        child: child,
      ),
    );
  }
}
