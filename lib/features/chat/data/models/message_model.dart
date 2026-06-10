import 'package:provider/provider.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/message_entity.dart';
import '../../presentation/provider/message_provider.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.id, required super.date,
    required super.type, required super.message, required super.chatId, required super.isFile,required super.sender,
    required super.duration, required super.voiceController,required super.fromAdmin,});

  // required super.chatEntity,
  factory MessageModel.fromJson(Map data){
    VoiceController? voiceController;
    if(data['type']=='audio'){
      voiceController = VoiceController(
        audioSrc:
        data['message'],
        onComplete: () {
          /// do something on complete
        },
        onPause: () {
          /// do something on pause
        },
        onPlaying: () {
          Provider.of<MessageProvider>(Constants.globalContext(),listen: false).
          stopAllControllers(data['message']);
        },
        onError: (err) {
          /// do something on error
        }, isFile: false,

        maxDuration: Duration(seconds: convertDataToDouble(data['duration']).toInt()),
      );
    }

    return MessageModel(id: data['id'],
        fromAdmin: data['from_admin'] !=null ? convertDataToBool(data['from_admin']) :null,
        sender: data['sender'],
        date: DateTime.parse(data['created_at']),
        isFile: false,
        // chatEntity: ChatModel.fromJson(data['chat']),
        voiceController: voiceController,
        duration: data['duration']!=null ?  convertDataToDouble(data['duration']) :null,
        // fileSize: convertDataToDouble(data['file_size']),
        type: data['type'], message: data['message'],
        chatId: convertStringToInt(data['chat_id']));
  }

}


