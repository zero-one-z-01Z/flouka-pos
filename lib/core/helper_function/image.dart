import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/app_styles.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../dialog/snack_bar.dart';
import '../widgets/image/pick_image_page.dart';
import '../widgets/image/pick_video_page.dart';
import 'helper_function.dart';
import 'navigation.dart';

Future<dynamic> chooseImage({bool video = false}) {
  var img = showCupertinoModalPopup<XFile?>(
    context: Constants.globalContext(),
    builder: (BuildContext context) => Transform.scale(
      scale: 1,
      child: CupertinoAlertDialog(
        title: Text(
          LanguageProvider.translate('inputs', 'pick'),
          style: TextStyleClass.normalStyle(),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () async {
              if (video) {
                // var img = await pickVideo(context, 1);
                // Navigator.pop(context,img);
                String? status = await checkPermission(1);
                if (status == null) {
                  var status = await Permission.microphone.status;
                  if (!status.isGranted) {
                    var status = await Permission.microphone.request();
                    if (status.isPermanentlyDenied) {
                      showToast('microphone');
                      // await delay(1000);
                      // await openAppSettings();
                      var status = await Permission.microphone.status;
                      if (status.isGranted) {
                      } else {
                        return;
                      }
                    } else if (status.isDenied) {
                      showToast('microphone');
                      // await delay(1000);
                      // await openAppSettings();
                      var status = await Permission.microphone.status;
                      if (status.isGranted) {
                      } else {
                        return;
                      }
                    }
                  }
                  navP(
                    const AddVideoPage(),
                    then: (val) async {
                      await delay(400);
                      navPop(val);
                    },
                  );
                } else {
                  showToast(status);
                }
              } else {
                var img = await pickImage(context, 1);
                Navigator.pop(context, img);
              }
            },
            // child: Text('cancel',s TextStyleClass),
            child: Text(
              LanguageProvider.translate('inputs', 'camera'),
              style: TextStyleClass.normalStyle(),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              if (video) {
                var img = await pickVideo(context, 2);
                Navigator.pop(context, img);
              } else {
                var img = await pickImage(context, 2);
                Navigator.pop(context, img);
              }
            },
            child: Text(
              LanguageProvider.translate('inputs', 'photo'),
              style: TextStyleClass.normalStyle(),
            ),
          ),
        ],
      ),
    ),
  );
  return img;
}

Future<dynamic> chooseImageMulti(context, {bool video = false}) {
  var img = showCupertinoModalPopup<List<XFile>?>(
    context: context,
    builder: (BuildContext context) => Transform.scale(
      scale: 1,
      child: CupertinoAlertDialog(
        title: Text(
          LanguageProvider.translate('inputs', 'pick'),
          style: TextStyleClass.normalStyle(),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () async {
              navP(
                const AddImagePage(multiple: true),
                then: (val) async {
                  await delay(100);
                  navPop(val);
                },
              );
              // var img = await pickMultiImage(context, 1);
              // await delay(100);
              // Navigator.pop(context,img);
            },
            // child: Text('cancel',s TextStyleClass.smallStyle()),
            child: Text(
              LanguageProvider.translate('inputs', 'camera'),
              style: TextStyleClass.normalStyle(),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              var img = await pickMultiImage(context, 2);
              await delay(100);
              Navigator.pop(context, img);
            },
            child: Text(
              LanguageProvider.translate('inputs', 'photo'),
              style: TextStyleClass.normalStyle(),
            ),
          ),
        ],
      ),
    ),
  );
  return img;
}

Future<String?> checkPermission(int type) async {
  if (type == 1) {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return null;
    } else {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        return null;
      } else if (status.isPermanentlyDenied) {
        showToast(LanguageProvider.translate('validation', 'access_camera'));
        // await delay(1000);
        // await openAppSettings();
        var status = await Permission.camera.status;
        if (status.isGranted) {
          return null;
        } else {
          showToast(LanguageProvider.translate('validation', 'access_camera'));
        }
      } else {
        showToast(LanguageProvider.translate('validation', 'access_camera'));
      }
    }
  } else {
    var status = await Permission.photos.status;
    if (status.isGranted) {
      return null;
    } else {
      var status = await Permission.photos.request();
      if (status.isGranted) {
        return null;
      } else {
        showToast(LanguageProvider.translate('validation', 'access_camera'));
      }
    }
  }
  return null;
}

Future<XFile?> pickImage(context, int type) async {
  if (type == 1) {
    final ImagePicker picker = ImagePicker();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      return await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    } else {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        return await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
      } else if (status.isPermanentlyDenied) {
        showToast(LanguageProvider.translate('validation', 'access_camera'));
        // await delay(1000);
        // await openAppSettings();
        var status = await Permission.camera.status;
        if (status.isGranted) {
          return await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 80,
          );
        } else {}
      } else {
        showToast(LanguageProvider.translate('validation', 'access_camera'));
      }
    }
    return null;
  } else {
    final ImagePicker picker = ImagePicker();
    await Permission.mediaLibrary.status;
    return await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
  }
}

Future<XFile?> pickVideo(context, int type) async {
  int minute = 5;
  if (type == 1) {
    final ImagePicker picker = ImagePicker();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      return await picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: Duration(minutes: minute),
      );
    } else {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        return await picker.pickVideo(
          source: ImageSource.camera,
          maxDuration: Duration(minutes: minute),
        );
      } else if (status.isPermanentlyDenied) {
        showToast(LanguageProvider.translate('validation', 'access_camera'));
        // await delay(1000);
        // await openAppSettings();
        var status = await Permission.camera.status;
        if (status.isGranted) {
          return await picker.pickVideo(
            source: ImageSource.camera,
            maxDuration: Duration(minutes: minute),
          );
        } else {}
      } else {
        showToast(LanguageProvider.translate('validation', 'access_camera'));
      }
    }
    return null;
  } else {
    final ImagePicker picker = ImagePicker();
    await Permission.mediaLibrary.status;
    return await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: Duration(minutes: minute),
    );
  }
}

Future<List<XFile>?> pickMultiImage(context, int type) async {
  if (type == 1) {
    final ImagePicker picker = ImagePicker();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      XFile? xFile = await picker.pickImage(source: ImageSource.camera);
      if (xFile != null) {
        return [xFile];
      }
      return [];
    } else {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        XFile? xFile = await picker.pickImage(source: ImageSource.camera);
        if (xFile != null) {
          return [xFile];
        }
        return [];
      } else if (status.isPermanentlyDenied) {
        showToast(LanguageProvider.translate('validation', 'access_camera'));
        // await delay(1000);
        // await openAppSettings();
        var status = await Permission.camera.status;
        if (status.isGranted) {
          XFile? xFile = await picker.pickImage(source: ImageSource.camera);
          if (xFile != null) {
            return [xFile];
          }
          return [];
        } else {}
      } else {
        showToast(LanguageProvider.translate('validation', 'access_camera'));
      }
    }
    return null;
  } else {
    final ImagePicker picker = ImagePicker();
    await Permission.mediaLibrary.status;
    return await picker.pickMultiImage();
  }
}
