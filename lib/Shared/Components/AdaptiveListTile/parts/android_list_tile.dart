part of '../adaptive_list_tile.dart';

class AndroidListTile extends AdaptiveListTile {
  const AndroidListTile({
    super.key,
    super.leading,
    required super.title,
    super.description,
    super.enabled,
    super.onPressed,
    super.trailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListTile(
        leading: leading,
        title: title,
        subtitle: description,
        onTap: onPressed,
        trailing: trailing,
        enabled: enabled,
      );
}
