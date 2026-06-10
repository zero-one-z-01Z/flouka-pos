import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/story_entity.dart';
import '../repo/stories_repo.dart';

class StoriesUseCase {
  final StoriesRepo storiesRepo;

  StoriesUseCase(this.storiesRepo);


  Future<Either<DioException, StoryEntity>> createStory(Map<String, dynamic> data,) async {
    return await storiesRepo.createStory(data);
  }

  Future<Either<DioException, bool>> deleteStory(Map<String, dynamic> data,) async {
    return await storiesRepo.deleteStory(data);
  }

  Future<Either<DioException, List<StoryEntity>>> getVendorStories(Map<String, dynamic> data,) async {
    return await storiesRepo.getVendorStories(data);
  }


}
