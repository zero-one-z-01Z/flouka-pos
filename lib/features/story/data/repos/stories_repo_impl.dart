import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/story_entity.dart';
import '../../domain/repo/stories_repo.dart';
import '../data_source/stories_remote_data_source.dart';

class StoriesRepoImpl implements StoriesRepo {
  final StoriesRemoteDataSource storiesRemoteDataSource;

  StoriesRepoImpl(this.storiesRemoteDataSource);

  @override
  Future<Either<DioException, StoryEntity>> createStory(Map<String, dynamic> data,) async {
    return await storiesRemoteDataSource.createStory(data);
  }

  @override
  Future<Either<DioException, List<StoryEntity>>> getVendorStories(Map<String, dynamic> data,) async {
    return await storiesRemoteDataSource.getVendorStories(data);
  }

  @override
  Future<Either<DioException, bool>> deleteStory(Map<String, dynamic> data,) async {
    return await storiesRemoteDataSource.deleteStory(data);
  }
}
