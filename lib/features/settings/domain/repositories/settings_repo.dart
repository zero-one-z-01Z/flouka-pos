import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/common_question_entity.dart';
import '../entities/insurance_entity.dart';
import '../entities/know_us_entity.dart';
import '../entities/settings_entity.dart';

abstract class SettingsRepo {
  Future<Either<DioException,SettingsEntity>> getSettings();
}
