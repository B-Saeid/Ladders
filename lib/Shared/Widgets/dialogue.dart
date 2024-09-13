import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Constants/assets_strings.dart';
import '../Styles/app_colors.dart';
import '../Utilities/SessionData/session_data.dart';
import 'riverpod_helper_widgets.dart';

class MyDialogue extends StatelessWidget {
  final String title;
  final Object? content;
  final String? actionTitle;
  final VoidCallback? actionFunction;
  final String? dismissTitle;
  final VoidCallback? dismissFunction;
  final bool counterRecommended;
  final Widget? cornerWidget;
  final List<Widget>? customIOSActions;
  final List<Widget>? customAndroidActions;
  final List<Widget>? customAdaptiveActions;
  final bool androidCenterTitle;

  const MyDialogue({
    super.key,
    required this.title,
    this.content,
    this.actionTitle,
    this.actionFunction,
    this.dismissTitle,
    this.dismissFunction,
    this.counterRecommended = false,
    this.androidCenterTitle = false,
    this.cornerWidget,
    this.customAndroidActions,
    this.customIOSActions,
    this.customAdaptiveActions,
  });

  @override
  Widget build(BuildContext context) {
    final isApple = StaticData.platform.isApple;
    return AlertDialog.adaptive(
      contentPadding: isApple ? null : EdgeInsets.zero,
      title: buildTitle(isApple),
      content: content == null
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: isApple
                      ? const EdgeInsets.only(top: 15)
                      : const EdgeInsets.only(top: 25, bottom: 15, left: 15, right: 15),
                  child: content is String
                      ? Text(
                          content as String,
                          textAlign: isApple ? null : TextAlign.start,
                          style: isApple ? const TextStyle(fontFamily: AssetFonts.cairo) : null,
                        )
                      : content as Widget,
                ),
                if (!isApple &&
                    (dismissTitle != null ||
                        actionTitle != null ||
                        customAndroidActions != null ||
                        customAdaptiveActions != null))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: customAndroidActions ??
                          customAdaptiveActions ??
                          [
                            if (dismissTitle != null)
                              AndroidDialogueAction(
                                title: dismissTitle!,
                                onPressed: dismissFunction!,
                                encouraged: counterRecommended,
                              ),
                            if (actionTitle != null)
                              AndroidDialogueAction(
                                title: actionTitle!,
                                onPressed: actionFunction!,
                                encouraged: !counterRecommended,
                              ),
                          ],
                    ),
                  ),
              ],
            ),
      actions: !isApple
          ? null
          : customIOSActions ??
              customAdaptiveActions ??
              [
                if (dismissTitle != null)
                  CupertinoDialogAction(
                    textStyle: const TextStyle(fontFamily: AssetFonts.cairo),
                    onPressed: dismissFunction,
                    isDestructiveAction: !counterRecommended,
                    isDefaultAction: counterRecommended,
                    child: Text(dismissTitle!),
                  ),
                if (actionTitle != null)
                  CupertinoDialogAction(
                    textStyle: const TextStyle(fontFamily: AssetFonts.cairo),
                    onPressed: actionFunction,
                    isDefaultAction: !counterRecommended,
                    isDestructiveAction: counterRecommended,
                    child: Text(actionTitle!),
                  )
              ],
    );
  }

  Widget buildTitle(bool isApple) {
    final titleText = Text(
      title,
      style: isApple ? const TextStyle(fontFamily: AssetFonts.cairo) : null,
      textAlign: (!isApple && androidCenterTitle) ? TextAlign.center : null,
    );
    if (cornerWidget == null) {
      return titleText;
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleText,
          cornerWidget!,
        ],
      );
    }
  }
}

class AndroidDialogueAction extends ConsumerWidget {
  const AndroidDialogueAction({
    super.key,
    required this.title,
    required this.onPressed,
    this.encouraged = true,
  });

  final String title;
  final VoidCallback onPressed;
  final bool encouraged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: encouraged ? AppColors.positiveChoiceStyle(ref) : AppColors.negativeChoiceStyle(ref),
      ),
    );
  }
}

class IOSDialogueAction extends StatelessWidget {
  const IOSDialogueAction({
    super.key,
    required this.title,
    required this.onPressed,
    this.encouraged = true,
  });

  final String title;
  final VoidCallback onPressed;
  final bool encouraged;

  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
      textStyle: const TextStyle(fontFamily: AssetFonts.cairo),
      onPressed: onPressed,
      isDefaultAction: encouraged,
      isDestructiveAction: !encouraged,
      child: Text(title),
    );
  }
}

class AdaptiveDialogueAction extends StatelessWidget {
  const AdaptiveDialogueAction({
    super.key,
    required this.title,
    required this.onPressed,
    this.encouraged,
  });

  final String title;
  final VoidCallback onPressed;
  final bool? encouraged;

  @override
  Widget build(BuildContext context) => StaticData.platform.isApple
      ? CupertinoDialogAction(
          textStyle: const TextStyle(fontFamily: AssetFonts.cairo),
          onPressed: onPressed,
          isDefaultAction: encouraged ?? false,
          isDestructiveAction: !(encouraged ?? true),
          child: Text(title),
        )
      : TextButton(
          onPressed: onPressed,
          child: RefWidget(
            (ref) => Text(
              title,
              style: encouraged ?? true
                  ? AppColors.positiveChoiceStyle(ref)
                  : AppColors.negativeChoiceStyle(ref),
            ),
          ),
        );
}
