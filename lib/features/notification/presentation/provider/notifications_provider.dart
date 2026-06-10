import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../core/dialog/guest_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../../core/models/pagination_class.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/use_cases/notification_usecaese.dart';
import '../pages/notification_page.dart';

class NotificationProvider extends ChangeNotifier implements PaginationClass {
  List<NotificationEntity>? notifications;

  final NotificationUseCases notificationUseCases;
  NotificationProvider(this.notificationUseCases);

  @override
  int pageIndex = 1;
  void clear() {
    notifications = null;
    paginationStarted = false;
    paginationFinished = false;
    pageIndex = 1;
    notifyListeners();
  }

  Future getNotifications() async {
    Map<String, dynamic> data = {};
    data['pages'] = pageIndex;
    Either<DioException, List<NotificationEntity>> value =
        await notificationUseCases.getNotifications(data);
    value.fold(
      (l) {
        showToast(l.message!);
      },
      (r) {
        pageIndex++;
        notifications ??= [];
        notifications?.addAll(r);
        notifications!.add(NotificationEntity(title: "title", description: "description", createdAt: DateTime.now()));
        if (r.isEmpty) {
          paginationFinished = true;
          notifyListeners();
        }
      },
    );
    paginationStarted = false;
    notifyListeners();
  }

  bool listNotEmpty() {
    return notifications != null && notifications!.isNotEmpty;
  }

  bool isDetails = false;
  void setIsDetails(bool value) {
    isDetails = value;
    notifyListeners();
  }

  void clearDetails() {
    setIsDetails(false);
    notification = null;
    notifyListeners();
  }

  NotificationEntity? notification;
  void setNotification(NotificationEntity value) {
    setIsDetails(true);
    notification = value;
    notifyListeners();
  }
  Future refresh() async {
    clear();
    getNotifications();
  }

  @override
  bool paginationFinished = false;

  @override
  bool paginationStarted = false;
  ScrollController controller = ScrollController();
  @override
  void pagination() {
    controller.addListener(() async {
      if (controller.position.atEdge && controller.position.pixels > 50) {
        if (!paginationFinished &&
            !paginationStarted &&
            notifications != null &&
            notifications!.isNotEmpty) {
          paginationStarted = true;
          notifyListeners();
          await getNotifications();
        }
      }
    });
  }

  void goToNotificationPage() {
    String? token = sharedPreferences.getString("token");
    if (token != null) {
      refresh();
      navP(NotificationPage());
    } else {
      showGuestDialog();
    }
  }
}
