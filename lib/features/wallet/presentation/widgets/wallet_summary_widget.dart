import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../language/presentation/provider/language_provider.dart';


class WalletSummaryWidget extends StatelessWidget {
  final WalletSummaryEntity summary;
  const WalletSummaryWidget({super.key, required this.summary});

  Widget _card(String title, num value, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(top: BorderSide(color: color, width: 3)),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyleClass.captionStyle(color: Colors.grey)),
            SizedBox(height: 0.5.h),
            Text(value.toString(),
                style: TextStyleClass.captionStyle(color: color).copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _card(LanguageProvider.translate("global", "wallet"), summary.wallet, Colors.green),
        _card(LanguageProvider.translate("global", "pending"), summary.pending, Colors.amber),
        _card(LanguageProvider.translate("global", "withdraw"), summary.withdraw, Colors.blueGrey),
        _card(LanguageProvider.translate("global", "total"), summary.total, Colors.blue),
      ],
    );
  }
}
