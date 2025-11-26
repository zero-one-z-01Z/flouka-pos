import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../providers/auth_provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Text(
                      "En",
                      style: TextStyleClass.smallStyle(
                        color: const Color(0xff828282),
                      ).copyWith(fontSize: 12.sp),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 37.w),
            child: Form(
              key: authProvider.loginFormKey,
              child: Column(
                children: [
                  SizedBox(height: 28.h),
                  Image.asset(Images.floukaLogo, width: 15.w),
                  SizedBox(height: 3.h),
                  ListTextFieldWidget(
                    color: Colors.white,
                    inputs: authProvider.loginTextFieldList,
                  ),
                  SizedBox(height: 2.h),
                  ButtonWidget(onTap: () {}, text: "Log in"),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            fit: BoxFit.fill,
            Images.bottomCircles,
            width: 37.w,
            height: 50.h,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(Images.topCircles, width: 25.w),
        ),
      ],
    );
  }
}
