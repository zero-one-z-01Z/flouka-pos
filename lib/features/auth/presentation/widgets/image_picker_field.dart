import 'dart:io';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';

class ImagePickerField extends StatefulWidget {
  final String label;
  final void Function(XFile?) onImageSelected;
  dynamic selectedImage;

  ImagePickerField({
    super.key,
    required this.label,
    required this.onImageSelected,
    required this.selectedImage,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LanguageProvider.translate('inputs', widget.label),
            style: TextStyleClass.captionStyle().copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 1.h),
        GestureDetector(
          onTap: () => widget.onImageSelected(null),
          child: Container(
            height: 10.w,
            width: 25.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: widget.selectedImage != null
                ? Container(
              height: 10.w,
              width: 20.w,
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.1),
                image: DecorationImage(
                  image: widget.selectedImage,
                  fit: BoxFit.cover,
                ),
              ),
            )
                : Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_upload_outlined, size: 16.sp),
                        SizedBox(width: 1.w,),
                        Text(LanguageProvider.translate("auth","upload_image"), style: TextStyle(fontSize: 10.sp)),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }


}
