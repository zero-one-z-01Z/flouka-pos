import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper_function/navigation.dart';

import '../../../../core/widgets/img_preview_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/message_entity.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key, required this.messageEntity});
  final MessageEntity messageEntity;
  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.messageEntity.fromMe()
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        // if (widget.messageEntity.fromMe())
        //   Padding(
        //     padding: EdgeInsets.only(left: 2.w),
        //     child: const CircleAvatar(
        //       radius: 15,
        //       child: Icon(Icons.person, color: Colors.white),
        //     ),
        //   ),
        if (widget.messageEntity.type == 'text')
          Center(
            child: Column(
              crossAxisAlignment: (widget.messageEntity.fromMe())
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 20.w, minWidth: 10.w),
                  // width: 65.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // gradient: (widget.messageEntity.fromMe())?  null:AppColor.gradient ,
                    color: !(widget.messageEntity.fromMe())
                        ? const Color(0xfff6f6f6)
                        : const Color(0xfffedd66),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                    child: Text(
                      widget.messageEntity.message,
                      style: TextStyleClass.normalStyle( color: Colors.black,).copyWith(fontSize: 11.sp),
                      textAlign:
                      Provider.of<LanguageProvider>(
                        context,
                        listen: false,
                      ).appLocal.languageCode ==
                          'en'
                          ? TextAlign.end
                          : TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (widget.messageEntity.type == 'audio')
          SizedBox(
            width: Constants.isTablet ? 50.w : 60.w,
            child: VoiceMessageView(
              backgroundColor: (widget.messageEntity.fromMe())
                  ? const Color(0xfffedd66)
                  : Colors.black,
              controller: widget.messageEntity.voiceController!,
              innerPadding: 12,
              cornerRadius: 20,
              activeSliderColor: (widget.messageEntity.fromMe())
                  ? Colors.white
                  : const Color(0xfffedd66),
              playIcon: Icon(
                Icons.play_arrow,
                color: (widget.messageEntity.fromMe()) ? const Color(0xfffedd66) : Colors.white,
                size: Constants.isTablet ? 8.w : 5.w,
              ),
              pauseIcon: Icon(
                Icons.pause,
                color: (widget.messageEntity.fromMe()) ? const Color(0xfffedd66) : Colors.white,
                size: Constants.isTablet ? 8.w : 5.w,
              ),
              refreshIcon: Icon(
                Icons.refresh,
                color: (widget.messageEntity.fromMe()) ? const Color(0xfffedd66) : Colors.white,
                size: Constants.isTablet ? 8.w : 5.w,
              ),
              stopDownloadingIcon: Icon(
                Icons.stop,
                color: (widget.messageEntity.fromMe()) ? const Color(0xfffedd66) : Colors.white,
                size: Constants.isTablet ? 8.w : 5.w,
              ),
              circlesColor: (widget.messageEntity.fromMe())
                  ? Colors.white
                  : Color(0xfffedd66),
              size: (Constants.isTablet ? 10.w : 30),
              circlesTextStyle: TextStyleClass.normalStyle(
                color: (widget.messageEntity.fromMe()) ? Colors.black : Colors.white,
              ),
              counterTextStyle: TextStyleClass.normalStyle(
                color: (widget.messageEntity.fromMe()) ? Colors.black : Color(0xfffedd66),
              ),
            ),
          ),
        if (widget.messageEntity.type == 'image')
          Row(
            mainAxisAlignment: widget.messageEntity.fromMe()
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  navP(
                    ImagePreviewWidget(
                      imgPath: widget.messageEntity.isFile
                          ? null
                          : widget.messageEntity.message,
                      img: !widget.messageEntity.isFile
                          ? null
                          : XFile(widget.messageEntity.message),
                      showSendButton: false,
                    ),
                  );
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: 40.w, maxHeight: 22.h),
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
