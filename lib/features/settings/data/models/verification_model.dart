
import '../../domain/entities/verification_entity.dart';

class VerificationModel extends VerificationEntity {
  const VerificationModel(
      {required super.id, required super.title, required super.description});
  factory VerificationModel.fromJson(Map<String, dynamic> data) {
    return VerificationModel(
        id: data['id'], title: data['title'], description: data['description']);
  }
}
