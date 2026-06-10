import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/notifications_provider.dart';

class NotificationDetailsPage extends StatelessWidget {
  const NotificationDetailsPage({
    super.key,
    required this.title,
    required this.data,
  });
  final String title, data;
  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider = Provider.of(context);
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(child: Text(title,
                  style: TextStyleClass.normalStyle(color: Colors.black).copyWith(fontSize: 16.sp),)),
                PositionedDirectional(
                  start: 0,
                  child: InkWell(
                      onTap: (){
                        notificationProvider.clearDetails();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Icon(Icons.close,size: 2.w,color: Colors.red,),
                      )),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 1.h),
                    Text(
                      data,
                      style: TextStyleClass.normalStyle(
                        color: Colors.grey,
                      ).copyWith(fontSize: 17.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
