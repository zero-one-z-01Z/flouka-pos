import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../config/app_color.dart';
import '../config/app_styles.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../widgets/svg_widget.dart';

void customAlertDialog({
  String? image,
  required String title,
  required String content,
  double? top,
  required String confirm,
  Color? color,
  backConfirm,
  backCancel,
  desColor,
  confirmTextColor,
  cancelTextColor,
  required void Function() confirmTap,
  bool? confirmFound,
  double? padding,
  required String cancel,
  required void Function() cancelTap,
}) {
  showDialog(
    context: Constants.globalContext(),
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            clipBehavior: Clip.none,
            children: [
              if (image != null)
                Positioned(
                  top: top ?? -16.h,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: 35.w,
                    height: 35.w,
                    padding: EdgeInsets.all(padding ?? 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    child: image.contains('.svg')
                        ? SvgWidget(svg: image, fit: BoxFit.contain)
                        : Image.asset(image, fit: BoxFit.contain),
                  ),
                ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LanguageProvider.translate('warning', title),
                    style: TextStyleClass.normalStyle(),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    LanguageProvider.translate('warning', content),
                    style: TextStyleClass.normalStyle()
                        .copyWith(color: desColor ?? const Color(0xff656363))
                        .copyWith(height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      if (confirmFound == null)
                        Expanded(
                          child: InkWell(
                            onTap: confirmTap,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 0.6.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: backConfirm ?? AppColor.primaryColor,
                              ),
                              child: Text(
                                LanguageProvider.translate('buttons', confirm),
                                style: TextStyleClass.normalStyle().copyWith(
                                  color: confirmTextColor ?? Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      if (confirmFound == null) SizedBox(width: 1.w),
                      Expanded(
                        child: InkWell(
                          onTap: cancelTap,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: backCancel ?? const Color(0xff8E8E8E),
                            ),
                            child: Text(
                              LanguageProvider.translate('buttons', cancel),
                              style: TextStyleClass.normalStyle().copyWith(
                                color: cancelTextColor ?? Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
