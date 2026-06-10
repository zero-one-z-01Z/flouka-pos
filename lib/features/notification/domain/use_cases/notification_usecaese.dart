import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/notification_entity.dart';
import '../repositories/notification_repo.dart';

class NotificationUseCases{
  NotificationRepo notificationRepo;

  NotificationUseCases(this.notificationRepo);

  Future<Either<DioException, List<NotificationEntity>>> getNotifications(Map<String,dynamic> data)async {
    return await notificationRepo.getNotifications(data);
  }
}