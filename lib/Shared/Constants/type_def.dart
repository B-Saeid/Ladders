
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef FutureBoolCallback = Future<bool> Function();
typedef BoolCallback = void Function(bool value);

typedef StringOptionalRef = String Function([WidgetRef? ref]);
typedef StringRef = String Function(WidgetRef ref);