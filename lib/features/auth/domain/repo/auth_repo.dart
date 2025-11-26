import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<DioException, String>> sendOtpCode(Map<String, dynamic> data);
  Future<Either<DioException, UserEntity>> checkCode(Map<String, dynamic> data);
  Future<Either<DioException, UserEntity>> getProfile();
  Future<Either<DioException, String>> deleteAccount();
  Future<Either<DioException, String>> logout(Map<String, dynamic> data);
  Future<Either<DioException, String>> refreshToken(Map<String, dynamic> data);
  Future<Either<DioException, UserEntity>> socialLogin(
    Map<String, dynamic> data,
  );

  Future<Either<DioException, UserEntity>> updateProfile(
    Map<String, dynamic> data,
  );

  Future<Either<DioException, UserEntity>> login(Map<String, dynamic> data);
}
