part of 'permissions_service.dart';

abstract class PermissionDialogues {
  static MyDialogue preRequest(
    BuildContext context,
    String dialogueMessage, {
    required MyPermission permission,
    VoidCallback? allSetCallBack,
    FutureBoolCallback? requestMethod,
  }) =>
      MyDialogue(
        title: L10nR.tPermissionRequired(),
        content: dialogueMessage,
        actionTitle: L10nR.tOK(),
        actionFunction: () async {
          final bool allowed;
          if (requestMethod != null) {
            allowed = await requestMethod();
            if (context.mounted) Navigator.of(context).pop(allowed);
            if (allowed) allSetCallBack?.call();
          } else {
            await _twoDialoguesLogic(
              context,
              dialogueMessage,
              permission,
              allSetCallBack,
            );
          }
        },
        dismissTitle: L10nR.tDismiss(),
        dismissFunction: () => Navigator.of(context).pop(false),
      );

  static Future<void> _twoDialoguesLogic(
    BuildContext context,
    String dialogueMessage,
    MyPermission permission,
    VoidCallback? allSetCallBack,
  ) async {
    /// Request Permission
    final result = await PermissionsService.request(permission);
    print('Permission $result');
    final haveToGoToSetting = permission.toSettingsStatuses.contains(result);
    if (!haveToGoToSetting) {
      ///
      /// Dismissing this dialogue and return true
      /// to the caller then we call [allSetCallBack]
      if (permission.acceptableStatuses.contains(result)) {
        if (context.mounted) Navigator.of(context).pop(true);
        allSetCallBack?.call();
      }

      /// Show Permission Denied Dialogue on top of
      /// the Permission Request Dialogue that is currently displayed
      else {
        if (context.mounted) {
          /// Awaiting the Permission Denied Dialogue result when it is dismissed
          final result = await showAdaptiveDialog<bool?>(
            context: context,
            builder: (context) => _deniedCanRequest(
              context,
              dialogueMessage,
              permission: permission,
              allSetCallBack: allSetCallBack,
            ),
          );

          /// Dismissing this dialogue and return the result
          /// of the Permission denied Dialogue that is has just been dismissed
          // await 2.seconds.delay; // Tested and seen it in action
          if (context.mounted) Navigator.of(context).pop(result);
        }
      }
    }

    /// This is when have to go to settings
    else {
      // await 2.seconds.delay; // Tested and seen it in action
      if (context.mounted) Navigator.of(context).pop(false);
    }
  }

  static MyDialogue _deniedCanRequest(
    BuildContext context,
    String dialogueMessage, {
    required MyPermission permission,
    VoidCallback? allSetCallBack,
  }) =>
      MyDialogue(
        title: L10nR.tPermissionDenied(),
        content: dialogueMessage,
        actionTitle: L10nR.tRequest(),
        actionFunction: () async {
          final result = await PermissionsService.request(permission);
          final allowed = permission.acceptableStatuses.contains(result);
          if (context.mounted) Navigator.of(context).pop(allowed);
          if (allowed) allSetCallBack?.call();
        },
        dismissTitle: L10nR.tDismiss(),
        dismissFunction: () => Navigator.of(context).pop(false),
      );

  static MyDialogue toSettings(BuildContext context, MyPermission permission) => MyDialogue(
        title: L10nR.tPermissionDenied(),
        content: L10nR.permissionSettingMessage(permission.readableName, permission.reason),
        actionTitle: StaticData.platform.isApple ? null : L10nR.tSettings(),
        actionFunction: StaticData.platform.isApple
            ? null
            : () async {
                /// T O D O : DONE FIX BUG:  IT IS NOT A BUG this is iOS behaviour in every app
                /// That's why we removed the toSetting action in this dialogue for iOS.
                ///
                /// App terminates (only on iOS) when we change permission status on device settings
                /// MAY BE AN ISOLATE ISSUE TRY RUN IT ON A DIFFERENT ISOLATE
                /// Note: This may be not a bug as we tried it in release mode no exception occurs
                /// yet the app opens from the begging when status of some permissions changes.
                PermissionsService.myOpenAppSettings();
                Navigator.of(context).pop();
              },
        dismissTitle: L10nR.tDismiss(),
        dismissFunction: () => Navigator.of(context).pop(),
      );
}
