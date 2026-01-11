import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';

class PerformanceFilterRowWidget extends StatelessWidget {
  const PerformanceFilterRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 1.w,
      runSpacing: 1.h,
      children: [
        _buildFilterChip(
          icon: Icons.calendar_today_outlined,
          label: LanguageProvider.translate('global', 'last_30_days'),
        ),
        _buildFilterChip(
          icon: Icons.grid_view,
          label: LanguageProvider.translate('global', 'all_categories'),
        ),
        _buildFilterChip(
          icon: Icons.sort,
          label: LanguageProvider.translate('global', 'sort_revenue'),
        ),
        _buildFilterChip(
          icon: Icons.info_outline,
          label: LanguageProvider.translate('global', 'status_all'),
        ),
      ],
    );
  }

  Widget _buildFilterChip({required IconData icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: const Color(0xff6B7280)),
          SizedBox(width: 0.8.w),
          Text(
            label,
            style: TextStyleClass.smallStyle().copyWith(
              fontSize: 10.sp,
              color: const Color(0xff374151),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
