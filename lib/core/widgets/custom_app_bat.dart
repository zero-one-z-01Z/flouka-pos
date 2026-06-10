import 'package:flouka_pos/core/widgets/logo_widget.dart';
import 'package:flouka_pos/features/notification/presentation/provider/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../features/home/presentation/providers/home_provider.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    final LanguageProvider languageProvider = Provider.of(context);
    return Container(width: double.infinity,
      padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.w, right: 2.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xfff6f6f6))),
      ),
      child: Stack(
        children: [
          Positioned.directional(
            start: 0,top: 3.h,
            textDirection: LanguageProvider.isAr() ? TextDirection.rtl : TextDirection.ltr,
            child: InkWell(
              onTap: () {
                homeProvider.toggleDrawer();
              },
              child: Icon(Icons.menu,size: 2.5.w,),
            ),
          ),
          Center(child: LogoWidget(width: 12.w,height: 5.w,fit: BoxFit.contain,)),
          Positioned.directional(
            end: 0,top: 3.h,
            textDirection: LanguageProvider.isAr() ? TextDirection.rtl : TextDirection.ltr,
            child: Row(children: [
              GestureDetector(
                onTap: () => languageProvider.showLanguageDialog(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        languageProvider.appLocal.languageCode == 'ar' ? 'Ar' : 'En',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 0.5.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color:const Color(0xFF9E9E9E),
                        size: 2.5.w,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 1.w),

              // Notification Icon
              InkWell(
                onTap: (){
                  NotificationProvider notificationProvider = Provider.of(context,listen: false);
                  notificationProvider.goToNotificationPage();
                },
                child: Container(
                  height: 4.h,
                  child: SvgPicture.asset(
                    Images.appBarNotification,
                    width: 2.w,
                    height: 2.w,
                  ),
                ),
              ),

            ],),
          ),
        ],
      ),
    );
  }
}
