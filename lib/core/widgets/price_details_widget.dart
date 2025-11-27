import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import 'payment_price_widget.dart';

class PriceDetailesList extends StatelessWidget {
  const PriceDetailesList({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 4,
        children: [
          PaymentPriceWidget(
            fontSize: 16.sp,
            title: LanguageProvider.translate("global", "price"),
            price: "55",
          ),
          Divider(color: Colors.grey.shade400, endIndent: 32, indent: 32),
          PaymentPriceWidget(
            fontSize: 16.sp,
            title: LanguageProvider.translate("global", "Shiping"),
            price: "56165",
          ),
          // if (couponProvider.couponEntity != null) ...[
          //   Divider(color: Colors.grey.shade400, endIndent: 32, indent: 32),
          //   PaymentPriceWidget(
          //     fontSize: 16.sp,
          //     title: LanguageProvider.translate("global", "discount"),
          //     price: couponProvider
          //         .calcCoupon(checkoutProvider.subTotalTax)!
          //         .toStringAsFixed(2),
          //   ),
          // ],
          Divider(color: Colors.grey.shade400, endIndent: 32, indent: 32),
          PaymentPriceWidget(
            fontSize: 16.sp,
            title: LanguageProvider.translate("global", "Taxes"),
            price: "5641",
          ),
          Divider(color: Colors.grey.shade400, endIndent: 32, indent: 32),
          PaymentPriceWidget(
            fontSize: 15.99.sp,
            title: LanguageProvider.translate("global", "total"),
            price: "5641",
            isGreen: true,
          ),
        ],
      ),
    );
  }
}
