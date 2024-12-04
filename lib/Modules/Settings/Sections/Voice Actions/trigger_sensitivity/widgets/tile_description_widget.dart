part of '../tile.dart';

class _TileDescription extends ConsumerWidget {
  const _TileDescription();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voicePrecessing = ref.watch(
      homeProvider.select((p) => p.recognizing || p.monitoring || p.loading),
    );
    final restOnlyTrigger = ref.watch(
      settingProvider.select((p) => p.restOnlyTrigger),
    );
    return CustomAnimatedSize(
      child: voicePrecessing
          ? Text(
              restOnlyTrigger
                  ? L10nR.tNotAvailableWhileMonitoring(ref)
                  : L10nR.tNotAvailableWhileRecognizing(ref),
            )
          : const SizedBox(),
    );
  }
}
