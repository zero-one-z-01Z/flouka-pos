import '../../../../../core/helper_function/convert.dart';
import '../../domain/entities/price_step_entity.dart';

class PriceStepModel extends PriceStepEntity {
  PriceStepModel({
    required super.id,
    required super.to,
    required super.from,
    required super.price,
  });

  factory PriceStepModel.fromJson(Map<String, dynamic> data) {
    return PriceStepModel(
      id: data['id'],
      to: convertDataToNum(data['to'])!,
      from: convertDataToNum(data['from'])!,
      price: convertDataToNum(data['price'])!,
    );
  }
}
