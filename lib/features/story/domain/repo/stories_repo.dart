import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/story_entity.dart';

abstract class StoriesRepo {
  Future<Either<DioException, bool>> deleteStory(Map<String, dynamic> data,);
  Future<Either<DioException, StoryEntity>> createStory(Map<String, dynamic> data,);
  Future<Either<DioException, List<StoryEntity>>> getVendorStories(Map<String, dynamic> data,);
}
