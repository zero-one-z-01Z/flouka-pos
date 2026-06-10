import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/helper_function/navigation.dart';
import '../provider/ticket_message_provider.dart';

class TicketMessageTitleWidget extends StatelessWidget {
  const TicketMessageTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TicketMessageProvider ticketMessageProvider = Provider.of(context);
    return Container(padding: EdgeInsets.symmetric(vertical: 1.h),
      decoration:const BoxDecoration(color: Colors.white,
        // border: Border.symmetric(horizontal:BorderSide(color: AppColor.defaultColor.withAlpha((0.5*255).round()))),
      ),
      child: Stack(
        children: [
          InkWell(
              onTap: (){
                ticketMessageProvider.clear();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Icon(Icons.close,size: 2.w,color: Colors.red,),
              )),
          Center(child: Text((ticketMessageProvider.ticketEntity?.title)??"",
            maxLines: 1,style: TextStyleClass.normalStyle(),)),
        ],
      ),
    );
  }
}