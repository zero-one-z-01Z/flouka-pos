import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../helper_function/convert.dart';
import '../helper_function/helper_function.dart';

class NotificationLocalClass {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future notificationDet() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'test',
        'c_name',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        playSound: true,
        channelShowBadge: true,
        channelDescription: 'c_des',
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future showNoti({
    int? id,
    required String title,
    required String body,
    required String payload,
  }) async {
    try {
      notificationsPlugin.show(
        id ?? DateTime.now().millisecond,
        title,
        body,
        await notificationDet(),
        payload: payload,
      );
      delay(2500).then((value) => notificationsPlugin.cancelAll());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future init({bool initScheduled = false}) async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('logo'),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        defaultPresentBadge: true,
        // onDidReceiveLocalNotification: (id,title,body,pay)async{

        //   clickNoti(pay!);

        // }
      ),
    );
    await notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (pay) async {
        clickNoti(pay.payload!);
      },
      // onDidReceiveBackgroundNotificationResponse: localMessagingBackgroundHandler,
    );
  }
}

void clickNoti(String pay) async {
  Map payload = jsonDecode(pay);
  // if(AuthProvider.isLogin()){
  if (payload.containsKey('message_type_')) {
    if (payload['message_type_'] == "chat") {
      Map message = jsonDecode(payload['data_']);
      message['chat'];
      // MessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
      // bool check = messageProvider.checkMessageOfThisChat(convertStringToInt(message['chat']['id']));
      // if(!check){
      //   int sellerId = convertStringToInt(chat['seller_id']);
      //   int buyerId = convertStringToInt(chat['buyer_id']);
      //   int addId = convertStringToInt(chat['add_id']);
      //
      //   if(messageProvider.chatEntity==null){
      //     messageProvider.goToMessagePage(sellerId: sellerId,buyerId: buyerId, adId: addId,);
      //   }else{
      //     messageProvider.getMessages(sellerId: sellerId,buyerId: buyerId, adId: addId,);
      //   }
    }
  } else if (payload['message_type_'] == "order") {
    convertStringToInt(jsonDecode(payload['data_']));
    // OrderDetailsProvider orderDetailsProvider = Provider.of(Constants.globalContext(),listen: false);
    // if(orderDetailsProvider.ordersDetails!=null&&orderDetailsProvider.ordersDetails!.id!=orderId){
    //   orderDetailsProvider.getOrderDetailsData(id: orderId);
    // }
    // if(orderDetailsProvider.ordersDetails==null){
    //   orderDetailsProvider.goToOrderDetailsHome(id: orderId);
    // }
  } else if (payload['message_type_'] == "comment") {
    convertStringToInt(jsonDecode(payload['data_']));
    // OrderDetailsProvider orderDetailsProvider = Provider.of(Constants.globalContext(),listen: false);
    // if(orderDetailsProvider.ordersDetails!=null&&orderDetailsProvider.ordersDetails!.id!=adId){
    //   orderDetailsProvider.refresh(adId);
    // }
    // if(orderDetailsProvider.ordersDetails==null){
    //   orderDetailsProvider.goToOrderDetailsHome(id: adId);
    // }
    // }
    // }
  }
}
