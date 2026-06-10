import 'package:flouka_pos/features/auth/presentation/providers/otp_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';
import '../providers/register_provider.dart';

class OtpFieldWidget extends StatelessWidget {
  const OtpFieldWidget({super.key});
  @override
  Widget build(BuildContext context) {
    OtpProvider otpProvider = Provider.of(context,);
    return Directionality(textDirection: TextDirection.ltr,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 2.w),
        child: PinCodeTextField(
          backgroundColor: Colors.transparent,
          appContext: context,
          length: 4,
          controller: otpProvider.otpController,
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
          keyboardType: TextInputType.number,
          autoFocus: true,
          autoDisposeControllers: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderWidth: 0,
            fieldHeight: 4.w,
            fieldWidth: 3.w,
            activeColor: AppColor.primaryColor,
            inactiveColor:const Color(0xffDADADA),
            selectedColor: AppColor.primaryColor,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          cursorColor: AppColor.primaryColor,
          enableActiveFill: false,
        ),
      ),
    );
  }
}
