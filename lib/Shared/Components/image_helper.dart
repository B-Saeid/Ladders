
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../Services/Permission/permissions_service.dart';
import '../Services/l10n/assets/l10n_resources.dart';
import '../Utilities/SessionData/session_data.dart';
import 'Toast/toast.dart';

abstract class ImageHelper {
  static void cameraRoutine(BuildContext context, {Function? allSetCallBack}) =>
      PermissionsService.permissionRoutine(
        context: context,
        permission: MyPermission.camera,
        allSetCallBack: allSetCallBack,
      );

  static Future<void> galleryRoutine(BuildContext context, {Function? allSetCallBack}) async {
    /// Problem Encountered on Android 6 'No permissions found in manifest for: []9'
    /// Solution:
    /// https://stackoverflow.com/questions/74826687/how-to-solve-no-permissions-found-in-manifest-for-9-in-flutter
    MyPermission permission;
    if (StaticData.platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        /// use [Permissions.storage.status]
        permission = MyPermission.storage;
      } else {
        /// use [Permissions.photos.status]
        permission = MyPermission.photos;
      }
    } else {
      /// use [Permissions.photos.status]
      permission = MyPermission.photos;
    }
    if (context.mounted) {
      await PermissionsService.permissionRoutine(
        context: context,
        permission: permission,
        allSetCallBack: allSetCallBack,
      );
    }
  }

  static Future<XFile?> getUsing(
    ImageSource imageSource, {
    double? maxHeight,
    double? maxWidth,
    int? imageQuality,
  }) async {
    final xFile = await ImagePicker()
        .pickImage(
          source: imageSource,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          imageQuality: imageQuality,
          // maxHeight: 600,
          // maxWidth: 800,
          // imageQuality: 70,
        )
        .then((file) => file)
        .catchError((error) {
      print('error while pickImage ---> ${error.toString()}');
      Toast.showError(L10nR.tToastDefaultError());
      return null;
    });
    if (xFile == null || xFile.path.isEmpty) {
      print('Nothing is obtained');
      return null;
    } else {
      return xFile;
    }
  }

  /// Later on -- SOON TODO
// static Future<void> crop()async{
//   final cropper = ImageCropper()
// }
}
