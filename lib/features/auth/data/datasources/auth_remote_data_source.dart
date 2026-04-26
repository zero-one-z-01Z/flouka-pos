import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiHandel apiHandel;
  AuthRemoteDataSource(this.apiHandel);

  Future<Either<DioException, UserModel>> socialLogin(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('store/social_login', data);
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }

  Future<Either<DioException, UserModel>> getProfile() async {
    var response = await apiHandel.get('store/get_profile');
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }

  Future<Either<DioException, String>> logout(Map<String, dynamic> data) async {
    var response = await apiHandel.post('store/logout', data);
    return response.fold((l) => Left(l), (r) => Right(r.data['data']));
  }

  Future<Either<DioException, String>> deleteAccount() async {
    var response = await apiHandel.post('store/delete_account', {});
    return response.fold((l) => Left(l), (r) => Right(r.data['data']));
  }

  Future<Either<DioException, UserModel>> updateProfile(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('store/update_profile', data);
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
    var response = await apiHandel.post('store/check_code', data);
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }

  Future<Either<DioException, String>> sendOtp(Map<String, dynamic> data) async {
    var response = await apiHandel.post('store/send_otp_code', data);
    return response.fold((l) => Left(l), (r) => Right(r.data['data']));
  }

  Future<Either<DioException, UserModel>> login(Map<String, dynamic> data) async {
    var response = await apiHandel.post('store/login', data);
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }

  Future<Either<DioException, UserModel>> register(Map<String, dynamic> data) async {
    var response = await apiHandel.post('store/register', data);
    return response.fold(
      (l) => Left(l),
      (r) => Right(UserModel.fromJson(r.data['data'])),
    );
  }
}
