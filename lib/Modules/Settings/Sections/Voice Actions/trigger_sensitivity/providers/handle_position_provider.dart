part of '../tile.dart';

final handlePositionProvider = AutoDisposeStateNotifierProvider.family<_StartMargin, double, double>(
  (ref, handleExtent) {
    final currentMic = ref.watch(settingProvider.select((p) => p.microphone));
    double? storedValue;
    if (currentMic != null) storedValue = HiveService.settings.get(currentMic.id);
    final percentage = storedValue ?? 0.8;
    final value = percentage * handleExtent;
    return _StartMargin(value, handleExtent);
  },
);

class _StartMargin extends StateNotifier<double> {
  final double handleExtent;

  _StartMargin(super.state, this.handleExtent);

  // late double percentage = state / handleExtent;

  // void setPercentage(double totalWidth) {
  //   percentage = state / totalWidth;
  //   print('percentage = $percentage');
  // }

  void update(double value, String? currentMicId) {
    state = value;
    final percentage = state / handleExtent;
    if (currentMicId == null) return;
    HiveService.settings.put(currentMicId, percentage);
    if (percentage == 1) Toast.showWarning(L10nR.t100MayNotBeReached());
  }

// void maintainPercentage(double totalWidth) => state = percentage * totalWidth;
}
