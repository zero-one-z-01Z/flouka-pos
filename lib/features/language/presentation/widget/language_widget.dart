import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/language_provider.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of(context,listen: false);
    return GestureDetector(
      onTap: () => languageProvider.showLanguageDialog(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FD),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              languageProvider.appLocal.languageCode == 'ar' ? 'Ar' : 'En',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 0.5.w),
            Icon(
              Icons.keyboard_arrow_down,
              color:const Color(0xFF9E9E9E),
              size: 2.5.w,
            ),
          ],
        ),
      ),
    );
  }
}
