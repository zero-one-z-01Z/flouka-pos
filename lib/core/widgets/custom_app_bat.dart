import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../features/home/presentation/providers/home_provider.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../../features/language/presentation/widget/language_widget.dart';
import '../../features/notification/presentation/provider/notifications_provider.dart';
import '../../features/orders/presentation/providers/orders_provider.dart';
import '../config/app_color.dart';
import '../constants/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    final OrdersProvider ordersProvider = Provider.of(context);
    final title = LanguageProvider.translate(
      'navbar',
      homeProvider.selectedNavigation.title.toLowerCase(),
    );
    final waitingCount = ordersProvider.homeOrders?.length ?? 0;
    final dateLabel = DateFormat('EEEE, d MMMM').format(DateTime.now());

    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColor.surface,
        border: Border(bottom: BorderSide(color: AppColor.hairline, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$dateLabel · $waitingCount orders waiting on you',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textSubtle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Container(
            width: 230,
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.canvas,
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Row(
              children: [
                Icon(Icons.search, size: 15, color: AppColor.textFaint),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Search orders, products…',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppColor.textFaint,
                      ),
                    ),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          const LanguageWidget(),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {
              NotificationProvider notificationProvider =
                  Provider.of(context, listen: false);
              notificationProvider.goToNotificationPage();
            },
            borderRadius: BorderRadius.circular(9),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColor.canvas,
                borderRadius: BorderRadius.circular(9),
              ),
              alignment: Alignment.center,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    Images.appBarNotification,
                    width: 17,
                    height: 17,
                  ),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: const Color(0xffB03329),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.canvas, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
