import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../config/app_color.dart';
import '../config/app_styles.dart';
import '../helper_function/image.dart';

class UploadMultiImageWidget extends StatelessWidget {
  const UploadMultiImageWidget({
    super.key,
    required this.images,
    required this.count,
    required this.deleteImage,
    required this.imagesList,
    this.title,
  });
  final List images;
  final String? title;
  final int count;
  final void Function(int i) deleteImage;
  final void Function(List<XFile> images) imagesList;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        color: Colors.white,
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withAlpha((0.1 * 255).round()),
          //   spreadRadius: 0,
          //   blurRadius: 30,
          //   offset: const Offset(0, 4),
          // ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      child: InkWell(
        onTap: () async {
          List<XFile>? pickedImages = await chooseImageMulti(context);
          if (pickedImages != null) {
            imagesList(pickedImages);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (images.isEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    LanguageProvider.translate(
                      'global',
                      title ?? 'upload_image',
                    ).replaceAll('*count*', count.toString()),
                    style: TextStyleClass.normalStyle().copyWith(
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 0.5.h),
            if (images.isNotEmpty)
              SizedBox(
                width: 94.w,
                height: 10.h,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: AppColor.primaryColor,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(Icons.add, size: 6.w, color: Colors.white),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          return InkWell(
                            onTap: () {
                              deleteImage(i);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Container(
                                width: 18.w,
                                height: 14.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: (images[i] is XFile)
                                      ? DecorationImage(
                                          image: FileImage(File(images[i].path)),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            images[i].image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (images.isEmpty)
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.h),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.w),
                  color: AppColor.primaryColor,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.add),
              ),

            Row(
              children: [
                if (images.isNotEmpty)
                  Text(
                    LanguageProvider.translate('global', 'delete_image'),
                    style: TextStyleClass.normalStyle().copyWith(
                      color: const Color(0xff323131),
                    ),
                  ),
                const Spacer(),
                Text(
                  '${images.length}/$count',
                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
