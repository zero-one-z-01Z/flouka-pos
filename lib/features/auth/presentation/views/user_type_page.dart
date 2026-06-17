import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/widgets/svg_widget.dart';
import 'package:flouka_pos/features/auth/presentation/widgets/have_account_section.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../language/presentation/widget/language_widget.dart';
import '../providers/auth_provider.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xff00A8E1).withValues(alpha: 0.05),
          appBar: AppBar(
            backgroundColor: Colors.white.withValues(alpha: 0.6),
            title: Text(
              'POS SYSTEM V 0.1',
              style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
            ),
            actions: [
              const LanguageWidget(),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 22.h),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        authProvider.changeUserType(isStore: true);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 3.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: authProvider.isStore ? AppColor.primaryColor : Colors.grey.shade200,
                      ),
                      child: Column(
                        children: [
                          SvgWidget(svg: Images.store,width:  5.w,
                          color:authProvider.isStore ? Colors.white :const Color(0xff444444),fit: BoxFit.cover,),
                          SizedBox(height: 1.h,),
                          Text(LanguageProvider.translate("auth", "store"),
                            style: TextStyleClass.smallStyle(color:authProvider.isStore ? Colors.white : const Color(0xff444444)).copyWith(
                              fontWeight: FontWeight.bold
                            ),),
                          SizedBox(height: 1.h,),

                        ],
                      ),
                                          ),
                    ),
                    SizedBox(width: 2.w,),
                    InkWell(
                      onTap: (){
                        authProvider.changeUserType(isStore: false);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 3.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: authProvider.isStore ? Colors.grey.shade200 : AppColor.primaryColor,
                        ),
                        child: Column(
                          children: [
                            SvgWidget(svg: Images.user,width:  5.w,
                            color:authProvider.isStore ? const Color(0xff444444) : Colors.white,fit: BoxFit.cover),
                            SizedBox(height: 1.h,),
                            Text(LanguageProvider.translate("auth", "vendor"),
                              style: TextStyleClass.smallStyle(color:authProvider.isStore ? const Color(0xff444444) : Colors.white).copyWith(
                                fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                ButtonWidget(
                  borderRadius: 15,
                  width: 28.w,
                  onTap: ()  {
                     authProvider.goToLoginView();
                  },
                  text: "confirm",
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IgnorePointer(
            child: Image.asset(
              fit: BoxFit.fill,
              Images.bottomCircles,
              width: 37.w,
              height: 50.h,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IgnorePointer(child: Image.asset(Images.topCircles, width: 25.w)),
        ),
      ],
    );
  }
}
