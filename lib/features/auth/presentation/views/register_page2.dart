import 'dart:math' as math;

import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/features/auth/presentation/providers/account_type_provider.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/auth/presentation/widgets/have_account_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../../core/widgets/validation_widget.dart';
import '../../../../core/widgets/web_safe_google_map.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/otp_provider.dart';
import '../providers/register_provider.dart';
import '../widgets/file_picker/document_pick_file_widget.dart';
import '../widgets/image_picker_field.dart';
import '../widgets/register_step_indicator.dart';
import 'otp_widget.dart';

class RegisterPage2 extends StatelessWidget {
  const RegisterPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final provider = context.watch<RegisterProvider>();
    final accountType = context.read<AccountTypeProvider>();
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
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Column(
                    //         children: [
                    //           ImagePickerField(
                    //             label: "front_id_card",
                    //             selectedImage: provider.showFrontIdCardImage(),
                    //             onImageSelected: (file) {
                    //               provider.selectFrontIdCardImage();
                    //             },
                    //           ),
                    //           if(!AuthProvider.isLogin())...[
                    //             SizedBox(height: 0.5.h,),
                    //             ValidationWidget(conditions: [
                    //               {"value": provider.frontIdCard == null,
                    //                 "text": LanguageProvider.translate("validation", "front_id_card")}
                    //             ]),
                    //           ],
                    //
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(width: 3.w),
                    //     Expanded(
                    //       child: Column(
                    //         children: [
                    //           ImagePickerField(
                    //             label: "back_id_card",
                    //             selectedImage: provider.showBackIdCardImage(),
                    //             onImageSelected: (file) {
                    //               provider.selectBackIdCardImage();
                    //             },
                    //           ),
                    //           if(!AuthProvider.isLogin())...[
                    //             SizedBox(height: 0.5.h,),
                    //             ValidationWidget(conditions: [
                    //               {"value": provider.backIdCard == null,
                    //                 "text": LanguageProvider.translate("validation", "back_id_card")}
                    //             ]),
                    //           ],
                    //
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(width: 3.w),
                    //     if(accountType.value()=='company')...[
                    //       Expanded(
                    //         child: Column(
                    //           children: [
                    //             ...[
                    //               ImagePickerField(
                    //                 label: "business_license",
                    //                 selectedImage: provider.showBusinessLicenseImage(),
                    //                 onImageSelected: (file) {
                    //                   provider.selectBusinessLicenseImage();
                    //                 },
                    //               ),
                    //               if(!AuthProvider.isLogin())...[
                    //                 SizedBox(height: 0.5.h,),
                    //                 ValidationWidget(conditions: [
                    //                   {"value": provider.businessLicense == null,
                    //                     "text": LanguageProvider.translate("validation", "business_license")}
                    //                 ]),
                    //               ],
                    //             ]
                    //
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(width: 3.w),
                    //     ],
                    //   ],
                    // ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DocumentPickFileWidget(
                                label: "front_id_card",
                                file: provider.frontIdCard,
                                url: auth.userEntity?.frontIdCard,
                                onFileSelected: (file) => provider.selectFrontIdCardImage(file),
                                onFileRemoved: () => provider.removeFrontIdCard(),
                              ),
                              if (!AuthProvider.isLogin()) ...[
                                SizedBox(height: 0.5.h),
                                ValidationWidget(conditions: [
                                  {"value": provider.frontIdCard == null,
                                    "text": LanguageProvider.translate("validation", "front_id_card")}
                                ]),
                              ],
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DocumentPickFileWidget(
                                label: "back_id_card",
                                url: auth.userEntity?.backIdCard,
                                file: provider.backIdCard,
                                onFileSelected: (file) => provider.selectBackIdCardImage(file),
                                onFileRemoved: () => provider.removeBackIdCard(),
                              ),
                              if (!AuthProvider.isLogin()) ...[
                                SizedBox(height: 0.5.h),
                                ValidationWidget(conditions: [
                                  {"value": provider.backIdCard == null,
                                    "text": LanguageProvider.translate("validation", "back_id_card")}
                                ]),
                              ],
                            ],
                          ),
                          SizedBox(height: 2.h),
                          if (accountType.value() == 'company')Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DocumentPickFileWidget(
                                label: "business_license",
                                url: auth.userEntity?.businessLicense,
                                file: provider.businessLicense,
                                onFileSelected: (file) => provider.selectBusinessLicenseImage(file),
                                onFileRemoved: () => provider.removeBusinessLicense(),
                              ),
                              if (!AuthProvider.isLogin()) ...[
                                SizedBox(height: 0.5.h),
                                ValidationWidget(conditions: [
                                  {"value": provider.businessLicense == null,
                                    "text": LanguageProvider.translate("validation", "business_license")}
                                ]),
                              ],
                            ],
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: ,
                    //     ),
                    //     SizedBox(width: 3.w),
                    //     Expanded(
                    //       child:
                    //     ),
                    //     SizedBox(width: 3.w),
                    //     if (accountType.value() == 'company') ...[
                    //       Expanded(
                    //         child:
                    //       ),
                    //       SizedBox(width: 3.w),
                    //     ],
                    //   ],
                    // ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),

              if(accountType.value()!='company')SizedBox(width: double.infinity,height: 40.h,
                child: Stack(
                  children: [
                    WebSafeGoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: provider.latlng??const LatLng(36.806389, 10.181667),
                        zoom: 14,
                      ),
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                        ),
                      },
                      onCameraIdle: () => provider.onCameraMoveEnd(),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onCameraMove: (pos) => provider.onCameraMove(pos),
                    ),
                    Center(
                      child: Icon(Icons.location_on,size: 2.w,color: Colors.red,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),

              if (!AuthProvider.isLogin()) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: const OtpWidget(),
                ),
                SizedBox(height: 3.h),
              ],

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
                    onTap: () async {
                      if (!(provider.registerForm2Key.currentState?.validate() ?? false)) {
                        return;
                      }
                      if (provider.frontIdCard == null || provider.backIdCard == null) {
                        return;
                      }
                      if (provider.businessLicense == null && accountType.value() == 'company') {
                        return;
                      }
                      if (AuthProvider.isLogin()) {
                        provider.updateProfile();
                        return;
                      }
                      // Phone OTP is the last step: send code once, then submit with it.
                      if (otpProvider.otpController.text.length != 4) {
                        await otpProvider.sendOtp(isReg: true);
                        return;
                      }
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
              if(!AuthProvider.isLogin())...[
                const HaveAccountSection(isLogin: false),
                SizedBox(height: 3.h),
              ],
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
          LanguageProvider.translate('global',AuthProvider.isLogin() ? "update_account": 'complete_registration'),
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
