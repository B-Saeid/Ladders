import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension Context on BuildContext {
  // Custom call a provider for reading method only
  // It will be helpful for us for calling the read function
  // without Consumer,ConsumerWidget or ConsumerStatefulWidget
  // In case if you face any issue using this then please wrap your widget
  // with consumer and then call your provider

  T read<T>(ProviderListenable<T> p) => ProviderScope.containerOf(this, listen: false).read(p);

  void invalidate<T>(ProviderBase<T> p) => ProviderScope.containerOf(this, listen: false).invalidate(p);

  T refresh<T>(ProviderBase<T> p) => ProviderScope.containerOf(this, listen: false).refresh(p);
}
