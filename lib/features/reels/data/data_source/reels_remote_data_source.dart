import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../../domain/entity/reel_entity.dart';
import '../models/reel_model.dart';

  class ReelsRemoteDataSource {
  final ApiHandel apiHandel;
  ReelsRemoteDataSource(this.apiHandel);

  Future<Either<DioException, ReelModel>> createReel(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/create_reel', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(ReelModel.fromJson(r.data['data']));
    });
  }


  Future<Either<DioException, List<ReelModel>>> getVendorReels(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_vendor_reels', data,);
    return response.fold((l) => Left(l), (r) {
      List<ReelModel> stories = [];
      for(var element in r.data['data']){
        stories.add(ReelModel.fromJson(element));
      }
      return Right(stories);
    });
  }

  Future<Either<DioException, bool>> deleteReel(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/delete_reel', data,);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }


}
