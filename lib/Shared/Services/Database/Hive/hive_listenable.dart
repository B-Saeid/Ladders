import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveListenable<T> extends StatelessWidget {
  const HiveListenable({
    super.key,
    required this.box,
    required this.builder,
    this.chosenKey,
  });

  final Box box;
  final String? chosenKey;
  final Widget? Function(BuildContext context, T? value) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(keys: chosenKey != null ? [chosenKey] : null),
      builder: (context, value, ___) =>
          builder(
            context,
            chosenKey != null ? value.get(chosenKey) : value,
          ) ??
          const SizedBox(),
    );
  }
}
