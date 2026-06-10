import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../provider/ticket_message_provider.dart';
import '../widgets/message_title_widget.dart';
import '../widgets/messages_widget.dart';
import '../widgets/send_message_widget.dart';


class TicketMessagePage extends StatelessWidget {
  const TicketMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    TicketMessageProvider ticketMessageProvider = Provider.of(context);
    if(ticketMessageProvider.ticketEntity!=null){
      delay(300).then((value) {
        ticketMessageProvider.scrollToBottom();
      });
    }
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const TicketMessageTitleWidget(),
                SizedBox(height: 1.h,),
                const TicketMessagesWidget(),
                SizedBox(height: 2.h,),

              ],
            ),
          ),
          const TicketSendMessageWidget(),
        ],
      ),
    );
  }
}
