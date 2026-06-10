import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../story/data/models/story_model.dart';
import '../../domain/repo/reels_repo.dart';
import '../data_source/reels_remote_data_source.dart';
import '../models/reel_model.dart';

class ReelsRepoImpl implements ReelsRepo {
  final ReelsRemoteDataSource reelsRemoteDataSource;

  ReelsRepoImpl(this.reelsRemoteDataSource);

  @override
  Future<Either<DioException, ReelModel>> createReel(Map<String, dynamic> data,) async {
    return await reelsRemoteDataSource.createReel(data);
  }

  @override
  Future<Either<DioException, List<ReelModel>>> getVendorReels(Map<String, dynamic> data,) async {
    return await reelsRemoteDataSource.getVendorReels(data);
  }

  @override
  Future<Either<DioException, bool>> deleteReel(Map<String, dynamic> data,) async {
    return await reelsRemoteDataSource.deleteReel(data);
  }
}
