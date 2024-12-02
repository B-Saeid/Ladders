part of '../tile.dart';

final triggerPercentageProvider = StateProvider.autoDispose<double>(
      (ref) {
    final currentMic = ref.watch(settingProvider.select((p) => p.microphone));
    double? storedValue;
    if (currentMic != null) storedValue = HiveService.settings.get(currentMic.id);
    return storedValue ?? 0.8;
  },
);