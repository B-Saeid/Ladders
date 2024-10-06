part of '../dialogue.dart';
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
