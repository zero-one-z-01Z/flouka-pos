import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../config/app_color.dart';
import '../helper_function/image.dart';

/// A reusable widget for uploading a single product image
/// Displays the image preview with Browse and Replace buttons
class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({
    super.key,
    required this.image,
    required this.onImageSelected,
    this.onImageRemoved,
  });

  final XFile? image;
  final void Function(XFile image) onImageSelected;
  final VoidCallback? onImageRemoved;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Preview Section
          if (image != null)
            Center(
              child: Container(
                width: 25.w,
                height: 20.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  image: DecorationImage(
                    image: FileImage(File(image!.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          else
            Center(
              child: Container(
                width: 25.w,
                height: 12.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined, size: 30.sp, color: Colors.grey[400]),
                    SizedBox(height: 1.h),
                    Text(
                      LanguageProvider.translate('global', 'no_image_selected'),
                      style: TextStyle(color: Colors.grey[600], fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 2.h),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Browse Button
              OutlinedButton.icon(
                onPressed: () async {
                  XFile? selectedImage = await chooseImage();
                  if (selectedImage != null) {
                    onImageSelected(selectedImage);
                  }
                },
                icon: Icon(
                  Icons.upload_file,
                  size: 14.sp,
                  color: AppColor.primaryColor,
                ),
                label: Text(
                  LanguageProvider.translate('global', 'browse'),
                  style: TextStyle(color: AppColor.primaryColor, fontSize: 10.sp),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  side: BorderSide(color: AppColor.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              if (image != null) ...[
                SizedBox(width: 2.w),
                // Replace Button
                OutlinedButton.icon(
                  onPressed: () async {
                    XFile? selectedImage = await chooseImage();
                    if (selectedImage != null) {
                      onImageSelected(selectedImage);
                    }
                  },
                  icon: Icon(Icons.refresh, size: 14.sp, color: Colors.grey[700]),
                  label: Text(
                    LanguageProvider.translate('global', 'replace'),
                    style: TextStyle(color: Colors.grey[700], fontSize: 10.sp),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    side: BorderSide(color: Colors.grey[400]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
