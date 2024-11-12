import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Constants/type_def.dart';
import '../Utilities/SessionData/session_data.dart';

class AppleSheetAction extends ConsumerWidget {
  const AppleSheetAction({
    required this.context,
    required this.title,
    this.style,
    this.onPressed,
    this.destructive = false,
    this.autoDismiss = true,
    super.key,
  });

  final StringRef title;
  final TextStyle? style;
  final bool destructive;
  final VoidCallback? onPressed;
  final bool autoDismiss;
  final BuildContext context;

  BuildContext get _context => context;

  @override
  Widget build(BuildContext context, WidgetRef ref) => CupertinoActionSheetAction(
        onPressed: onPressed != null
            ? () {
                if (autoDismiss) Navigator.of(_context).pop();
                onPressed!();
              }
            : Navigator.of(_context).pop,
        isDestructiveAction: destructive,
        child: Text(
          title(ref),
          style: (style ?? LiveData.textTheme(ref).titleLarge!).copyWith(
            color: destructive ? CupertinoColors.destructiveRed.resolveFrom(context) : null,
          ),
        ),
      );
}
