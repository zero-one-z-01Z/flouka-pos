import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity{
  NotificationModel({required super.title, required super.description, required super.createdAt});


  factory NotificationModel.fromJson(Map data){
    return NotificationModel(title: data['title'], description: data['description'], createdAt: DateTime.parse(data['created_at']));
  }

}