import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repo.dart';
import '../data_sources/remote.dart';

class NotificationRepoImpl implements NotificationRepo{
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRepoImpl(this.notificationRemoteDataSource);

  @override
  Future<Either<DioException, List<NotificationEntity>>> getNotifications(Map<String,dynamic> data)async {
    return await notificationRemoteDataSource.getNotifications(data);
  }


}