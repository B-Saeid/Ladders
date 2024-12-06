part of '../tile.dart';

class _TileDescription extends ConsumerWidget {
  const _TileDescription();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restOnlyTrigger = ref.watch(settingProvider.select((p) => p.restOnlyTrigger));
    final recognition = restOnlyTrigger
        ? false
        : ref.watch(
            homeProvider.select((p) => p.recognizing || p.monitoring || p.loading),
          );

    return CustomAnimatedSize(
      child: recognition ? Text(L10nR.tNotAvailableWhileRecognizing(ref)) : const SizedBox(),
    );
  }
}
