part of '../adaptive_list_tile.dart';

class AppleListTile extends AdaptiveListTile {
  const AppleListTile({
    super.key,
    super.leading,
    required super.title,
    super.description,
    super.enabled,
    super.onPressed,
    super.trailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => IgnorePointer(
        ignoring: !enabled,
        child: buildContent(ref, context),
      );

  Widget buildContent(WidgetRef ref, BuildContext context) => CupertinoWell(
        // color: theme.themeData.tileColor,
        color: AppColors.onScaffoldBackground(ref),
        margin: const EdgeInsets.only(right: 8, left: 8, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        borderRadius: BorderRadius.circular(12),
        pressedColor: CupertinoColors.systemGrey.resolveFrom(context).withAlpha(180),
        onPressed: onPressed,
        child: Row(
          children: [
            if (leading != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 15),
                child: buildLeading(ref),
              ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Title & Description
                          buildTitle(ref),
                          if (description != null)
                            Padding(
                              padding: EdgeInsets.only(top: 2.scalable(ref)),
                              child: buildDescription(ref),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (trailing != null) buildTrailing(ref)
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildLeading(WidgetRef ref) => FitWithin(
        size: Size.square(32.scalable(ref, maxFactor: 2)),
        alignment: AlignmentDirectional.center,
        boxFit: BoxFit.scaleDown,
        child: IconTheme.merge(
          data: IconThemeData(
            color: enabled ? null : LiveData.themeData(ref).disabledColor,
          ),
          child: leading!,
        ),
      );

  Widget buildTitle(WidgetRef ref) => DefaultTextStyle.merge(
        style: LiveData.textTheme(ref).titleMedium?.copyWith(
              color: enabled ? null : LiveData.themeData(ref).disabledColor,
            ),
        child: title,
      );

  Widget buildDescription(WidgetRef ref) => DefaultTextStyle.merge(
        style: LiveData.textTheme(ref).bodyMedium?.copyWith(
              color: enabled ? null : LiveData.themeData(ref).disabledColor,
            ),
        child: description!,
      );

  Widget buildTrailing(WidgetRef ref) => IconTheme.merge(
        data: IconThemeData(
          size: 24.scalable(
            ref,
            maxFactor: 1.5,
          ),
          color: enabled ? null : LiveData.themeData(ref).disabledColor,
        ),
        child: trailing!,
      );
}
