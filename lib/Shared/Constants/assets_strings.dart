import '../Extensions/time_package.dart';

abstract class ImageAssets {
  static const destinationPin = 'lib/Assets/images/onBoardingImages/destination_marker_image.png';
  static const sportCar = 'lib/Assets/images/onBoardingImages/sport_car_image.png';
  static const twoCoins = 'lib/Assets/images/onBoardingImages/two_coins_image.png';

  static const googleLogo = 'lib/Assets/images/google_logo.png';
  static const onZRoadLogoCircular = 'lib/Assets/images/logos/circular_logo.png';
  static const onZRoadLogoSquared = 'lib/Assets/images/logos/squared_logo.png';
  static const onZRoadLogoNoBackground = 'lib/Assets/images/logos/no_background.png';
  static const defaultProfileAvatar = 'lib/Assets/images/default_profile_avatar.png';
  static const lockWithQuestionMark = 'lib/Assets/images/forgot_password_icon.png';

  static const pickUpMarker = 'lib/Assets/images/markers/pick_up_marker.png';
  static const destinationMarker = 'lib/Assets/images/markers/destination_marker.png';

  static const meetingPoint = 'lib/Assets/images/markers/meeting_point.png';
  static const dropOffPoint = 'lib/Assets/images/markers/drop_off_point.png';

  static const driverLogo = 'lib/Assets/images/logos/oncourse_driver_logo.png';

  static const startMarker = 'lib/Assets/images/markers/start_marker.png';
  static const endMarker = 'lib/Assets/images/markers/end_marker.png';
}

abstract class SigningLogosAssets {
  // static const appleDark = 'lib/Assets/images/signing_icons/apple_dark.png';
  // static const appleLight = 'lib/Assets/images/signing_icons/apple_light.png';
  // static const appleLightOutlined = 'lib/Assets/images/signing_icons/apple_light_outlined.png';
  static const googleDark = 'lib/Assets/images/signing_icons/google_dark.png';
  static const googleLight = 'lib/Assets/images/signing_icons/google_light.png';
// static const googleNeutral = 'lib/Assets/images/signing_icons/google_neutral.png';
}

abstract class VectorAssets {
  static const pickUpPicker = 'lib/Assets/images/pickers_svg/pick_up_picker.svg';
  static const destinationPicker = 'lib/Assets/images/pickers_svg/destination_picker.svg';
  static const pickUpToDestinationLogo = 'lib/Assets/images/pickers_svg/pick_up_to_destination.svg';

  static const endPicker = 'lib/Assets/images/pickers_svg/end_picker.svg';
  static const startPicker = 'lib/Assets/images/pickers_svg/start_picker.svg';
  static const startToEndLogo = 'lib/Assets/images/pickers_svg/start_to_end.svg';
  static const walletIcon = 'lib/Assets/images/icons/wallet_icon.svg';

  static const carFrontPlaceHolder =
      'lib/Assets/images/vehicle_images_place_holder/car_front_place_holder.svg';
  static const carRearPlaceHolder =
      'lib/Assets/images/vehicle_images_place_holder/car_rear_place_holder.svg';
  static const motorcyclePlaceHolder =
      'lib/Assets/images/vehicle_images_place_holder/motorcycle_place_holder.svg';
}

abstract class SoundAssets {
  static const anyMessageSent = 'lib/Assets/sounds/any_message_sent.mp3';
  static const foreignMessageReceived = 'lib/Assets/sounds/foreign_message_received.mp3';
  static const nonVoiceMessageEntered = 'lib/Assets/sounds/non_voice_message_entered.mp3';
  static const voiceMessageDismissed = 'lib/Assets/sounds/voice_message_dismissed.mp3';
  static const voiceRecordingEntered = 'lib/Assets/sounds/voice_recording_entered.mp3';
  static const voiceRecordingStarted = 'lib/Assets/sounds/voice_recording_started.mp3';
}

abstract class JsonMapStyles {
  static const dark = 'lib/Assets/map_styles/dark.json';
  static const light = 'lib/Assets/map_styles/light.json';
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
  static const otp = 'lib/Assets/animations/otp_6_digits.json';
  static final otpDuration = 10.seconds;
  static const lock = 'lib/Assets/animations/lock_icon.json';
  static final lockDuration = 10.seconds;

  /// TODO : open its file on windows and delete the start delay
  static const success = 'lib/Assets/animations/success_check.json';
  static final successDuration = 5.seconds;
}
