import 'package:flouka_pos/features/auth/presentation/widgets/register_step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_images.dart';
import '../providers/register_provider.dart';

class RegisterPage3 extends StatelessWidget {
  const RegisterPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RegisterProvider>();

    return Center(
      child: SingleChildScrollView(
        child: Column(
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
            Image.asset('assets/images/auth/register_3.png', width: 40.w),
            SizedBox(height: 4.h),
            const CircularProgressIndicator(),
            SizedBox(height: 2.h),
            Text(
              'Submitting your registration...',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
