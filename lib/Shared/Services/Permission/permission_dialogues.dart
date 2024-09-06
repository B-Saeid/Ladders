import 'package:flutter/material.dart';

import '../../Widgets/dialogue.dart';
import '../l10n/assets/l10n_resources.dart';
import 'permissions_service.dart';

abstract class PermissionDialogues {
  static MyDialogue request(
    BuildContext context,
    String dialogueMessage,
    Function recursiveCall,
  ) =>
      MyDialogue(
        title: L10nR.tPermissionDenied(),
        content: dialogueMessage,
        actionTitle: L10nR.tAllow(),
        actionFunction: () {
          Navigator.of(context).pop();
          recursiveCall();
        },
        dismissTitle: L10nR.tDismiss(),
        dismissFunction: () => Navigator.of(context).pop(),
      );

  static MyDialogue toSettings(BuildContext context, MyPermission permission) => MyDialogue(
        title: L10nR.tPermissionDenied(),
        content: L10nR.permissionSettingMessage(permission.readableName, permission.reason),
        actionTitle: L10nR.tSettings(),
        actionFunction: () async {
          /// TODO : FIX BUG: App terminates when we change the status of the permission to true
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
