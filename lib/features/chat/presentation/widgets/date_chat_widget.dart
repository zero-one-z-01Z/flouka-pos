import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entities/message_entity.dart';

class DateChatWidget extends StatelessWidget {
  const DateChatWidget({super.key, required this.messageEntity});
  final MessageEntity messageEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.shade200,
      ),
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Text(
        messageEntity.date.toLocal().toString().split(' ').first,
        style: TextStyle(fontSize: 11.sp, color: Colors.black, height: 1.3),
      ),
    );
  }
}
