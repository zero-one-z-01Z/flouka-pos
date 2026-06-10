import 'package:equatable/equatable.dart';

class RewardEntity extends Equatable {
  final int id;
  // final String status;
  final num rewarded;
  final String title;
  final int favoritesCount;
  final num rate;
  bool? isSelected;

  RewardEntity({
    required this.id,
    // required this.status,
    required this.rewarded,
    required this.title,
    required this.favoritesCount,
    required this.rate,
  });

  @override
  List<Object?> get props => [
    id,
    // status,
    rewarded,
    title,
    favoritesCount,
    rate,
  ];
}
