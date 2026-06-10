import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/reel_entity.dart';
import '../repo/reels_repo.dart';

class ReelsUseCases {
  final ReelsRepo storiesRepo;

  ReelsUseCases(this.storiesRepo);


  Future<Either<DioException, ReelEntity>> createReel(Map<String, dynamic> data,) async {
    return await storiesRepo.createReel(data);
  }

  Future<Either<DioException, bool>> deleteReel(Map<String, dynamic> data,) async {
    return await storiesRepo.deleteReel(data);
  }

  Future<Either<DioException, List<ReelEntity>>> getVendorReels(Map<String, dynamic> data,) async {
    return await storiesRepo.getVendorReels(data);
  }


}
