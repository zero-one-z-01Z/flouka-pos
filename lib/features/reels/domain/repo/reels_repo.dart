import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/reel_entity.dart';

abstract class ReelsRepo {
  Future<Either<DioException, bool>> deleteReel(Map<String, dynamic> data,);
  Future<Either<DioException, ReelEntity>> createReel(Map<String, dynamic> data,);
  Future<Either<DioException, List<ReelEntity>>> getVendorReels(Map<String, dynamic> data,);
}
