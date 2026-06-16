import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../../features/orders/presentation/providers/order_details_provider.dart';
import '../config/app_styles.dart';
import 'payment_price_widget.dart';

class PriceDetailesList extends StatelessWidget {
  const PriceDetailesList({super.key});
  @override
  Widget build(BuildContext context) {
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    return Container(
      width: 23.w,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            LanguageProvider.translate("global", "total_price"),
            style: TextStyleClass.normalStyle().copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          PaymentPriceWidget(
            fontSize: 16.sp,
            title: LanguageProvider.translate("global", "price"),
            price: orderDetailsProvider.orderEntity!.subTotal.toString(),
          ),
          // Divider(color: Colors.grey.shade400, endIndent: 32, indent: 32),
          // PaymentPriceWidget(
          //   fontSize: 16.sp,
          //   title: LanguageProvider.translate("global", "Shiping"),
          //   price: orderDetailsProvider.orderEntity!.tax.toString(),
          // ),
          Divider(color: Colors.grey.shade400, endIndent: 32, indent: 32),
          PaymentPriceWidget(
            fontSize: 16.sp,
            title: LanguageProvider.translate("global", "Taxes"),
            price: orderDetailsProvider.orderEntity!.tax.toString(),
          ),
          if(orderDetailsProvider.orderEntity!.discount !=null && orderDetailsProvider.orderEntity!.discount! >0)...[
            Divider(color: Colors.grey.shade400, endIndent: 32, indent: 32),
            PaymentPriceWidget(
              fontSize: 15.99.sp,
              title: LanguageProvider.translate("global", "discount"),
              price: orderDetailsProvider.orderEntity!.discount.toString(),

            ),

          ],
          Divider(color: Colors.grey.shade400, endIndent: 32, indent: 32),
          PaymentPriceWidget(
            fontSize: 15.99.sp,
            title: LanguageProvider.translate("global", "delivery"),
            price: orderDetailsProvider.orderEntity!.deliveryPrice.toString(),

          ),
          Divider(color: Colors.grey.shade400, endIndent: 32, indent: 32),
          PaymentPriceWidget(
            fontSize: 15.99.sp,
            title: LanguageProvider.translate("global", "total"),
            price: orderDetailsProvider.orderEntity!.total.toString(),

            isGreen: true,
          ),
        ],
      ),
    );
  }
}
