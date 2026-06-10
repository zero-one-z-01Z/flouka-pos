import 'dart:math' as math;

import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/features/auth/presentation/widgets/have_account_section.dart';
import 'package:flouka_pos/features/auth/presentation/widgets/otp_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../../core/widgets/validation_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/otp_provider.dart';
import '../providers/register_provider.dart';
import '../widgets/image_picker_field.dart';
import '../widgets/register_step_indicator.dart';
import 'otp_widget.dart';

class RegisterPage2 extends StatelessWidget {
  const RegisterPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();
    final otpProvider = context.read<OtpProvider>();

    return SafeArea(
      child: Form(
        key: provider.registerForm2Key,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 6.h),
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


              // Text Fields (2 in a row)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Column(
                  children: [
                    ListTextFieldWidget(
                      color: Colors.white,
                      inputs: provider.registerPage2TextFields,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ImagePickerField(
                                label: "front_id_card",
                                selectedImage: provider.showFrontIdCardImage(),
                                onImageSelected: (file) {
                                  provider.selectFrontIdCardImage();
                                },
                              ),
                              SizedBox(height: 0.5.h,),
                              ValidationWidget(conditions: [
                                {"value": provider.frontIdCard == null,
                                  "text": LanguageProvider.translate("validation", "front_id_card")}
                              ]),

                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            children: [
                              ImagePickerField(
                                label: "back_id_card",
                                selectedImage: provider.showBackIdCardImage(),
                                onImageSelected: (file) {
                                  provider.selectBackIdCardImage();
                                },
                              ),
                              SizedBox(height: 0.5.h,),
                              ValidationWidget(conditions: [
                                {"value": provider.backIdCard == null,
                                  "text": LanguageProvider.translate("validation", "back_id_card")}
                              ]),

                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            children: [
                              ImagePickerField(
                                label: "business_license",
                                selectedImage: provider.showBusinessLicenseImage(),
                                onImageSelected: (file) {
                                  provider.selectBusinessLicenseImage();
                                },
                              ),
                              SizedBox(height: 0.5.h,),
                              ValidationWidget(conditions: [
                                {"value": provider.businessLicense == null,
                                  "text": LanguageProvider.translate("validation", "business_license")}
                              ]),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    const OtpWidget(),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),


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
                      if(provider.registerForm2Key.currentState!.validate()&&
                      otpProvider.otpController.text.length==4 &&
                      provider.frontIdCard != null &&
                      provider.backIdCard != null &&
                      provider.businessLicense != null){
                        provider.register();
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
