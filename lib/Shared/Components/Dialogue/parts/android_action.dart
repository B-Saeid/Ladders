part of '../dialogue.dart';

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
  Widget build(BuildContext context, WidgetRef ref) => TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: encouraged ? AppColors.positiveChoiceStyle(ref) : AppColors.negativeChoiceStyle(ref),
        ),
      );
}
