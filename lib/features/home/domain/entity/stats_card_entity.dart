import 'dart:ui';
import 'stat_item_entity.dart';

class StatsCardEntity {
  final String title;
  final String value;
  final String icon;
  final Color iconColor;
  final List<StatItemEntity> stats;

  StatsCardEntity({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.stats,
  });
}
