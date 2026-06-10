import '../../../../../core/helper_function/convert.dart';
import '../../domain/entities/reward_entity.dart';

class RewardModel extends RewardEntity {
  RewardModel({
    required super.id,
    required super.title,
    required super.rewarded,
    required super.favoritesCount,
    required super.rate,
  });
  factory RewardModel.fromJson(Map<String, dynamic> data) {
    return RewardModel(
      id: data['id'],
      rewarded: data['rewarded'],
      title: data['title'],
      favoritesCount: data['favorites_count'],
      rate: data['rate'] == null ? 0 : convertDataToNum(data['rate'])!,
    );
  }
}
