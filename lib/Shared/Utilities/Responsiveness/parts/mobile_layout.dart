part of '../responsive_layout.dart';

class _MobileLayout extends ConsumerWidget {
  const _MobileLayout(
    this.content,
    this.title,
    this.endDrawer,
    this.useSafeArea,
  );

  final Widget content;
  final StringRef title;
  final bool endDrawer;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(title: L10nRText(title)),
        drawer: endDrawer ? null : const HomeDrawer(),
        endDrawer: endDrawer ? const HomeDrawer() : null,
        body: useSafeArea ? SafeArea(child: content) : content,
      );
}
