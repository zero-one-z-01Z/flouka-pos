import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/settings_repo.dart';
import '../datasources/remote.dart';
import '../models/common_question_model.dart';
import '../models/insurance_model.dart';
import '../models/know_us_model.dart';
import '../models/settings_model.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsRemoteDataSource settingsRemoteDataSource;

  SettingsRepoImpl(this.settingsRemoteDataSource);

  @override
  Future<Either<DioException, SettingsModel>> getSettings() async {
    return settingsRemoteDataSource.getSettings();
  }

}
