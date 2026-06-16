import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/features/tickets/presentation/provider/add_ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../../../../core/helper_function/image.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widgets/img_preview_widget.dart';
import '../../../../injection_container.dart';
import '../../data/models/ticket_message_model.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/tickets_use_case.dart';
import 'tickets_provider.dart';

class TicketMessageProvider extends ChangeNotifier{

  TicketEntity? ticketEntity;
  final TextEditingController controller = TextEditingController();
  ScrollController controllerList = ScrollController();
  late WebSocketChannel socket;
  bool isSocketConnected = false;

  void stopAllControllers(String path) {
    for (var i in ticketEntity?.messages ?? []) {
      if (i.type == 'audio' && i.message != path) {
        i.voiceController?.pausePlaying();
      }
    }
  }

  void scrollToBottom() async {
    try {
      if (controllerList.hasClients) {
        await controllerList.animateTo(
          controllerList.position.minScrollExtent,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 100),
        );
      } else {}
    } catch (e) {}
  }

  void selectImageChat() async {
    XFile? image = await chooseImage();
    if (image != null) {
      navP(ImagePreviewWidget(img: image, showSendButton: true));
    }
  }

  void clear() {
    stopAllControllers('');
    ticketEntity = null;
    isShowTicket = false;
    controller.clear();
    closeConnection();
    notifyListeners();
  }

  Future addMessage({dynamic file, required String type, int? sec}) async {
    if (ticketEntity == null) return;
    // if (!isSocketConnected) return;

    Map<String, dynamic> data = {};
    if (file != null) {
      data['message'] = await MultipartFile.fromFile(file.path);
    } else {
      data['message'] = controller.text;
    }

    data['ticket_id'] = ticketEntity!.id;
    data['type'] = type;
    controller.clear();

    TicketMessageModel message = TicketMessageModel(
      message: file?.path ?? data['message'],
      createdAt: DateTime.now(),
      id: 0,
      ticketId: ticketEntity!.id,
      type: type,
      isFile: true,
      duration: sec?.toDouble() ?? 0,
      voiceController: type != "audio"
          ? null
          : VoiceController(
        audioSrc: file!.path,
        onComplete: () {},
        onPause: () {},
        onPlaying: () => stopAllControllers(file!.path),
        onError: (err) {},
        isFile: true,
        maxDuration: Duration(seconds: (sec ?? 0).toInt()),
      ), sender: 'user', updatedAt: DateTime.now(),
    );
    ticketEntity?.messages?.insert(0, message);
    if (message.message.isNotEmpty && isSocketConnected) {
      socket.sink.add(jsonEncode(message.toJson()));
    }
    scrollToBottom();
    notifyListeners();
    var response = await TicketsUseCase(sl()).createTicketMessage(data);
    response.fold((l) => showToast(l.message ?? ""), (r) {
      controller.clear();
    });
    notifyListeners();
  }

  bool isShowTicket = false;
  void setIsShowTicket(bool value) {
    isShowTicket = value;
    if(!value){
      clear();
      closeConnection();
    }
    notifyListeners();
  }
  void goToMessagePage({required TicketEntity selectedChatEntity}) {
    // closeConnection();
    ticketEntity = null;
    notifyListeners();
    AddTicketProvider addTicketProvider = Provider.of(Constants.globalContext(),listen: false);
    addTicketProvider.setIsAddTicket(false);
    setIsShowTicket(true);
    getTicketDetails(id: selectedChatEntity.id);
    // navP( TicketMessagePage(), then: (val) {
    //   delay(300).then((_) => clear());
    //   closeConnection();
    // });

    scrollToBottom();
  }

  void rebuild() {
    notifyListeners();
  }

  Future getTicketDetails({required int id,bool fromNoti=false}) async {
    Map<String, dynamic> data = {'ticket_id': id,};
    var response = await TicketsUseCase(sl()).getTicketDetails(data);
    response.fold((l) => showToast(l.message ?? ""), (r) {
      if(ticketEntity?.id == id){
        ticketEntity = r;
      }
      if(fromNoti){
        Provider.of<TicketsProvider>(Constants.globalContext(),listen: false).updateTicketStatus(r);
      }else{
        ticketEntity = r;
      }
      startSocketConnection();
      notifyListeners();

    }
    );
  }

  void startSocketConnection() {
    if (isSocketConnected) return;

    socket = WebSocketChannel.connect(
      Uri.parse(Constants.webSocketLink,),
    );
    isSocketConnected = true;
    socket.stream.listen((event) {
      try {
        final data = jsonDecode(event);
        if (data["event"] == "new_message") {
          final messageData = jsonDecode(data["data"]);
          if(messageData['sender'] == "admin"){
            ticketEntity?.messages?.insert(0, TicketMessageModel(id: 0, ticketId: 0, message: messageData["message"],
              type: messageData['type'], sender: 'admin', isFile: false, createdAt: DateTime.now(), duration: null,
              voiceController: null, updatedAt: DateTime.now(),));
            notifyListeners();}
        }
        if (data["event"] == "pusher:connection_established") {
          final subscribeData = {
            "event": "pusher:subscribe",
            "data": {"channel": "ticket_${ticketEntity?.id}"}
          };
          socket.sink.add(jsonEncode(subscribeData));
        }
        if (data["event"] == "pusher:ping") {
          final pongResponse = {"event": "pusher:pong"};
          socket.sink.add(jsonEncode(pongResponse));
        }
      } catch (e) {}
    }, onError: (error) async{
      isSocketConnected = false;
      closeConnection();
      debugPrint('socket error ');
      debugPrint(error.toString());
      if(isShowTicket){
        await delay(1000);
        startSocketConnection();
      }
    }, onDone: () async{
      isSocketConnected = false;
      closeConnection();
      debugPrint('socket error ');
      if(isShowTicket){
        await delay(1000);
        startSocketConnection();
      }
    },cancelOnError: true,);
  }

  bool checkMessageOfThisChat(int id) {
    if (ticketEntity != null && ticketEntity!.id == id) {
      return true;
    }
    return false;
  }

  void closeConnection() {
    if (isSocketConnected) {
      socket.sink.close(1000);
      isSocketConnected = false;
    }
  }
}
