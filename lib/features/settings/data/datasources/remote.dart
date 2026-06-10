import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/helper_function/api.dart';
import '../models/common_question_model.dart';
import '../models/insurance_model.dart';
import '../models/know_us_model.dart';
import '../models/settings_model.dart';

class SettingsRemoteDataSource {
  final ApiHandel apiHandel;
  SettingsRemoteDataSource(this.apiHandel);

  Future<Either<DioException, SettingsModel>> getSettings() async {
    var response = await apiHandel.get('get_settings');
    SettingsModel settingsModel;
    return response.fold((l) => Left(l), (r) {
      settingsModel = SettingsModel.fromJson(r.data['data']);
      return Right(settingsModel);
    });
  }

}
