import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/register_provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterProvider registerProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: const Color(0xff00A8E1).withValues(alpha: 0.05),
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.6),
        title: Text(
          'POS SYSTEM V 0.1',
          style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              children: [
                Text(
                  "En",
                  style: TextStyleClass.smallStyle(
                    color: const Color(0xff828282),
                  ).copyWith(fontSize: 12.sp),
                ),
                SizedBox(width: 1.w),
                Switch(
                  value: !LanguageProvider.isAr(),
                  onChanged: (value) {
                    // LanguageProvider.changeLanguage(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  Images.floukaLogo,
                  height: 14.h,
                  width: 14.w,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                LanguageProvider.translate('global', 'create_account'),
                style: TextStyleClass.headStyle().copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 2.h),
              Text(
                LanguageProvider.translate('global', 'personal_info'),
                style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
              ),
              SizedBox(height: 2.h),
              ListTextFieldWidget(
                color: Colors.white,
                inputs: registerProvider.registerTextFieldList,
              ),
              SizedBox(height: 2.h),
              ButtonWidget(
                borderRadius: 12.sp,
                onTap: () {
                  registerProvider.goToRegisterView();
                },
                text: LanguageProvider.translate('buttons', 'Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
