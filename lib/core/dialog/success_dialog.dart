import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/app_lotties.dart';
import '../constants/constants.dart';
import '../helper_function/helper_function.dart';
import '../helper_function/navigation.dart';

void successDialog({var then, String? msg, String? lottie, int? sec}) async {
  bool close = false;
  showDialog(
    context: Constants.globalContext(),
    barrierDismissible: true,
    builder: (context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 40.w,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  lottie ?? Lotties.success,
                  width: 20.w,
                ),
                SizedBox(height: 2.h),
                Text(
                  LanguageProvider.translate(
                    'global',
                    msg ?? 'success',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ).then((value) {
    close = true;
    if (then != null) {
      then();
    }
  });
  delay(sec ?? 2000).then((value) {
    if (!close) {
      navPop();
    }
  });
}
