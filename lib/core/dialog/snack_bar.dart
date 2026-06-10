import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../config/app_styles.dart';
import '../constants/constants.dart';

void showToast(String text, {Color? color, String? title}) {
  // final materialBanner = MaterialBanner(
  //   elevation: 2,
  //   shadowColor: Colors.transparent,
  //   backgroundColor: Colors.transparent,
  //   forceActionsBelow: true,
  //   content: ConstrainedBox(
  //     constraints: BoxConstraints(
  //       maxHeight: 100.h * 0.3,
  //       minHeight: 80,
  //       minWidth: 50.w,
  //       maxWidth: 100.w,
  //     ),
  //     child: AwesomeSnackbarContent(
  //       title: LanguageProvider.translate('error', 'error'),
  //       message: text.replaceAll(
  //         '\n',
  //         "\n----------------------------------------------\n",
  //       ),
  //       contentType: ContentType.warning,
  //       messageTextStyle: TextStyleClass.normalStyle(
  //         color: Colors.white,
  //       ).copyWith(fontSize: Constants.isTablet ? 30 : 15.sp),
  //       titleTextStyle: TextStyleClass.normalStyle(
  //         color: Colors.white,
  //       ).copyWith(fontSize: Constants.isTablet ? 40 : 13.sp),
  //       color: color ?? AppColor.primaryColor,
  //       inMaterialBanner: true,
  //     ),
  //   ),
  //   actions: const [SizedBox.shrink()],
  // );
  //
  // ScaffoldMessenger.of(Constants.globalContext())
  //   ..hideCurrentMaterialBanner()
  //   ..showMaterialBanner(materialBanner);
  // Future.delayed(const Duration(seconds: 3), () {
  //   ScaffoldMessenger.of(Constants.globalContext()).hideCurrentMaterialBanner();
  // });

  toastification.show(
    context: Constants.globalContext(), // optional if you use ToastificationWrapper
    // title: Text(text),
    description: Text(text.replaceAll('\n', "\n----------------------------\n"),
      style: TextStyleClass.normalStyle(color: Colors.black).copyWith(height: 1.2),),
    autoCloseDuration: const Duration(seconds: 3),
    type: ToastificationType.error,
  );

}
