import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource userRemoteDatasource;

  AuthRepoImpl(this.userRemoteDatasource);
  @override
  Future<Either<DioException, String>> deleteAccount() async {
    return await userRemoteDatasource.deleteAccount();
  }

  @override
  Future<Either<DioException, UserEntity>> getProfile() async {
    return await userRemoteDatasource.getProfile();
  }

  @override
  Future<Either<DioException, UserEntity>> socialLogin(
    Map<String, dynamic> data,
  ) async {
    return await userRemoteDatasource.socialLogin(data);
  }

  @override
  Future<Either<DioException, String>> logout(Map<String, dynamic> data) async {
    return await userRemoteDatasource.logout(data);
  }

  @override
  Future<Either<DioException, String>> refreshToken(
    Map<String, dynamic> data,
  ) async {
    return await userRemoteDatasource.refreshToken(data);
  }

  @override
  Future<Either<DioException, UserEntity>> updateProfile(
    Map<String, dynamic> data,
  ) async {
    return await userRemoteDatasource.updateProfile(data);
  }

  @override
  Future<Either<DioException, UserEntity>> checkCode(
    Map<String, dynamic> data,
  ) {
    return userRemoteDatasource.checkCode(data);
  }

  @override
  Future<Either<DioException, String>> sendOtpCode(Map<String, dynamic> data) {
    return userRemoteDatasource.sendOtp(data);
  }

  @override
  Future<Either<DioException, UserEntity>> login(Map<String, dynamic> data) {
    return userRemoteDatasource.login(data);
  }
 
}
