import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Extensions/time_package.dart';
import '../../../Shared/Services/l10n/assets/l10n_resources.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../../Shared/Widgets/custom_animated_size.dart';
import '../../Settings/Provider/setting_provider.dart';
import '../utilities/Speech/helpers/spoken_phrases.dart';
import '../utilities/Speech/speech_service.dart';

class CountBeforeStart extends ConsumerWidget {
  const CountBeforeStart(this.valueListenable, this.voiced, {super.key});

  final ValueNotifier<int> valueListenable;
  final bool voiced;
  static Timer? timer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _count(ref);
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (_, value, __) => CustomAnimatedSize(
        duration: 300.milliseconds,
        child: Text(
          getString(ref, value),
          style: LiveData.textTheme(ref).displaySmall,
        ),
      ),
    );
  }

  String getString(WidgetRef ref, int value) {
    final string = value == 0 ? L10nR.tGO() : value.toString();

    if (/*voiced && */ ref.read(settingProvider).speakStartCount) {
      TTSService.speak(value == 0 ? L10nSC.tGo() : string, isEnd: value == 0);
    }

    return string;
  }

  void _count(WidgetRef ref) => timer ??= Timer.periodic(
        1.seconds,
        (timer) => valueListenable.value--,
      );
}
