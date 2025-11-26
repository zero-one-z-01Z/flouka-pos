import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../helper_function/navigation.dart';
import 'button_widget.dart';

class ImagePreviewWidget extends StatelessWidget {
  final XFile? img;
  final String? imgPath;
  final bool showSendButton;
  const ImagePreviewWidget({this.img,this.imgPath,super.key, required this.showSendButton});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: img==null && !showSendButton?null:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWidget(onTap: (){
              navPop();
              // Provider.of<MessageProvider>(context,listen: false).addMessage(file: img!, type: 'image');
            }, text: 'send'),
            SizedBox(height: 1.h,),
          ],
        ),
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,size: 6.w,),
            onPressed: () => Navigator.of(Constants.globalContext()).pop(),
          ),
          title: const SizedBox(),
        ),
        body: Container(
          width: 100.w,
          height: 95.h,
          decoration: BoxDecoration(
            image: img==null?DecorationImage(
              image: CachedNetworkImageProvider(imgPath!),
              fit: BoxFit.contain,
            ):DecorationImage(
              image: FileImage(File(img!.path)),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
