import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class L10nRText extends ConsumerWidget {
  const L10nRText(
    this.stringFromRef, {
    super.key,
    this.style,
  });

  final String Function([WidgetRef? ref]) stringFromRef;
  final TextStyle? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Text(
        stringFromRef(ref),
        style: style,
      );
}
