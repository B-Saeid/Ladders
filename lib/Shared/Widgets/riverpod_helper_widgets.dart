import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Selector<T> extends StatelessWidget {
  const Selector({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final ProviderListenable<T> selector;
  final Widget Function(BuildContext context, T liveValue, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (context, ref, child) {
          final lifeValue = ref.watch(selector);
          return builder(context, lifeValue, child);
        },
        child: child,
      );
}

class RefWidget extends ConsumerWidget {
  final Widget Function(WidgetRef ref) builder;

  const RefWidget(this.builder, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => builder(ref);
}
