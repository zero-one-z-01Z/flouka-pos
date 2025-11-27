import 'package:flutter/material.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';

import '../../../../core/constants/app_images.dart';
import '../../domain/entity/info_card_entity.dart';
import '../../domain/entity/stat_item_entity.dart';
import '../../domain/entity/stats_card_entity.dart';

class OverviewProvider extends ChangeNotifier {
  List<InfoCardEntity> infoCards = [
    InfoCardEntity(
      title: LanguageProvider.translate('global', 'products'),
      subtitle: LanguageProvider.translate('global', 'all_products'),
      svgImage: Images.products,
      backgroundColor: const Color(0xfffff5e0),
      svgBackgroundColor: const Color(0xfffe9bc),
    ),
    InfoCardEntity(
      title: LanguageProvider.translate('global', 'support'),
      subtitle: LanguageProvider.translate('global', 'open_ticket'),
      svgImage: Images.support,
      backgroundColor: const Color(0xffefe6f6),
      svgBackgroundColor: const Color(0xffe7d1f8),
    ),
    InfoCardEntity(
      title: LanguageProvider.translate('global', 'APPLESTORE'),
      subtitle: 'moazabdelaziz',
      svgImage: Images.appleStore,
      backgroundColor: const Color(0xffe0f8ea),
      svgBackgroundColor: const Color(0xff00a8e1),
    ),
    InfoCardEntity(
      title: LanguageProvider.translate('global', 'orders'),
      subtitle: LanguageProvider.translate('global', 'all_orders'),
      svgImage: Images.homeOrders,
      backgroundColor: const Color(0xfffceae4),
      svgBackgroundColor: const Color(0xffff8d4c8),
    ),
  ];
  List<StatsCardEntity> statsCards = [
    StatsCardEntity(
      title: LanguageProvider.translate('global', 'total_sales'),
      value: '20 K US',
      icon: Images.totalSales,
      iconColor: const Color(0xFFFFB74D),
      stats: [
        StatItemEntity(
          label: LanguageProvider.translate('global', 'profits'),
          value: '150 \$',
        ),
        StatItemEntity(
          label: LanguageProvider.translate('global', 'net_profit'),
          value: '150\$',
        ),
      ],
    ),
    StatsCardEntity(
      title: LanguageProvider.translate('global', 'total_orders'),
      value: '300',
      icon: Images.totalOrders,
      iconColor: const Color(0xFF4CAF50),
      stats: [
        StatItemEntity(
          label: LanguageProvider.translate('global', 'cancelled_orders'),
          value: '20',
        ),
        StatItemEntity(
          label: LanguageProvider.translate('global', 'active_orders'),
          value: '10',
        ),
      ],
    ),
    StatsCardEntity(
      title: LanguageProvider.translate('global', 'total_visits'),
      value: '420',
      icon: Images.totalVisits,
      iconColor: const Color(0xFF2196F3),
      stats: [
        StatItemEntity(
          label: LanguageProvider.translate('global', 'last_visit'),
          value: 'Aug 21, 2022',
        ),
        StatItemEntity(
          label: LanguageProvider.translate('global', 'spending_time'),
          value: '6 Hours',
        ),
      ],
    ),
  ];
}
