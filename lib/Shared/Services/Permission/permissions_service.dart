import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../l10n/assets/l10n_resources.dart';
import 'enums.dart';
import 'permission_dialogues.dart';

export 'enums.dart';

abstract class PermissionsService {
  /// Check a specific permission status
  static Future<MyPermissionStatus> checkPermission({required MyPermission ofType}) async {
    final permission = ofType.packagePermission;
    final permissionStatus = await permission.status;
    return MyPermissionStatus.values.firstWhere((element) => element.name == permissionStatus.name);
  }

  /// request for a specific permission
  static Future<MyPermissionStatus> requestPermission(MyPermission myPermission) async {
    final permission = myPermission.packagePermission;
    final permissionStatus = await permission.request();
    return MyPermissionStatus.values.firstWhere((element) => element.name == permissionStatus.name);
  }

  static Future<bool> myOpenAppSettings() async => await openAppSettings();

  static Future<void> permissionRoutine({
    required BuildContext context,
    required MyPermission permission,
    Function? allSetCallBack,
  }) async {
    var status = await PermissionsService.requestPermission(permission);
    print('Permission $status');
    var haveToGoToSetting = permission.toSettingsStatuses.contains(status);
    if (!haveToGoToSetting) {
      if (permission.acceptableStatuses.contains(status)) {
        print('Permission $status');
        allSetCallBack?.call();
      } else {
        // This else is within the if (!haveToGoToSettings) block so it satisfies that condition
        context.mounted ? _showRequestDialogue(context, permission, allSetCallBack) : null;
      }
    } else {
      context.mounted ? _showGoToSetting(context, permission) : null;
    }
  }

  static void _showGoToSetting(BuildContext context, MyPermission permission) => showAdaptiveDialog(
        context: context,
        builder: (context) => PermissionDialogues.toSettings(context, permission),
      );

  static void _showRequestDialogue(
    BuildContext context,
    MyPermission permission,
    Function? allSetCallBack,
  ) =>
      showAdaptiveDialog(
        context: context,
        builder: (context) => PermissionDialogues.request(
          context,
          L10nR.permissionRequestMessage(permission.readableName, permission.reason),
          () => permissionRoutine(
            context: context,
            permission: permission,
            allSetCallBack: allSetCallBack,
          ),
        ),
      );
}
