part of '../dialogue.dart';

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
      ? IOSDialogueAction(title: title, onPressed: onPressed, encouraged: encouraged ?? true)
      : AndroidDialogueAction(title: title, onPressed: onPressed, encouraged: encouraged ?? true);
}
