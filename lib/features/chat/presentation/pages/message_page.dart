import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../../../../core/widgets/loading_animation_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/message_provider.dart';
import '../widgets/messages_widget.dart';
import '../widgets/send_message_widget.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    MessageProvider messageProvider = Provider.of(context);
    if (messageProvider.chatEntity != null) {
      delay(300).then((value) {
        messageProvider.scrollToBottom();
      });
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          bottom: false,
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Builder(
              builder: (context) {
                if (messageProvider.chatEntity == null) {
                  return LoadingAnimationWidget(
                    gif: Lotties.chats,
                    width: 60.w,
                    height: 20.h,
                    topPadding: 0,
                  );
                }
                return  SafeArea(
                  child:  Column(
                    children: [
                      SizedBox(height: 2.h,),
                      Stack(
                        children: [
                          Center(child: Text(LanguageProvider.translate('chat', 'chat'),style: TextStyleClass.captionStyle(),)),
                          PositionedDirectional(start: 1.w,child:InkWell(
                              onTap: (){
                                messageProvider.setIsShowChat(false);
                              },
                              child: Icon(Icons.close,size: 2.w,color: Colors.red,)),)
                        ],
                      ),
                      const Expanded(
                        child: MessagesWidget(),
                      ),
                      const SendMessageWidget(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
