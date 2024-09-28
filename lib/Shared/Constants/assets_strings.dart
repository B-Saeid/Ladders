import '../Extensions/time_package.dart';

abstract class ImageAssets {
  static const defaultProfileAvatar = 'assets/images/default_profile_avatar.png';
}

// abstract class VectorAssets {}

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
