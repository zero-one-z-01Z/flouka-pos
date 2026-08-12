import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/constants/app_lotties.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/widgets/loading_animation_widget.dart';
import 'package:flouka_pos/core/widgets/price_details_widget.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../chat/presentation/pages/message_page.dart';
import '../../../chat/presentation/provider/message_provider.dart';
import '../providers/order_details_provider.dart';
import '../widgets/delivery_address_widget.dart';
import '../widgets/item_summary_section.dart';
import '../widgets/order_details_header.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    final messageProvider = Provider.of<MessageProvider>(context);
    final compact = Constants.isCompactShell(context);
    final order = orderDetailsProvider.orderEntity;

    return Scaffold(
      backgroundColor: AppColor.canvas,
      appBar: AppBar(
        backgroundColor: AppColor.surface,
        foregroundColor: AppColor.ink,
        elevation: 0,
        title: Text(
          LanguageProvider.translate('global', 'order_details'),
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            color: AppColor.ink,
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (order == null) {
            return const Center(
                child: LoadingAnimationWidget(gif: Lotties.loading));
          }
          final statusPanel = Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.sidebar,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STATUT',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: AppColor.gold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  LanguageProvider.translate(
                    'global',
                    order.vendorOrders.status.text,
                  ),
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '#FLK-${order.id} · ${order.user?.name ?? ''}',
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          );

          final scrollBody = SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OrderDetailsHeader(),
                const SizedBox(height: 12),
                const DeliveryAddressWidget(),
                const SizedBox(height: 12),
                const PriceDetailesList(),
                const SizedBox(height: 12),
                const ItemSummarySection(),
              ],
            ),
          );

          final cta = SafeArea(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              decoration: const BoxDecoration(
                color: AppColor.surface,
                border: Border(top: BorderSide(color: AppColor.hairline)),
              ),
              child: _StickyActions(provider: orderDetailsProvider),
            ),
          );

          if (compact) {
            return Column(
              children: [
                statusPanel,
                Expanded(child: scrollBody),
                cta,
              ],
            );
          }

          return Column(
            children: [
              statusPanel,
              Expanded(
                child: messageProvider.isShowChat
                    ? MasterDetailScaffold(
                        masterFlex: 3,
                        detailFlex: 2,
                        master: scrollBody,
                        detail: const MessagePage(),
                      )
                    : scrollBody,
              ),
              cta,
            ],
          );
        },
      ),
    );
  }
}

class _StickyActions extends StatelessWidget {
  const _StickyActions({required this.provider});
  final OrderDetailsProvider provider;

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];
    if (provider.canUpdateStock()) {
      buttons.add(
        Expanded(
          child: OutlinedButton(
            onPressed: provider.rejectOrderDialog,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 52),
              foregroundColor: const Color(0xFF8E2A20),
              side: const BorderSide(color: AppColor.hairline),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              LanguageProvider.translate('buttons', 'cancel_order'),
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );
      buttons.add(const SizedBox(width: 10));
      buttons.add(
        Expanded(
          flex: 2,
          child: VendorPrimaryCta(
            label: LanguageProvider.translate('buttons', 'accept_order'),
            onTap: provider.updateOrderStock,
          ),
        ),
      );
    } else if (provider.buttonMap().isNotEmpty) {
      buttons.add(
        Expanded(
          child: VendorPrimaryCta(
            label: LanguageProvider.translate(
              'buttons',
              provider.buttonMap()['title']?.toString() ?? 'ok',
            ),
            onTap: () => provider.buttonMap()['onTap'](),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
    return Row(children: buttons);
  }
}
