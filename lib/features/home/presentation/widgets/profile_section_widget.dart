import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w, bottom: 15.h),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: -5,
            offset: Offset(0, 6),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          CircleAvatar(
            radius: 5.h,
            backgroundColor: const Color(0xFFE0E0E0),
            child: Icon(Icons.person, size: 5.h, color: Colors.white),
          ),
          SizedBox(height: 1.5.h),

          // Name
          Text(
            'Moaz Mohamed',
            style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
          ),
          SizedBox(height: 0.5.h),

          // Username
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Text(
              '${LanguageProvider.translate('global', 'username')}: mazo.fayd',
              style: TextStyle(fontSize: 10.sp, color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 4.h),

          // Store Status
          Text(
            LanguageProvider.translate('global', 'store_status'),
            style: TextStyleClass.smallStyle().copyWith(fontSize: 10.sp),
          ),
          SizedBox(height: 1.h),

          // Active Status Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
            constraints: BoxConstraints(minWidth: 10.w, maxWidth: 15.w),
            decoration: BoxDecoration(
              color: const Color(0xfff1f1f1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xff41CDFD)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 1.w),
                Flexible(
                  child: Text(
                    LanguageProvider.translate('buttons', 'Active'),
                    style: TextStyleClass.smallStyle(
                      color: const Color(0xff72ca8a),
                    ).copyWith(fontSize: 10.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 1.w),
                CircleAvatar(
                  radius: 1.5.h,
                  backgroundColor: const Color(0xff72ca8a),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
