import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../constants/app_lotties.dart';
import '../constants/constants.dart';

bool isLoadingStart = false;
void loading() {
  isLoadingStart = true;
  showDialog(
    context: Constants.globalContext(),
    barrierDismissible: false,
    barrierColor: Colors.white.withValues(alpha: 0),
    builder: (BuildContext context) {
      return PopScope(
        canPop: true,
        child: Opacity(
          opacity: 0.3,
          child: Container(
            width: 100.w,
            height: 100.h,
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 30.w,
                height: 30.w,
                padding: EdgeInsets.all(2.w),
                child: Center(
                  child: Lottie.asset(
                    Lotties.loading,
                    width: 30.w,
                    height: 30.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  ).then((value) {
    isLoadingStart = false;
  });
}
