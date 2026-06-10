import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/common_question_entity.dart';
import '../entities/insurance_entity.dart';
import '../entities/know_us_entity.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repo.dart';

class SettingsUseCases {
  SettingsRepo settingsRepo;

  SettingsUseCases(this.settingsRepo);

  Future<Either<DioException, SettingsEntity>> getSettings() async {
    return settingsRepo.getSettings();
  }

}
