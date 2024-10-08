import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

import '../Styles/app_colors.dart';
import 'neat_circular_indicator.dart';

class HeroPhoto extends ConsumerWidget {
  const HeroPhoto({super.key, required this.path, this.tag});

  final String? tag;
  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoView(
        /// TODO : THIS ASSET SHOULD BE SAVED IN DATABASE and then used as base64Decode i.e. MemoryImage
        imageProvider: AssetImage(path),
        backgroundDecoration: BoxDecoration(color: AppColors.scaffoldBackground(ref)),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
        loadingBuilder: (context, event) => const Center(child: NeatCircularIndicator()),
        heroAttributes: PhotoViewHeroAttributes(tag: tag ?? path.hashCode),
      ),
    );
  }
}
