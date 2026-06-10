import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../domain/entities/notification_entity.dart';
import '../pages/notification_details_page.dart';
import '../provider/notifications_provider.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationEntity notificationEntity;

  const NotificationWidget({super.key, required this.notificationEntity});

  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider = Provider.of(context);
    return InkWell(
      onTap: () {
        notificationProvider.setNotification(notificationEntity);
      },
      child: Container(margin: EdgeInsets.symmetric(horizontal: 2.w),width: 20.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.5.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notificationEntity.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyleClass.normalStyle(
                color: Colors.black,
              ).copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 0.5.h),
            Text(
              notificationEntity.description,
              style: TextStyleClass.normalStyle(
                color: Colors.grey,
              ).copyWith(fontSize: 17.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),],
        ),
      ),
    );
  }
}
