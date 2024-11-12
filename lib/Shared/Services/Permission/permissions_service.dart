import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Components/Dialogue/dialogue.dart';
import '../../Constants/type_def.dart';
import '../../Extensions/on_strings.dart';
import '../../Utilities/SessionData/session_data.dart';
import '../l10n/assets/l10n_resources.dart';

part 'enums.dart';
part 'permission_dialogues.dart';

abstract class PermissionsService {
  /// Check a specific permission status
  static Future<MyPermissionStatus> check(MyPermission myPermission) async {
    final permission = myPermission.packagePermission;
    final permissionStatus = await permission.status;
    return MyPermissionStatus.values.firstWhere((element) => element.name == permissionStatus.name);
  }

  static Future<bool> checkTF(MyPermission myPermission) async {
    final permission = myPermission.packagePermission;
    final permissionStatus = await permission.status;
    final status = MyPermissionStatus.values.firstWhere(
      (element) => element.name == permissionStatus.name,
    );
    return myPermission.acceptableStatuses.contains(status);
  }

  /// request for a specific permission
  static Future<MyPermissionStatus> request(MyPermission myPermission) async {
    final permission = myPermission.packagePermission;
    final permissionStatus = await permission.request();
    return MyPermissionStatus.values.firstWhere((element) => element.name == permissionStatus.name);
  }

  static Future<bool> myOpenAppSettings() async => await openAppSettings();

  static Future<bool> routine({
    required BuildContext context,
    required MyPermission permission,
    VoidCallback? allSetCallBack,
  }) async {
    final status = await PermissionsService.check(permission);
    print('Permission $status');
    var haveToGoToSetting = permission.toSettingsStatuses.contains(status);
    if (!haveToGoToSetting) {
      if (permission.acceptableStatuses.contains(status)) {
        print('Permission $status');
        allSetCallBack?.call();
        return true;
      } else {
        // This else is within the if (!haveToGoToSettings) block so it satisfies that condition
        if (context.mounted) {
          final canProceed = await showPreRequestDialogue(
            context,
            permission,
            allSetCallBack: allSetCallBack,
          );
          print('canProceed $canProceed');
          return canProceed;
        } else {
          return false;
        }
      }
    } else {
      print('context.mounted ${context.mounted}');
      context.mounted ? showGoToSetting(context, permission) : null;
      return false;
    }
  }

  static void showGoToSetting(BuildContext context, MyPermission permission) => showAdaptiveDialog(
        context: context,
        builder: (context) => PermissionDialogues.toSettings(context, permission),
      );

  static Future<bool> showPreRequestDialogue(
    BuildContext context,
    MyPermission permission, {
    VoidCallback? allSetCallBack,
    FutureBoolCallback? requestMethod,
  }) async {
    final canProceed = await showAdaptiveDialog<bool?>(
      context: context,
      builder: (context) => PermissionDialogues.preRequest(
        context,
        L10nR.permissionRequestMessage(permission.readableName, permission.reason),
        allSetCallBack: allSetCallBack,
        requestMethod: requestMethod,
        permission: permission,
      ),
    );
    return canProceed ?? false;
  }
}
