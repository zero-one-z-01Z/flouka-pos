import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/image.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widgets/img_preview_widget.dart';
import '../../../../injection_container.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/use_cases/chat_usecases.dart';
import '../pages/message_page.dart';

class MessageProvider extends ChangeNotifier {
  ChatEntity? chatEntity;


  final TextEditingController controller = TextEditingController();
  ScrollController controllerList = ScrollController();
  void stopAllControllers(String path) {
    for (var i in chatEntity?.messages ?? []) {
      if (i.type == 'audio') {
        if (i.message != path) {
          i.voiceController!.pausePlaying();
        }
      }
    }
  }

  bool checkMessageOfThisChat(int id) {
    if (chatEntity?.id == id) {
      return true;
    }
    return false;
  }

  void scrollToBottom() async {
    try {
      controllerList.animateTo(controllerList.position.minScrollExtent,
          curve: Curves.linear, duration: const Duration(milliseconds: 100));
    } catch (e) {
      print('e');
    }
  }

  void selectImageChat() async {
    XFile? image = await chooseImage();
    if (image != null) {
      navP(ImagePreviewWidget(
        img: image,
        showSendButton: true,
      ));
    }
  }

  void clear() {
    stopAllControllers('');
    setIsShowChat(false);
    chatEntity = null;
    controller.clear();
  }

  Future addMessage({dynamic file, required String type, int? sec, String? message}) async {
    Either<DioException, MessageEntity> response;
    Map<String, dynamic> data = {};
    // double size = 0;
    if (file != null) {
      // int fileSizeInBytes = await file.length();
      // size = fileSizeInBytes / 1024;
      data['message'] = await MultipartFile.fromFile(file.path);
    } else {
      data['message'] = message ?? controller.text;
    }
    // AuthProvider auth = Provider.of(Constants.globalContext(), listen: false);
    data['chat_id'] = chatEntity?.id;
    data['type'] = type;

    controller.clear();
    chatEntity?.messages.insert(
        0,
        MessageModel(
          sender: 'store',
          message: file?.path ?? data['message'],
          date: DateTime.now(),
          id: 0,
          chatId: chatEntity!.id,
          type: type,
          isFile: true,
          duration: sec?.toDouble() ?? 0,
          voiceController: type != "audio"
              ? null
              : VoiceController(
            audioSrc: file!.path,
            onComplete: () {
              /// do something on complete
            },
            onPause: () {
              /// do something on pause
            },
            onPlaying: () {
              stopAllControllers(file!.path);
            },
            onError: (err) {
              /// do something on error
            },
            isFile: true,
            maxDuration: Duration(seconds: (sec ?? 0).toInt()),
          ),
          fromAdmin: false,
        ));
    notifyListeners();
    response = await ChatUseCases(sl()).createMessage(data);
    response.fold((l) {
      showToast(l.message ?? "");
    }, (r) {


    });
    notifyListeners();
  }

  void addOneMessage(MessageEntity messageEntity){
    chatEntity?.messages.insert(0,messageEntity);
    notifyListeners();
  }

  int id = 0;
  Future getMessages({required int orderId, required int userId}) async {

    Map<String, dynamic> data = {};
    Either<DioException, ChatEntity> response;
    loading();
    data['order_id'] = orderId;
    data['store_id'] = userId;

    response = await ChatUseCases(sl()).getChatDetails(data);
    navPop();

    response.fold((l) {
      showToast(l.message!);
    }, (r) {
      chatEntity = r;
      notifyListeners();
    });
  }

  void refresh({required int orderId, required int userId }) {
    clear();
    getMessages(orderId: orderId, userId: userId);
  }

  bool isShowChat=false;
  void setIsShowChat(bool value) {
    isShowChat = value;
    notifyListeners();
  }

  void goToMessagePage({required int orderId, required int userId }) async {
    clear();
    await getMessages(orderId: orderId, userId: userId);
    setIsShowChat(true);
    // navP(, then: (val) {
    //   clear();
    // });
  }

  void rebuild() {
    notifyListeners();
  }
}
