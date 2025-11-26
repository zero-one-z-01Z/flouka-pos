import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../helper_function/helper_function.dart';
import '../helper_function/navigation.dart';

void successDialog({var then, String? msg, String? lottie, int? sec}) async {
  bool close = false;
  showModalBottomSheet(
    context: Constants.globalContext(),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: 100.w,
            constraints: BoxConstraints(
              maxHeight: Constants.isTablet ? 50.h : 35.h,
              minHeight: Constants.isTablet ? 50.h : 35.h,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: (30.w) / 2),
                      child: lottie != null
                          ? Lottie.asset(lottie, fit: BoxFit.contain, width: 40.w)
                          : Image.asset(
                              'assets/images/success.gif',
                              fit: BoxFit.contain,
                              width: 40.w,
                            ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      LanguageProvider.translate('success', msg ?? 'success'),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
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
