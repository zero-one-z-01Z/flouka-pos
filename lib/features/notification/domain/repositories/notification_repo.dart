import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/notification_entity.dart';

abstract class NotificationRepo{
  Future<Either<DioException,List<NotificationEntity>>> getNotifications(Map<String,dynamic> data);
}