import 'package:provider/provider.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/ticket_message_entity.dart';
import '../../presentation/provider/ticket_message_provider.dart';

class TicketMessageModel extends TicketMessageEntity {
  TicketMessageModel({
    required super.id,
    required super.ticketId,
    required super.message,
    required super.type,
    required super.sender,
    required super.isFile,
    required super.duration,
    required super.voiceController,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TicketMessageModel.fromJson(Map<String, dynamic> json) {
    VoiceController? voiceController;

    if (json['type'] == 'audio') {
      voiceController = VoiceController(
        audioSrc: json['message'],
        onComplete: () {},
        onPause: () {},
        onPlaying: () {
         Provider.of<TicketMessageProvider>(Constants.globalContext(),listen:false).stopAllControllers(json['message']);
        },
        onError: (err) {},
        isFile: false,
        maxDuration:
        Duration(seconds: convertDataToDouble(json['duration']).toInt()),
      );
    }

    return TicketMessageModel(
      id: json['id'],
      ticketId: json['ticket_id'],
      message: json['message'],
      type: json['type'],
      sender: json['sender'],
      isFile: false,
      voiceController: voiceController,
      duration: json['duration'] != null ? convertDataToDouble(json['duration']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }


  Map<String, dynamic> toJson() {
    if(type =="image"){
      isFile =true;
    }
    return  {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'type': type,
      'message': message,
      'ticket_id': ticketId,
      'is_file': isFile,
      'duration': duration,
      'audio_controller': voiceController?.audioSrc,
    };
  }
}
