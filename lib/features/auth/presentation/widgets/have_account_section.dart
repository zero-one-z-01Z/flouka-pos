import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../providers/auth_provider.dart';
import '../providers/register_provider.dart';

class HaveAccountSection extends StatelessWidget {
  const HaveAccountSection({super.key, required this.isLogin});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LanguageProvider.translate(
            'global',
            isLogin ? 'dont_have_account' : 'have_account',
          ),
          style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
        ),
        SizedBox(width: 1.w),
        InkWell(
          onTap: () {
            if (isLogin) {
              context.read<RegisterProvider>().goToRegisterView();
            } else {
              navPU();
            }
          },
          child: Text(
            LanguageProvider.translate(
              'global',
              isLogin ? 'register' : 'login',
            ),
            style: TextStyleClass.smallStyle(
              color: AppColor.primaryColor,
            ).copyWith(fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
