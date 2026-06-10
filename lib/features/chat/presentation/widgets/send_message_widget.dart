import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../../../../core/helper_function/image.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widgets/img_preview_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/message_provider.dart';

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MessageProvider messageProvider = Provider.of(context);
    GlobalKey btnKey = GlobalKey();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 100.w,
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
                messageProvider.controller.text.isEmpty? Padding(
                  padding:  EdgeInsets.symmetric(vertical: 2.h),

                  child: SocialMediaRecorder(
                    sendRequestFunction: (soundFile,time) async{
                      await delay(100);
                      messageProvider.addMessage(file: soundFile,type: 'audio',sec: convertToSeconds(time));
                    },
                    recordIconWhenLockBackGroundColor: Colors.transparent,
                    recordIconWhenLockedRecord: Icon(
                      Icons.send,
                      textDirection: LanguageProvider.isAr()?TextDirection.ltr:TextDirection.ltr,
                      size: 17.sp,
                      color: Colors.grey,
                    ),

                    slideToCancelTextStyle: TextStyleClass.normalStyle(color: Colors.grey),
                    cancelTextStyle: TextStyleClass.normalStyle(color: Colors.grey),
                    counterTextStyle: TextStyleClass.normalStyle(color: Colors.grey),
                    recordIconBackGroundColor: Colors.transparent,
                    fullRecordPackageHeight: 6.h,
                    counterBackGroundColor: Colors.transparent,
                    cancelText: LanguageProvider.translate('buttons', 'cancel'),
                    slideToCancelText: LanguageProvider.translate('global', 'slide_to_cancel'),
                    cancelTextBackGroundColor: Colors.transparent,
                    recordIcon: Icon(Icons.mic,color: Colors.grey,size: 17.sp,),
                    backGroundColor: Colors.transparent,

                  ),
                ):
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 3.h,horizontal: 1.w),
                  child: InkWell(
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      messageProvider.addMessage(type: 'text');
                    },
                    child: Icon(Icons.send,color: Colors.grey,size: 17.sp,
                      textDirection: LanguageProvider.isAr()?TextDirection.ltr:TextDirection.ltr,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        key:btnKey,
                        onTap: ()async{
                          final XFile? image = await chooseImage();
                          if(image!=null){
                            navP(ImagePreviewWidget(img: image, showSendButton: true,));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Icon(Icons.image,color: Colors.grey,size:17.sp,),
                        ),
                      ),
                      SizedBox(width: 2.w,),
                      Expanded(
                        child: TextFieldWidget(controller: messageProvider.controller,
                          maxLines: 3,
                          minLines: 1,
                          // height: 5.h,
                          counter: "",
                          onChange: (val){
                            if(val.isEmpty){
                              messageProvider.rebuild();
                            }
                            if(val.length==1){
                              messageProvider.rebuild();
                            }

                          },
                          style: TextStyleClass.captionStyle(),
                          contentPadding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 0.5.w),
                          color: Colors.grey.shade100,borderRadius: 15,borderColor: Colors.transparent,),
                      ),
                      SizedBox(width: 2.w,),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
