import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../config/app_styles.dart';
import '../constants/constants.dart';
import '../helper_function/navigation.dart';
import '../widgets/button_widget.dart';

showPopUpDialog({String? title, VoidCallback? onConfirm, Widget? widget}) {
  showDialog(
    context: Constants.globalContext(),
    builder: (context) => Dialog(
      child: widget ?? ConfirmPopUpWidget(title: title, onConfirm: onConfirm),
    ),
  );
}

class ConfirmPopUpWidget extends StatelessWidget {
  const ConfirmPopUpWidget({super.key, this.title, this.onConfirm});
  final String? title;
  final VoidCallback? onConfirm;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 27.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.2.h),
      child: Column(
        children: [
          Text(
            title ?? LanguageProvider.translate('popup', 'هل تريد تسجيل الخروج'),
            style: TextStyleClass.normalStyle(),
          ),
          SizedBox(height: 4.h),
          BorderButtonWidget(
            onTap: onConfirm ?? () {},
            text: LanguageProvider.translate('global', 'نعم'),
            width: 60.w,
            textStyle: TextStyleClass.normalStyle(),
          ),
          SizedBox(height: 3.h),

          ButtonWidget(
            onTap: () {
              navPop();
            },
            width: 60.w,
            text: LanguageProvider.translate('global', 'لا'),
            textStyle: TextStyleClass.normalStyle().copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
