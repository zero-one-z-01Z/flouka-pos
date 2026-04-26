import 'dart:math' as math;

import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/features/auth/presentation/widgets/have_account_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/register_provider.dart';
import '../widgets/image_picker_field.dart';
import '../widgets/register_step_indicator.dart';

class RegisterPage2 extends StatelessWidget {
  const RegisterPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RegisterProvider>();

    return SafeArea(
      child: Form(
        key: provider.registerForm2Key,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 4.h),

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

              // Title
              _buildTitleSection(),
              SizedBox(height: 4.h),

              // ID Uploads (2 in a row)
              Row(
                children: [
                  Expanded(
                    child: ImagePickerField(
                      label: "ID Card Front",
                      onImageSelected: (file) {
                        provider.setIdFront(file);
                      },
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: ImagePickerField(
                      label: "ID Card Back",
                      onImageSelected: (file) {
                        provider.setIdBack(file);
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              // Text Fields (2 in a row)
              ListTextFieldWidget(
                color: Colors.white,
                inputs: provider.registerPage2TextFields,
              ),

              SizedBox(height: 4.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: IconButton(
                      onPressed: provider.previousStep,
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  ButtonWidget(
                    width: 30.w,
                    borderRadius: 12.sp,
                    onTap: () {
                      provider.register();
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
                ],
              ),
              SizedBox(height: 3.h),
              const HaveAccountSection(isLogin: false),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ), // closes Form
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          LanguageProvider.translate('global', 'complete_registration'),
          style: TextStyleClass.headStyle().copyWith(fontSize: 16.sp),
        ),
        SizedBox(height: 1.h),
        Text(
          LanguageProvider.translate('global', 'company_info_subtitle'),
          style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }
}
