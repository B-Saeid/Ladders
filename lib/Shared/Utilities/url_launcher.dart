import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncher {
  static Future<void> phoneCall(String number) async {
    final url = Uri.parse('$_callLaunchPrefix$number');
    if (!await launchUrl(url)) {
      print('error while launch $url');
    }
  }

  static Future<void> emailSend(String email) async {
    final url = Uri.parse('$_emailSendPrefix$email');
    if (!await launchUrl(url)) {
      print('error while launch $url');
    }
  }

  static Future<void> httpsLink(String link,
      {LaunchMode launchMode = LaunchMode.platformDefault}) async {
    final url = Uri.parse(link);
    if (!await launchUrl(url, mode: launchMode)) {
      print('error while launch $url');
    }
  }

  static const _callLaunchPrefix = 'tel:';
  static const _emailSendPrefix = 'mailto:';

  /// TODO : Good To know and implement
//sms:<phone number> //sms:5550101234
// file:<path> //file:/home 	Open file or folder using default app association, supported on desktop platforms
//mailto:<email address>?subject=<subject>&body=<body> //mailto:smith@example.org?subject=News&body=New%20plugin
// launchUrl
// canLaunchUrl
// closeInAppWebView
// supportsLaunchMode
// supportsCloseForLaunchMode
}
