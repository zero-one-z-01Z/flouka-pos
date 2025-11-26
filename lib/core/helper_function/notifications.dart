// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'convert.dart';

Future notificationsFirebase() async {
  FirebaseMessaging.onMessage.listen((event) async {
    if (event.notification != null) {
      appNotifications(
        event.notification!,
        payload: event.data,
        fromWhereClicked: 1,
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    if (event.notification != null) {
      appNotifications(
        event.notification!,
        click: true,
        fromWhereClicked: 2,
        payload: event.data,
      );
    }
  });
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    sound: true,
    badge: false,
    alert: true,
    criticalAlert: true,
    provisional: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  } else {}
}

void appNotifications(
  RemoteNotification data2, {
  bool click = false,
  bool start = false,
  Map? payload,
  required int fromWhereClicked,
}) async {
  bool showNotificationLocal = true;

  if (payload!.containsKey('message_type_')) {
    if (payload['message_type_'] == "order") {
      int orderId = convertStringToInt(jsonDecode(payload['data_']));
      // OrderDetailsProvider orderDetailsProvider = Provider.of(Constants.globalContext(),listen: false);
      // if(orderDetailsProvider.ordersDetails!=null&&orderDetailsProvider.ordersDetails!.id==orderId){
      //   orderDetailsProvider.getOrderDetailsData(id: orderId,updateOrderPage: true);
      // }
    } else if (payload['message_type_'] == "chat") {
      Map message = jsonDecode(payload['data_']);
      // MessageModel messageModel = MessageModel.fromJson(message);
      // MessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
      // bool check = messageProvider.checkMessageOfThisChat(convertStringToInt(message['chat']['id']));
      // if(check){
      //   messageProvider.addOneMessage(messageModel);
      //   showNotificationLocal = false;
      // }
    } else if (payload['message_type_'] == "comment") {
      int adId = convertStringToInt(jsonDecode(payload['data_']));
      // OrderDetailsProvider orderDetailsProvider = Provider.of(Constants.globalContext(),listen: false);
      // if(orderDetailsProvider.ordersDetails!=null&&orderDetailsProvider.ordersDetails!.id==adId){
      //   showNotificationLocal = false;
      // }
    } else if (payload['message_type_'] == "replay") {
      int adId = convertStringToInt(jsonDecode(payload['data_']));
      // OrderDetailsProvider orderDetailsProvider = Provider.of(Constants.globalContext(),listen: false);
      // if(orderDetailsProvider.ordersDetails!=null&&orderDetailsProvider.ordersDetails!.id==adId){
      //   showNotificationLocal = false;
      // }
    }
  }
  // if(click&&AuthProvider.isLogin()&&fromWhereClicked==2){
  //   clickNoti(jsonEncode(payload));
  //   NotificationLocalClass.notificationsPlugin.cancelAll();
  // }
  // if(showNotificationLocal&&AuthProvider.isLogin()&&!click){
  //   NotificationLocalClass.showNoti(title: data2.title??"", body: data2.body??"", payload: jsonEncode(payload));
  // }
}
