import '../../domain/entities/insurance_entity.dart';

class InsuranceModel extends InsuranceEntity {
  InsuranceModel({required super.id, required super.name, required super.description, required super.video,});

  factory InsuranceModel.fromJson(Map<String, dynamic> json) {
    return InsuranceModel(
      id: json['id'], name: json['name'],
      description: json['description'], video: json['video'],
    );
  }
}