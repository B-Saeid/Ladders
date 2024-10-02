part of '../toast.dart';

class _MessageWrapper extends StatelessWidget {
  const _MessageWrapper(
    this.toastState,
    this.message,
  ) : assert(
          message is String || message is ValueNotifier<String>,
          'Message must be String or ValueNotifier<String>',
        );

  final _ToastState toastState;
  final Object message;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) => RefWidget(
          (ref) => Container(
            constraints: constraints,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: ShapeDecoration(
              color: toastState.color(ref),
              shape: const StadiumBorder(),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: buildText(ref),
            ),
          ),
        ),
      );

  Widget buildText(WidgetRef ref) {
    final message = this.message;
    final style = LiveData.textTheme(ref).bodyMedium!.copyWith(
          /// Here we use hard coded color as we know the background color form the sate
          /// so we know what will look good regardless of theme being dark or light
          color: toastState == _ToastState.warning
              ? Colors.black
              : LiveData.isLight(ref) && toastState == _ToastState.regular
                  ? Colors.black
                  : Colors.white,
        );

    return switch (message) {
      String() => Text(message, style: style),
      ValueNotifier<String>() => ValueListenableBuilder(
          valueListenable: message,
          builder: (_, value, __) => Text(value, style: style),
        ),
      _ => throw UnimplementedError(),
    };
  }
}
