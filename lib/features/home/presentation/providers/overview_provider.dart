import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../domain/entity/info_card_entity.dart';

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
}
