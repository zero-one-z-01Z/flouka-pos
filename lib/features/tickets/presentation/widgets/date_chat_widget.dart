import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../domain/entities/ticket_message_entity.dart';

class TicketDateChatWidget extends StatelessWidget {
  const TicketDateChatWidget({super.key, required this.messageEntity});
  final TicketMessageEntity messageEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.grey.shade200,
      ),
      padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Text(messageEntity.createdAt.toLocal().toString().split(' ').first,
        style: TextStyle(fontSize: 11.sp,color: Colors.black),),
    );
  }
}
