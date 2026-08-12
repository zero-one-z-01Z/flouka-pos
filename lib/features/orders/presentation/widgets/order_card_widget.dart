import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/helper_function/convert.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/order_entity.dart';
import '../providers/order_details_provider.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderEntity orderEntity;
  final bool withButton;
  final bool compact;
  const OrderCardWidget({
    super.key,
    required this.orderEntity,
    required this.withButton,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final OrderDetailsProvider orderDetailsProvider =
        Provider.of<OrderDetailsProvider>(context, listen: false);
    final statusText = LanguageProvider.translate(
      'global',
      orderEntity.vendorOrders.status.text,
    );
    final canAct = withButton &&
        orderEntity.vendorOrders.status == VendorOrderStatus.pending;

    return Material(
      color: AppColor.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: withButton
            ? () => orderDetailsProvider.goToOrderDetailsView(orderEntity.id)
            : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: compact ? double.infinity : null,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.hairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '#FLK-${orderEntity.id}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColor.ink,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColor.canvas,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText.toUpperCase(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: orderEntity.vendorOrders.status.color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                orderEntity.user?.name ?? 'Client',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColor.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${orderEntity.address.address} · ${convertDateTimeToStringDMY(DateTime.parse(orderEntity.createdAt))}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: AppColor.textMuted,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${orderEntity.total} DT · ${orderEntity.paymentMethod}',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColor.ink,
                ),
              ),
              if (canAct) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          orderDetailsProvider.goToOrderDetailsView(orderEntity.id);
                          // reject after load via dialog from details; quick path:
                          Future.delayed(const Duration(milliseconds: 400), () {
                            orderDetailsProvider.rejectOrderDialog();
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF8E2A20),
                          side: const BorderSide(color: AppColor.hairline),
                          minimumSize: const Size(0, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Refuser',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: VendorPrimaryCta(
                        label: 'Confirmer',
                        onTap: () {
                          orderDetailsProvider
                              .goToOrderDetailsView(orderEntity.id);
                          Future.delayed(const Duration(milliseconds: 400), () {
                            if (orderDetailsProvider.canUpdateStock()) {
                              orderDetailsProvider.updateOrderStock();
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
