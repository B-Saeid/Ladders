import 'package:flutter/material.dart';

import 'hero_photo.dart';
import 'hero_svg.dart';

class ProfileHero extends StatelessWidget {
  static const _placeHolder = '_pathPlaceHolder';

  const ProfileHero({
    super.key,
    required this.path,
    this.radius,
    this.backgroundColor,
  }) : child = const SizedBox();

  const ProfileHero.svg({
    super.key,
    required this.child,
    this.radius,
    this.backgroundColor,
  }) : path = _placeHolder;

  final String path;
  final Widget child;
  final double? radius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => path != _placeHolder ? HeroPhoto(path: path) : HeroChild(child: child),
        ),
      ),
      child: Hero(
        tag: path != _placeHolder ? path.hashCode : child.hashCode,
        child: CircleAvatar(
          foregroundImage: path != _placeHolder ? AssetImage(path) : null,
          backgroundColor: backgroundColor,
          radius: radius,
          child: child,
        ),
      ),
    );
  }
}
