import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Constants/type_def.dart';

class L10nRText extends ConsumerWidget {
  const L10nRText(
    this.stringFromRef, {
    super.key,
    this.style,
  });

  final StringRef stringFromRef;
  final TextStyle? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Text(
        stringFromRef(ref),
        style: style,
      );
}
