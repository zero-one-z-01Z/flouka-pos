import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../provider/message_provider.dart';
import 'date_chat_widget.dart';
import 'message_widget.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MessageProvider messageProvider = Provider.of(context);
    return Builder(
      builder: (context) {
        if (messageProvider.chatEntity!.messages.isEmpty) {
          // return const Center(child: Text("no_messages"));
          return  EmptyAnimation(title: "no_chat", gif: Lotties.chats,width:10.w ,);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            physics:const AlwaysScrollableScrollPhysics(),
            controller: messageProvider.controllerList,
            children: List.generate(
              messageProvider.chatEntity?.messages.length ?? 3,
                  (i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    children: [
                      if ((i == messageProvider.chatEntity!.messages.length - 1))
                      DateChatWidget(
                        messageEntity: messageProvider.chatEntity!.messages[i],
                      ),
                      MessageWidget(
                        messageEntity: messageProvider.chatEntity!.messages[i],
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        mainAxisAlignment:
                        messageProvider.chatEntity!.messages[i].fromMe()
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Text(
                            formatTimeToAm(
                              messageProvider.chatEntity!.messages[i].date,
                            ),
                            style: TextStyleClass.normalStyle().copyWith(fontSize: 11.sp),
                          ),
                          // Text(
                          //   getDiffTime(
                          //     messageProvider.chatEntity!.messages[i].date,
                          //   ),
                          //   style: AppStyles.style15Normal,
                          // ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      if (((i != 0 &&
                          ((messageProvider.chatEntity!.messages[i].date
                              .toLocal()
                              .toString()
                              .split(' ')
                              .first)) !=
                              (messageProvider.chatEntity!.messages[i - 1].date
                                  .toLocal()
                                  .toString()
                                  .split(' ')
                                  .first))))
                        DateChatWidget(
                          messageEntity: messageProvider.chatEntity!.messages[i - 1],
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
