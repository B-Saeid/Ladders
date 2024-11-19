part of '../adaptive_list_tile.dart';

class OthersListTile extends AdaptiveListTile {
  const OthersListTile({
    super.key,
    super.leading,
    required super.title,
    super.description,
    super.enabled,
    super.onPressed,
    super.trailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, bottom: 5),
        child: IgnorePointer(
          ignoring: !enabled,
          child: Material(
            color: AppColors.onScaffoldBackground(ref),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 0.5,
                style: LiveData.isLight(ref) ? BorderStyle.solid : BorderStyle.none,
                color: Colors.grey,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onPressed,
              // highlightColor: theme.themeData.tileHighlightColor,
              child: Row(
                children: [
                  if (leading != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: buildLeading(ref),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 15,
                        vertical: 19.scalable(ref, maxValue: 25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  buildTitle(ref),
                                  if (description != null)
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.0.scalable(ref, maxValue: 8)),
                                      child: buildDescription(ref),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (trailing != null)
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 15, end: 5),
                              child: buildTrailing(context, ref),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildLeading(WidgetRef ref) => IconTheme.merge(
        data: LiveData.themeData(ref).iconTheme.copyWith(
              color: enabled ? null : LiveData.themeData(ref).disabledColor,
              size: 32.scalable(ref, maxValue: 35),
            ),
        child: leading!,
      );

  Widget buildTitle(WidgetRef ref) => DefaultTextStyle.merge(
        style: LiveData.textTheme(ref).titleLarge?.copyWith(
              color: enabled ? null : LiveData.themeData(ref).disabledColor,
            ),
        child: title,
      );

  Widget buildDescription(WidgetRef ref) => DefaultTextStyle.merge(
        style: LiveData.textTheme(ref).bodyLarge?.copyWith(
              color: enabled ? null : LiveData.themeData(ref).disabledColor,
            ),
        child: description!,
      );

  Widget buildTrailing(BuildContext context, WidgetRef ref) => IconTheme.merge(
        data: IconThemeData(
          size: 32.scalable(ref, maxValue: 35),
          color: enabled ? null : LiveData.themeData(ref).disabledColor,
        ),
        child: trailing!,
      );
}
