import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widgets/img_preview_widget.dart';
import '../../domain/entities/ticket_message_entity.dart';

class TicketMessageWidget extends StatefulWidget {
  const TicketMessageWidget({super.key, required this.messageEntity, });
  final TicketMessageEntity messageEntity;
  @override
  State<TicketMessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<TicketMessageWidget>{

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: !widget.messageEntity.fromMe()?MainAxisAlignment.start:MainAxisAlignment.end,
      children: [
        if(widget.messageEntity.type=='text')
          Center(child:
          Column(
            crossAxisAlignment:  !(widget.messageEntity.fromMe())? CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              Container(
              constraints: BoxConstraints(
                maxWidth: 15.w,
                minWidth: 10.w,
              ),
              // width: 65.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                // gradient: (widget.messageEntity.fromMe())?  null:AppColor.gradient ,
                color: !(widget.messageEntity.fromMe())?Colors.grey.shade200:AppColor.primaryColor,
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 1.h,horizontal: 1.w),
                child: Text(widget.messageEntity.message,
                  style: TextStyleClass.normalStyle(color:!(widget.messageEntity.fromMe())?Colors.black: Colors.white)
                      .copyWith(fontSize: 12.sp),
                // textAlign: Provider.of<LanguageProvider>(context,listen: false).appLocal.languageCode=='en'?
                //     TextAlign.end:TextAlign.start,
                ),
              ),
                        ),
            ],
          ),),
        if(widget.messageEntity.type=='audio')
          SizedBox(
            width: 160.w,
            child: VoiceMessageView(backgroundColor: !(widget.messageEntity.fromMe())?Colors.grey.shade200:AppColor.primaryColor,
              controller: widget.messageEntity.voiceController!,
              innerPadding: 5.w,
              cornerRadius: 5,
              activeSliderColor: !(widget.messageEntity.fromMe())?AppColor.primaryColor:Colors.grey.shade200,
              playIcon: Icon(
                Icons.play_arrow,
                color: !(widget.messageEntity.fromMe())?Colors.grey.shade200:AppColor.primaryColor,
                size: 10.w,
              ),
              pauseIcon: Icon(
                Icons.pause,
                color: !(widget.messageEntity.fromMe())?Colors.grey.shade200:AppColor.primaryColor,
                size: 10.w,
              ),
              refreshIcon:Icon(
                Icons.refresh,
                color: !(widget.messageEntity.fromMe())?Colors.grey.shade200:AppColor.primaryColor,
                size: 10.w,
              ),
              stopDownloadingIcon:Icon(
                Icons.stop,
                color: !(widget.messageEntity.fromMe())?Colors.grey.shade200:AppColor.primaryColor,
                size: 10.w,
              ),
              circlesColor:!(widget.messageEntity.fromMe())?AppColor.primaryColor:Colors.grey.shade200,
              size: (10.w),
              circlesTextStyle: TextStyleClass.normalStyle(color: !(widget.messageEntity.fromMe())?Colors.white:AppColor.primaryColor,),
              counterTextStyle: TextStyleClass.normalStyle(color: !(widget.messageEntity.fromMe())?AppColor.primaryColor:Colors.white),

            ),
          ),
        if(widget.messageEntity.type=='image')
          Row(
          mainAxisAlignment: widget.messageEntity.fromMe()?MainAxisAlignment.start:MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                navP(ImagePreviewWidget(imgPath: widget.messageEntity.isFile?null:widget.messageEntity.message,
                  img: !widget.messageEntity.isFile?null:XFile(widget.messageEntity.message), showSendButton: false,));
              },
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 150.w,
                  maxHeight: 100.h,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.messageEntity.imageProvider(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
