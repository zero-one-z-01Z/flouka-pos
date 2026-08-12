import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/order_details_provider.dart';

class OrderDetailsHeader extends StatelessWidget {
  const OrderDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LanguageProvider.translate('global', 'order_details'),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColor.textMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${LanguageProvider.translate('global', 'order_id_label')} : ${orderDetailsProvider.orderEntity?.id}',
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColor.ink,
          ),
        ),
        if (orderDetailsProvider.canUpdateStock()) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: orderDetailsProvider.rejectOrderDialog,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 44),
                    foregroundColor: const Color(0xFF8E2A20),
                    side: const BorderSide(color: AppColor.hairline),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    LanguageProvider.translate('buttons', 'cancel_order'),
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: VendorPrimaryCta(
                  label: LanguageProvider.translate('buttons', 'accept_order'),
                  onTap: orderDetailsProvider.updateOrderStock,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
