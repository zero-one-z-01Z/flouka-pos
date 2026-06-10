import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../../domain/entity/story_entity.dart';
import '../models/story_model.dart';

  class StoriesRemoteDataSource {
  final ApiHandel apiHandel;
  StoriesRemoteDataSource(this.apiHandel);

  Future<Either<DioException, StoryModel>> createStory(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/create_story', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(StoryModel.fromJson(r.data['data']));
    });
  }


  Future<Either<DioException, List<StoryModel>>> getVendorStories(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_vendor_stories', data,);
    return response.fold((l) => Left(l), (r) {
      List<StoryModel> stories = [];
      for(var element in r.data['data']){
        stories.add(StoryModel.fromJson(element));
      }
      return Right(stories);
    });
  }

  Future<Either<DioException, bool>> deleteStory(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/delete_story', data,);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }


}
