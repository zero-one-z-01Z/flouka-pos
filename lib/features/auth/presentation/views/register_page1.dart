import 'dart:math' as math;
import 'package:flouka_pos/core/constants/app_images.dart';
import 'package:flouka_pos/core/widgets/validation_widget.dart';
import 'package:flouka_pos/features/auth/presentation/widgets/register_step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/register_provider.dart';
import '../widgets/account_type_selector.dart';
import '../widgets/have_account_section.dart';

class RegisterPage1 extends StatelessWidget {
  const RegisterPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.read<RegisterProvider>();
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Form(
          key: registerProvider.registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 2.h),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(Images.floukaLogo, width: 14.w),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: const RegisterStepIndicator(),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              _buildTitleSection(),
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    ListTextFieldWidget(
                      color: Colors.white,
                      inputs: registerProvider.registerTextFieldList,
                    ),
                    SizedBox(height: 4.h),
                    const AccountTypeSelector(),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              ButtonWidget(
                width: 30.w,
                borderRadius: 12.sp,
                onTap: () {
                  if ((registerProvider.registerFormKey.currentState?.validate() ?? false)  &&
                      registerProvider.selectedAccountType != null) {
                    registerProvider.nextStep();
                  }
                },
                widget: Padding(
                  padding: EdgeInsets.all(1.w),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ),
                text: LanguageProvider.translate('buttons', 'next_step'),
              ),
              SizedBox(height: 2.h),
              const HaveAccountSection(isLogin: false),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          LanguageProvider.translate('global', 'create_account'),
          style: TextStyleClass.headStyle().copyWith(fontSize: 16.sp),
        ),
        SizedBox(height: 1.h),
        Text(
          LanguageProvider.translate('global', 'personal_info'),
          style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }
}
