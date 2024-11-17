import 'package:flutter/widgets.dart';

import '../Extensions/time_package.dart';

part 'bluetooth_mic_icon.dart';

abstract class ImageAssets {
  static const defaultProfileAvatar = 'assets/images/default_profile_avatar.png';
  static const drawerPatternFilled = 'assets/images/drawer_pattern_filled.png';
  static const drawerPatternOutlined = 'assets/images/drawer_pattern_outlined.png';
  static const drawerPatternOutlinedWide = 'assets/images/drawer_pattern_outlined_wide.png';
  static const logoCircular = 'assets/images/logo_circular.png';
  static const logoSquared = 'assets/images/logo_squared.png';
  static const logoRoundedPadded = 'assets/images/logo_rounded_padded.png';
  static const logoRounded = 'assets/images/logo_rounded.png';
  static const logoTransparent = 'assets/images/logo_transparent.png';
}

abstract class VectorAssets {
  static const drawerPatternOutlined = 'assets/vectors/drawer_pattern_outlined.svg';
  static const drawerPatternOutlinedWide = 'assets/vectors/drawer_pattern_outlined_wide.svg';
}

abstract class SoundAssets {
  static const speechStopped = 'assets/sounds/speech_to_text_stop.mp3';
  static const speechListening = 'assets/sounds/speech_to_text_listening.mp3';
}

abstract class AssetFonts {
  static const cairo = 'Cairo'; // TODO : remove its usage all over as we made it app Default Font
  static const rubik = 'Rubik';
  static const almarai = 'Almarai';
  static const montserrat = 'Montserrat';
  static const androidEmojiFont = 'NotoColoredEmoji';
// static const kSpecialFontFamily = 'Reglisse';
// static const kSuperFontFamily = 'PlaytimeSolid';
// static const kButtonFontFamily = 'PlaytimeRegular';
// static const kCronusFontFamily = 'Cronus';
// static const kLemonFontFamily = 'Lemon';
}

abstract class AnimationAssets {
  /// TODO : open its file on windows and delete the start delay
  static const success = 'assets/animations/success_check.json';
  static final successDuration = 5.seconds;
}
