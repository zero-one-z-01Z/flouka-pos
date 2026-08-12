import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/helper_function/prefs.dart';
import 'package:flouka_pos/core/widgets/web_safe_network_image.dart';
import 'package:flouka_pos/features/auth/presentation/providers/register_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    bool isActive = authProvider.userEntity?.active ?? false;
    bool isStore = sharedPreferences.getBool('isStore') ?? false;
    final logo = authProvider.userEntity?.logo ?? '';
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 4.h, left: 3.w, right: 3.w, bottom: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffE7ECF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isStore)
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200, width: 2),
                color: Colors.grey.shade100,
              ),
              clipBehavior: Clip.antiAlias,
              child: logo.isEmpty
                  ? Icon(Icons.storefront, size: 3.w, color: AppColor.primaryColor)
                  : WebSafeNetworkImage(url: logo, fit: BoxFit.cover),
            ),
          if (isStore) SizedBox(height: 5.w),
          SizedBox(height: 1.h),
          Text(
            '${authProvider.userEntity?.name}',
            style: TextStyleClass.smallStyle().copyWith(fontSize: 13.sp),
          ),
          Text(
            '${authProvider.userEntity?.phone}',
            style: TextStyleClass.smallStyle(color: Colors.grey).copyWith(fontSize: 13.sp),
          ),
          SizedBox(height: 1.h),
          Text(
            LanguageProvider.translate('global', 'store_status'),
            style: TextStyleClass.smallStyle().copyWith(fontSize: 13.sp),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: 13.w,
            child: InkWell(
              onTap: isActive
                  ? () {
                      authProvider.updateProfile(updateActive: true);
                    }
                  : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f1),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: isActive ? const Color(0xff72ca8a) : Colors.red),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isActive) ...[
                      SizedBox(width: 1.w),
                      CircleAvatar(
                        radius: 1.5.h,
                        backgroundColor: const Color(0xff72ca8a),
                      ),
                    ],
                    SizedBox(width: 1.w),
                    SizedBox(
                      width: 6.w,
                      child: Text(
                        LanguageProvider.translate(
                          isActive ? 'global' : 'auth',
                          isActive ? "active" : "under_review",
                        ),
                        style: TextStyleClass.smallStyle(
                          color: isActive ? const Color(0xff72ca8a) : Colors.red,
                        ).copyWith(fontSize: 13.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!isActive) ...[
                      CircleAvatar(
                        radius: 1.5.h,
                        backgroundColor: isActive ? const Color(0xff72ca8a) : Colors.red,
                      ),
                      SizedBox(width: 1.w),
                    ],
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          InkWell(
            onTap: () {
              if (isStore) {
                context.read<RegisterProvider>().showPasswordDialog(isDismissible: true);
              } else {
                context.read<RegisterProvider>().goToRegisterView();
              }
            },
            child: Text(
              LanguageProvider.translate('auth', isStore ? 'change_password' : 'update_profile'),
              style: TextStyleClass.smallStyle(color: Colors.grey).copyWith(decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
