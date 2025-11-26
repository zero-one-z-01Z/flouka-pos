import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_text_with_under_line_login_text.dart';
import '../widgets/login_social_media_list_widget.dart';
import '../widgets/or_divider_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Form(
          key: authProvider.loginFormKey,
          child: Column(
            children: [
              SizedBox(height: 5.h),
              Text(
                LanguageProvider.translate("auth", "Login"),
                style: TextStyleClass.smallStyle().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Image.asset(Images.logo2, width: 40.w),
              SizedBox(height: 3.h),
              ListTextFieldWidget(inputs: authProvider.loginTextFieldList),
              SizedBox(height: 2.h),
              ButtonWidget(onTap: () {}, text: "Login"),
              SizedBox(height: 2.h),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LanguageProvider.translate("auth", "Forgot password"),
                  style: TextStyleClass.normalStyle().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              const OrDividerWidget(),
              SizedBox(height: 3.h),
              const LoginSocialMediaListWidget(),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: CustomTextWithUnderLineText(
                  customText: "New to Habitual?",
                  underLineText: "Sign up",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
