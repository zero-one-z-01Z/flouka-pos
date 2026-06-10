import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper_function/api.dart';
import '../models/notification_model.dart';

class NotificationRemoteDataSource {
  final ApiHandel apiHandel;
  NotificationRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<NotificationModel>>> getNotifications(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.get('get_notifications', data);
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        List<NotificationModel> list = [];
        for (var i in r.data['data']) {
          list.add(NotificationModel.fromJson(i));
        }
        return Right(list);
      },
    );
  }
}
