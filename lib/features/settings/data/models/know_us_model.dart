
import '../../domain/entities/know_us_entity.dart';

class KnowUsModel extends KnowUsEntity {
   KnowUsModel({required super.id,required super.image, required super.name});

  factory KnowUsModel.fromJson(Map<String, dynamic> data) {
    return KnowUsModel(id: data['id'], image: data['image'], name: data['name']);
  }
}
