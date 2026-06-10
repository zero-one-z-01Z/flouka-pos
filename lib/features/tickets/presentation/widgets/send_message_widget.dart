import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../../../../core/helper_function/image.dart';
import '../../../../core/helper_function/navigation.dart';

import '../../../../core/widgets/img_preview_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/ticket_message_provider.dart';

class TicketSendMessageWidget extends StatelessWidget {
  const TicketSendMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TicketMessageProvider ticketMessageProvider = Provider.of(context);
    GlobalKey btnKey = GlobalKey();
    return ticketMessageProvider.ticketEntity?.status !="closed" && ticketMessageProvider.ticketEntity?.status!="completed"?
    Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
          // boxShadow: [BoxShadow(color: Colors.black.withAlpha((0.12*255).round()),offset: Offset(8, 0),
            // blurRadius: 12,spreadRadius: 0)],
          border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.symmetric(horizontal: 1.w,),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 2.h),
                  child: SocialMediaRecorder(
                    sendRequestFunction: (soundFile,time) async{
                      await delay(100);
                      ticketMessageProvider.addMessage(file: soundFile,type: 'audio',sec: convertToSeconds(time));
                    },
                    recordIconWhenLockBackGroundColor: Colors.transparent,
                    recordIconWhenLockedRecord: Icon(
                      Icons.send,
                      textDirection: LanguageProvider.isAr()?TextDirection.ltr:TextDirection.ltr,
                      size: 15.sp,
                      color: Colors.grey,
                    ),
                    slideToCancelTextStyle: TextStyleClass.captionStyle(color: Colors.grey),
                    cancelTextStyle: TextStyleClass.captionStyle(color: Colors.grey),
                    counterTextStyle: TextStyleClass.captionStyle(color: Colors.grey),
                    recordIconBackGroundColor: Colors.transparent,
                    fullRecordPackageHeight: 5.h,
                    counterBackGroundColor: Colors.transparent,
                    cancelText: LanguageProvider.translate("buttons", "cancel"),
                    slideToCancelText:  LanguageProvider.translate("chat", "slide_to_cancel"),
                    cancelTextBackGroundColor: Colors.transparent,
                    // recordIcon: Icon(Icons.mic,color: AppColor.textColor,size: Constants.isTablet?40:30,),
                    recordIcon: Icon(Icons.mic,color: Colors.grey.shade600,size: 15.sp,),
                    backGroundColor: Colors.transparent,

                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        key:btnKey,
                        onTap: ()async{
                          XFile? image = await chooseImage();
                          if(image!=null){
                            navP(ImagePreviewWidget(img: image, showSendButton: false,));
                          }
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 3.h),
                          child: Icon(Icons.attachment,color: Colors.grey.shade600,size: 15.sp,),
                          // child: SvgWidget(svg: Assets.attachment,width: 6.w,),
                        ),
                      ),
                      SizedBox(width: 2.w,),
                      Expanded(
                        child: TextFieldWidget(controller: ticketMessageProvider.controller,
                          hintText: "send_message",
                          counter: "",hintColor: Colors.grey,
                          color:Colors.grey.shade100,

                          onChange: (val){
                            if(val.isEmpty){
                              ticketMessageProvider.rebuild();
                            }
                            if(val.length==1){
                              ticketMessageProvider.rebuild();
                            }
                          },
                          style: TextStyleClass.captionStyle(),
                          contentPadding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 0.5.w),
                          borderRadius: 4,borderColor: Colors.transparent,),
                      ),
                      SizedBox(width: 1.w,),
                    ],
                  ),
                ),
                if (ticketMessageProvider.controller.text.isNotEmpty)  Padding(
                  padding:  EdgeInsets.symmetric(vertical: 3.h,horizontal: 2.w),
                  child: InkWell(
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      ticketMessageProvider.addMessage(type: 'text',);
                    },
                    // child: Container(
                    //   padding: EdgeInsets.all(8.w),
                    //   decoration: BoxDecoration(
                    //       color: AppColor.defaultColor,
                    //       shape: BoxShape.circle
                    //   ),
                    //   child: Container(
                    //     padding: EdgeInsets.all(8.w),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         shape: BoxShape.circle
                    //     ),
                    //   ),),
                    child: Transform.rotate(angle: 3.1415926,
                      child: Icon(
                        Icons.send,
                        textDirection: LanguageProvider.isAr()?TextDirection.ltr:TextDirection.ltr,
                        size: 2.h,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    ):const SizedBox();
  }
}
