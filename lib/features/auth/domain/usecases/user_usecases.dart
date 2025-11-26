import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/user_entity.dart';
import '../repo/auth_repo.dart';

class AuthUseCase {
  AuthRepo userRepo;
  AuthUseCase(this.userRepo);

  Future<Either<DioException, String>> deleteAccount() async {
    return await userRepo.deleteAccount();
  }

  Future<Either<DioException, UserEntity>> getProfile() async {
    return await userRepo.getProfile();
  }

  Future<Either<DioException, UserEntity>> socialLogin(
    Map<String, dynamic> data,
  ) async {
    return await userRepo.socialLogin(data);
  }

  Future<Either<DioException, String>> logout(Map<String, dynamic> data) async {
    return await userRepo.logout(data);
  }

  Future<Either<DioException, String>> refreshToken(
    Map<String, dynamic> data,
  ) async {
    return await userRepo.refreshToken(data);
  }

  Future<Either<DioException, UserEntity>> updateProfile(
    Map<String, dynamic> data,
  ) async {
    return await userRepo.updateProfile(data);
  }

  Future<Either<DioException, String>> sendOtp(
    Map<String, dynamic> data,
  ) async {
    return await userRepo.sendOtpCode(data);
  }

  Future<Either<DioException, UserEntity>> checkCode(
    Map<String, dynamic> data,
  ) async {
    return await userRepo.checkCode(data);
  }
    Future<Either<DioException, UserEntity>> login(
    Map<String, dynamic> data,
  ) async {
    return await userRepo.login(data);
  }
}
