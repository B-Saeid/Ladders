import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/fa.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:iconify_flutter/icons/ion.dart';

import '../Utilities/SessionData/session_data.dart';

abstract class AdaptiveIcons {
  static bool get isApple => StaticData.platform.isApple;

  static Color _adaptiveColor([WidgetRef? ref]) =>
      (ref != null ? LiveData.isLight(ref) : StaticData.isLight) ? Colors.black : Colors.white;

  static Widget wGoogleLogo({double? size}) => Iconify(
        Logos.google_icon,
        size: size ?? 25,
      );

  static Widget wAppleLogo({WidgetRef? ref, Color? color, double? size}) => SizedBox.square(
        dimension: size ?? 25,
        child: Iconify(
          Logos.apple,
          color: color ?? _adaptiveColor(ref),
          size: size ?? 25,
        ),
      );

  static Widget wSandTimer({WidgetRef? ref, Color? color, double? size}) => Iconify(
        GameIcons.sands_of_time,
        color: color ?? _adaptiveColor(ref),
        size: size,
      );

  static Widget wTraining({WidgetRef? ref, Color? color, double? size}) => Iconify(
        GameIcons.weight_lifting_up,
        color: color ?? _adaptiveColor(ref),
        size: size,
      );

  static Widget wFlatBar({WidgetRef? ref, Color? color, double? size}) => Iconify(
        Ion.ios_fitness,
        color: color ?? _adaptiveColor(ref),
        size: size,
      );

  static Widget wResting({WidgetRef? ref, Color? color, double? size}) => Iconify(
        GameIcons.weight_lifting_down,
        color: color ?? _adaptiveColor(ref),
        size: size,
      );

  static Widget wCardList({WidgetRef? ref, Color? color, double? size}) => Iconify(
        Bi.card_list,
        size: size ?? 32,
        color: color ?? _adaptiveColor(ref),
      );

  static Widget wCardHeading({WidgetRef? ref, Color? color, double? size}) => Iconify(
        Bi.card_heading,
        size: size ?? 32,
        color: color ?? _adaptiveColor(ref),
      );

  static Widget wDrivingLicenseOutline({WidgetRef? ref, Color? color, double? size}) => Iconify(
        Fa.drivers_license_o,
        color: color ?? _adaptiveColor(ref),
        size: size,
      );

  static Widget wDrivingLicense({WidgetRef? ref, Color? color, double? size}) => Iconify(
        Fa.drivers_license,
        size: size ?? 32,
        color: color ?? _adaptiveColor(ref),
      );

  static IconData get home => isApple ? CupertinoIcons.home : Icons.home_rounded;

  static IconData get star => isApple ? CupertinoIcons.star_fill : Icons.star_rounded;

  static IconData get language => isApple ? CupertinoIcons.globe : Icons.language_rounded;

  static IconData get info => isApple ? CupertinoIcons.info_circle_fill : Icons.info_rounded;

  static IconData get settings => isApple ? CupertinoIcons.settings : Icons.settings;

  static IconData get send => isApple ? CupertinoIcons.arrow_up_circle_fill : Icons.send_rounded;

  static IconData get check => isApple ? CupertinoIcons.check_mark : Icons.check;

  static IconData get upload => isApple ? CupertinoIcons.arrow_up_circle_fill : Icons.upload_rounded;

  static IconData get circle => isApple ? CupertinoIcons.circle : Icons.circle_outlined;

  static IconData get circleFill => isApple ? CupertinoIcons.circle_filled : Icons.circle_rounded;

  static IconData get checkFilled =>
      isApple ? CupertinoIcons.check_mark_circled_solid : Icons.check_circle;

  static IconData get checkShieldFilled => CupertinoIcons.checkmark_shield_fill;

  static IconData get share => isApple ? CupertinoIcons.share : Icons.share_rounded;

  static IconData get search => isApple ? CupertinoIcons.search : Icons.search_rounded;

  static IconData get pin => isApple ? CupertinoIcons.delete : Icons.delete_rounded;

  static IconData get report => isApple ? CupertinoIcons.exclamationmark_circle_fill : Icons.report;

  static IconData get reload => isApple ? CupertinoIcons.refresh : Icons.refresh_rounded;

  static IconData get theme => isApple ? CupertinoIcons.circle_righthalf_fill : Icons.contrast_rounded;

  static IconData get light => isApple ? CupertinoIcons.sun_min_fill : Icons.light_mode_rounded;

  static IconData get dark => isApple ? CupertinoIcons.moon_fill : Icons.dark_mode_rounded;

  static IconData get add => isApple ? CupertinoIcons.add : Icons.add;

  static IconData get arrowDown =>
      isApple ? CupertinoIcons.chevron_down : Icons.keyboard_arrow_down_rounded;

  static IconData get arrowUp => isApple ? CupertinoIcons.chevron_up : Icons.keyboard_arrow_up_rounded;

  static IconData get rtlArrow => CupertinoIcons.arrow_left_square_fill;

  static IconData get ltrArrow => CupertinoIcons.arrow_right_square_fill;

  static IconData get pen => isApple ? CupertinoIcons.pen : Icons.edit;

  static IconData get reply => isApple ? CupertinoIcons.reply : Icons.reply;

  static IconData get copy => Icons.copy_rounded;

  static IconData get pause => isApple ? CupertinoIcons.pause : Icons.pause_rounded;

  static IconData get play => isApple ? CupertinoIcons.play_fill : Icons.play_arrow_rounded;

  static IconData get stop => isApple ? CupertinoIcons.stop_fill : Icons.stop_rounded;

  static IconData get photo => isApple ? CupertinoIcons.photo_fill : Icons.photo_rounded;

  static IconData get camera => isApple ? CupertinoIcons.camera_fill : Icons.camera_alt_rounded;

  static IconData get microphone => isApple ? CupertinoIcons.mic_fill : Icons.mic_rounded;

  static IconData get email => isApple ? CupertinoIcons.mail_solid : Icons.email_rounded;

  static IconData get call => isApple ? CupertinoIcons.phone_fill : Icons.call_rounded;

  static IconData get sms => isApple ? CupertinoIcons.text_bubble_fill : Icons.sms_rounded;

  static IconData get phone =>
      isApple ? CupertinoIcons.device_phone_portrait : Icons.phone_android_rounded;

  static IconData get person => isApple ? CupertinoIcons.person_fill : Icons.person_rounded;

  static IconData get lock => isApple ? CupertinoIcons.lock_fill : Icons.lock_rounded;

  static IconData get eye => isApple ? CupertinoIcons.eye_fill : Icons.visibility_rounded;

  static IconData get eyeSlash => isApple ? CupertinoIcons.eye_slash_fill : Icons.visibility_off_rounded;
}
