import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/widgets/empty_animation.dart';
import 'package:flouka_pos/core/widgets/loading_animation_widget.dart';
import 'package:flouka_pos/features/home/presentation/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../../home/domain/entity/navigation_entity.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/orders_provider.dart';
import 'list_order_tabs_widget.dart';
import 'order_card_widget.dart';

class OrderSection extends StatelessWidget {
  const OrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(LanguageProvider.translate('global', 'order_list'),
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            const ListOrderTabsWidget(isHome: true,),
            InkWell(
              onTap: () {
                HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                NavigationEntity navigation= homeProvider.navigationList.firstWhere((nav) => nav.title == "Orders",);
                homeProvider.setSelectedNavigation(navigation);

              },
              child: Text(LanguageProvider.translate('global', 'show_all'),
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold,color: AppColor.primaryColor),
              ),
            ),

          ],
        ),
        SizedBox(height: 4.h),
        // Order Cards
        Builder(
          builder: (context) {
            if (ordersProvider.homeOrders == null) {
              return const Center(
                child: LoadingAnimationWidget(gif: Lotties.loading),
              );
            }else if (ordersProvider.homeOrders!.isEmpty) {
              return const Center(
                child: EmptyAnimation(title: "", gif: Lotties.noOrders),
              );
            }
            return Wrap(
              runSpacing: 1.h,spacing: 2.w,
              children: List.generate(ordersProvider.homeOrders!.length,
                      (index) => OrderCardWidget(orderEntity: ordersProvider.homeOrders![index],withButton: true,)),
            );
          },
        ),
      ],
    );
  }
}
