import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../config/app_styles.dart';
import '../constants/app_images.dart';
import '../helper_function/image.dart';
import '../helper_function/navigation.dart';
import 'svg_widget.dart';
import 'video_view_page.dart';


class UploadVideoWidget extends StatelessWidget {
  const UploadVideoWidget({super.key,required this.image, required this.selectImage, this.video, required this.onTap});
  final dynamic video;
  final String? image;
  final void Function(XFile? image) selectImage;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        if(video==null){
          FocusScope.of(context).unfocus();
          XFile? image = await chooseImage(video: true);
          selectImage(image);
        }else{
          if(video is XFile){
            navP(VideoViewPage(video: File(video!.path)));
          }else{
            navP(VideoViewPage(video: video));
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.symmetric(horizontal: 1.w,vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
          image:image!=null  ? (video is XFile) ? DecorationImage(
            image: FileImage(File(image!),),
            fit: BoxFit.cover,
          ):DecorationImage(
            image:CachedNetworkImageProvider(image!),
            fit: BoxFit.cover,
          ) :null,
        ),
        child: image==null?Center(
          child: SvgWidget(svg: Images.addVideo,width: 4.w,color: Colors.black54,),
        ):const SizedBox(),
      ),
        );
  }
}