// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flouka_pos/features/orders/presentation/providers/orders_provider.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/chat/presentation/provider/message_provider.dart';
import '../../features/tickets/presentation/provider/ticket_message_provider.dart';
import '../constants/constants.dart';
import '../models/local_notifications.dart';
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
      // int orderId = convertStringToInt(jsonDecode(payload['data_']));
      OrdersProvider orderProvider = Constants.globalContext().read();
      if(orderProvider.data!=null){
        orderProvider.refresh();
      }
    } else if (payload['message_type_'] == "chat") {
      Map message = jsonDecode(payload['data_']);
      MessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
      bool check = messageProvider.checkMessageOfThisChat(convertStringToInt(message['chat_id']));
      if(check){
        showNotificationLocal = false;
      }

    }else
    if(payload['message_type_']=="ticket"){
      Map message = jsonDecode(payload['data_']);
      TicketMessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
      bool check = messageProvider.checkMessageOfThisChat(convertStringToInt(message['ticket_id']));
      if(check){
        showNotificationLocal = false;
      }
    }else
    if(payload['message_type_']=="ticket_status"){
      int id = convertStringToInt(jsonDecode(payload['data_']));
      TicketMessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
      await messageProvider.getTicketDetails(id:id ,fromNoti: true);
    }
  }
  if(click&&AuthProvider.isLogin()&&fromWhereClicked==2){
    clickNoti(jsonEncode(payload));
    NotificationLocalClass.notificationsPlugin.cancelAll();
  }
  if(showNotificationLocal&&AuthProvider.isLogin()&&!click){
    NotificationLocalClass.showNoti(title: data2.title??"", body: data2.body??"", payload: jsonEncode(payload));
  }
}
