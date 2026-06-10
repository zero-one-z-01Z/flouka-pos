import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../config/app_color.dart';
import '../helper_function/image.dart';

class UploadMultiImageWidget extends StatelessWidget {
  const UploadMultiImageWidget({
    super.key,
    required this.images,
    required this.count,
    required this.deleteImage,
    required this.imagesList,
    this.title,
    this.translationSection = 'global',
  });

  final List images;
  final String? title;
  final String translationSection;
  final int count;
  final void Function(int i) deleteImage;
  final void Function(List<XFile> images) imagesList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Images Grid
          Text(
            '${images.length}/$count',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          // if (images.isNotEmpty)
            SizedBox(
              height: 10.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length + 1, // +1 for the add button
                itemBuilder: (ctx, i) {
                  // Add Image Button
                  if (i == images.length) {
                    return InkWell(
                      onTap: () async {
                        List<XFile>? pickedImages = await chooseImageMulti(context);
                        if (pickedImages != null) {
                          imagesList(pickedImages);
                        }
                      },
                      child: Container(
                        width: 7.w,
                        height: 12.h,
                        margin: EdgeInsets.only(left: 1.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 20.sp,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    );
                  }

                  // Image Thumbnail with Delete
                  return InkWell(
                    onTap: () => deleteImage(i),
                    child: Container(
                      width: 7.w,
                      height: 12.h,
                      margin: EdgeInsets.only(left: i == 0 ? 0 : 1.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                        image: (images[i] is XFile)
                            ? DecorationImage(
                                image: FileImage(File(images[i].path)),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: CachedNetworkImageProvider(images[i].image),
                                fit: BoxFit.cover,
                              ),
                      ),
                      child: Stack(
                        children: [
                          // Delete icon overlay
                          Positioned(
                            top: 0.5.w,
                            right: 0.5.w,
                            child: Container(
                              padding: EdgeInsets.all(0.3.w),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 10.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          // else
          //   // Empty state - Add First Image
          //   InkWell(
          //     onTap: () async {
          //       List<XFile>? pickedImages = await chooseImageMulti(context);
          //       if (pickedImages != null) {
          //         imagesList(pickedImages);
          //       }
          //     },
          //     child: Container(
          //       height: 10.h,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(12),
          //         border: Border.all(
          //           color: AppColor.primaryColor,
          //           width: 2,
          //           style: BorderStyle.solid,
          //         ),
          //         color: Colors.white,
          //       ),
          //       child: Center(
          //         child: Icon(
          //           Icons.add_photo_alternate_outlined,
          //           size: 20.sp,
          //           color: AppColor.primaryColor,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
