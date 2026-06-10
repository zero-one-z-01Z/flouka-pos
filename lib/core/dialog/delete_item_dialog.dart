import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';

void deleteDialog({required VoidCallback onTap,required String msg}) async {
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
                Text(
                  LanguageProvider.translate("global",msg,),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(child: InkWell(
                      onTap: (){
                        onTap();
                      },
                        child: Center(child: Text(LanguageProvider.translate("global", "delete"),style: TextStyleClass.captionStyle(color: Colors.red),)))),
                    SizedBox(width: 2.w,),
                    Expanded(child: InkWell(
                      onTap: (){
                        navPop();
                      },
                        child: Center(child: Text(LanguageProvider.translate("global", "cancel"),style: TextStyleClass.captionStyle(),)))),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

}
