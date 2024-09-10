import 'dart:io';

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
  static bool get isIOS => Platform.isIOS;

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

  static IconData get home => isIOS ? CupertinoIcons.home : Icons.home_rounded;

  static IconData get star => isIOS ? CupertinoIcons.star_fill : Icons.star_rounded;

  static IconData get info => isIOS ? CupertinoIcons.info_circle_fill : Icons.info_rounded;

  static IconData get settings => isIOS ? CupertinoIcons.settings : Icons.settings;

  static IconData get send => isIOS ? CupertinoIcons.arrow_up_circle_fill : Icons.send_rounded;

  static IconData get check => isIOS ? CupertinoIcons.check_mark : Icons.check;

  static IconData get upload => isIOS ? CupertinoIcons.arrow_up_circle_fill : Icons.upload_rounded;

  static IconData get circle => isIOS ? CupertinoIcons.circle : Icons.circle_outlined;

  static IconData get circleFill => isIOS ? CupertinoIcons.circle_filled : Icons.circle_rounded;

  static IconData get checkFilled =>
      isIOS ? CupertinoIcons.check_mark_circled_solid : Icons.check_circle;

  static IconData get checkShieldFilled => CupertinoIcons.checkmark_shield_fill;

  static IconData get share => isIOS ? CupertinoIcons.share : Icons.share_rounded;

  static IconData get search => isIOS ? CupertinoIcons.search : Icons.search_rounded;

  static IconData get pin => isIOS ? CupertinoIcons.delete : Icons.delete_rounded;

  static IconData get report => isIOS ? CupertinoIcons.exclamationmark_circle_fill : Icons.report;

  static IconData get reload => isIOS ? CupertinoIcons.refresh : Icons.refresh_rounded;

  static IconData get light => isIOS ? CupertinoIcons.sun_min_fill : Icons.light_mode_rounded;

  static IconData get dark => isIOS ? CupertinoIcons.moon_fill : Icons.dark_mode_rounded;

  static IconData get add => isIOS ? CupertinoIcons.add : Icons.add;

  static IconData get arrowDown =>
      isIOS ? CupertinoIcons.chevron_down : Icons.keyboard_arrow_down_rounded;

  static IconData get arrowUp => isIOS ? CupertinoIcons.chevron_up : Icons.keyboard_arrow_up_rounded;

  static IconData get rtlArrow => CupertinoIcons.arrow_left_square_fill;

  static IconData get ltrArrow => CupertinoIcons.arrow_right_square_fill;

  static IconData get pen => isIOS ? CupertinoIcons.pen : Icons.edit;

  static IconData get reply => isIOS ? CupertinoIcons.reply : Icons.reply;

  static IconData get copy => Icons.copy_rounded;

  static IconData get pause => isIOS ? CupertinoIcons.pause : Icons.pause_rounded;

  static IconData get play => isIOS ? CupertinoIcons.play_fill : Icons.play_arrow_rounded;

  static IconData get stop => isIOS ? CupertinoIcons.stop_fill : Icons.stop_rounded;

  static IconData get photo => isIOS ? CupertinoIcons.photo_fill : Icons.photo_rounded;

  static IconData get camera => isIOS ? CupertinoIcons.camera_fill : Icons.camera_alt_rounded;

  static IconData get microphone => isIOS ? CupertinoIcons.mic_fill : Icons.mic_rounded;

  static IconData get email => isIOS ? CupertinoIcons.mail_solid : Icons.email_rounded;

  static IconData get call => isIOS ? CupertinoIcons.phone_fill : Icons.call_rounded;

  static IconData get sms => isIOS ? CupertinoIcons.text_bubble_fill : Icons.sms_rounded;

  static IconData get phone =>
      isIOS ? CupertinoIcons.device_phone_portrait : Icons.phone_android_rounded;

  static IconData get person => isIOS ? CupertinoIcons.person_fill : Icons.person_rounded;

  static IconData get lock => isIOS ? CupertinoIcons.lock_fill : Icons.lock_rounded;

  static IconData get eye => isIOS ? CupertinoIcons.eye_fill : Icons.visibility_rounded;

  static IconData get eyeSlash => isIOS ? CupertinoIcons.eye_slash_fill : Icons.visibility_off_rounded;
}
