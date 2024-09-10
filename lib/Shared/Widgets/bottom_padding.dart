import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Utilities/SessionData/session_data.dart';

class BottomPadding extends ConsumerWidget {
  const BottomPadding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewInsets = LiveData.viewInsets(ref);
    final viewPadding = LiveData.viewPadding(ref);
    final keyboardIsShown = viewInsets.bottom > 50;
    return SizedBox(
      height: keyboardIsShown ? 30.scalable(ref) : max(30, viewPadding.bottom).scalable(ref),
    );
  }
}
