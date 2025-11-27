import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../domain/entity/info_card_entity.dart';
import '../../domain/entity/stat_item_entity.dart';
import '../../domain/entity/stats_card_entity.dart';

class OverviewProvider extends ChangeNotifier {
  List<InfoCardEntity> infoCards = [
    InfoCardEntity(
      title: 'Products',
      subtitle: 'All products',
      svgImage: Images.products,
      backgroundColor: const Color(0xfffff5e0),
      svgBackgroundColor: const Color(0xfffe9bc),
    ),
    InfoCardEntity(
      title: 'Support',
      subtitle: 'open your ticket now',
      svgImage: Images.support,
      backgroundColor: const Color(0xffefe6f6),
      svgBackgroundColor: const Color(0xffe7d1f8),
    ),
    InfoCardEntity(
      title: 'Apple Store',
      subtitle: 'moazabdelaziz',
      svgImage: Images.appleStore,
      backgroundColor: const Color(0xffe0f8ea),
      svgBackgroundColor: const Color(0xff00a8e1),
    ),
    InfoCardEntity(
      title: 'Orders',
      subtitle: 'All orders',
      svgImage: Images.homeOrders,
      backgroundColor: const Color(0xfffceae4),
      svgBackgroundColor: const Color(0xffff8d4c8),
    ),
  ];
  List<StatsCardEntity> statsCards = [
    StatsCardEntity(
      title: 'Total Sales',
      value: '20 K US',
      icon: Images.totalSales,
      iconColor: const Color(0xFFFFB74D),
      stats: [
        StatItemEntity(label: 'Profits', value: '150 \$'),
        StatItemEntity(label: 'Net Profit', value: '150\$'),
      ],
    ),
    StatsCardEntity(
      title: 'Total Orders',
      value: '300',
      icon: Images.totalOrders,
      iconColor: const Color(0xFF4CAF50),
      stats: [
        StatItemEntity(label: 'Cancelled Orders', value: '20'),
        StatItemEntity(label: 'Active Orders', value: '10'),
      ],
    ),
    StatsCardEntity(
      title: 'Total Visits',
      value: '420',
      icon: Images.totalVisits,
      iconColor: const Color(0xFF2196F3),
      stats: [
        StatItemEntity(label: 'Last Visit', value: 'Aug 21, 2022'),
        StatItemEntity(label: 'Spending Time / Day', value: '6 Hours'),
      ],
    ),
  ];
}
