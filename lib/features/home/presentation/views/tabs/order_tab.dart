import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/constants/app_lotties.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/widgets/empty_widget.dart';
import 'package:flouka_pos/core/widgets/loading_animation_widget.dart';
import 'package:flouka_pos/core/widgets/loading_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../orders/presentation/providers/orders_provider.dart';
import '../../../../orders/presentation/widgets/list_order_tabs_widget.dart';
import '../../../../orders/presentation/widgets/order_card_widget.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    ordersProvider.pagination();
    final compact = Constants.isCompactShell(context);

    return RefreshIndicator(
      onRefresh: () => ordersProvider.refresh(),
      child: SingleChildScrollView(
        controller: ordersProvider.controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              LanguageProvider.translate('global', 'orders'),
              style: GoogleFonts.bricolageGrotesque(
                fontSize: compact ? 22 : 18,
                fontWeight: FontWeight.w800,
                color: AppColor.ink,
              ),
            ),
            const SizedBox(height: 12),
            const ListOrderTabsWidget(),
            const SizedBox(height: 16),
            Builder(
              builder: (context) {
                if (ordersProvider.data == null) {
                  return const Center(
                    child: LoadingAnimationWidget(gif: Lotties.loading),
                  );
                }
                if (ordersProvider.data!.isEmpty) {
                  return const Center(
                    child: EmptyWidget(image: Lotties.noOrders, title: ''),
                  );
                }
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final cols = constraints.maxWidth > 1100
                        ? 3
                        : constraints.maxWidth > 700
                            ? 2
                            : 1;
                    final gap = 12.0;
                    final w = cols == 1
                        ? constraints.maxWidth
                        : (constraints.maxWidth - gap * (cols - 1)) / cols;
                    return Wrap(
                      spacing: gap,
                      runSpacing: gap,
                      children: ordersProvider.data!
                          .map(
                            (o) => SizedBox(
                              width: w,
                              child: OrderCardWidget(
                                orderEntity: o,
                                withButton: true,
                                compact: true,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            if (ordersProvider.paginationStarted) const LoadingWidget(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
