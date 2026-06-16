import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/core/helper_function/prefs.dart';
import '../../../../core/helper_function/api.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiHandel apiHandel;
  AuthRemoteDataSource(this.apiHandel);

  Future<Either<DioException, UserModel>> socialLogin(
    Map<String, dynamic> data,
  ) async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store' : 'vendor';
    var response = await apiHandel.post('$userType/social_login', data);
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }

  Future<Either<DioException, UserModel>> getProfile() async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store' : 'vendor';
    var response = await apiHandel.get('$userType/get_profile');
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }

  Future<Either<DioException, String>> logout(Map<String, dynamic> data) async {
    var response = await apiHandel.post('vendor/logout', data);
    return response.fold((l) => Left(l), (r) => Right(r.data['data']));
  }

  Future<Either<DioException, String>> deleteAccount() async {
    var response = await apiHandel.post('vendor/delete_account', {});
    return response.fold((l) => Left(l), (r) => Right(r.data['data']));
  }

  Future<Either<DioException, UserModel>> updateProfile(
    Map<String, dynamic> data,
  ) async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store' : 'vendor';

    var response = await apiHandel.post('$userType/update_profile', data);
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }

  Future<Either<DioException, String>> refreshToken(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('refresh_token', data);
    return response.fold((l) => Left(l), (r) => Right(r.data['token']));
  }

  Future<Either<DioException, UserModel>> checkCode(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('vendor/check_code', data);
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }

  Future<Either<DioException, String>> sendOtp(Map<String, dynamic> data) async {
    var response = await apiHandel.post('vendor/send_otp_code', data);
    return response.fold((l) => Left(l), (r) => const Right(""));
  }

  Future<Either<DioException, UserModel>> login(Map<String, dynamic> data) async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store' : 'vendor';

    var response = await apiHandel.post('$userType/login', data);
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }

  Future<Either<DioException, void>> register(Map<String, dynamic> data) async {
    var response = await apiHandel.post('vendor/register', data);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }
}
