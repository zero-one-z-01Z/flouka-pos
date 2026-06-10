import '../../domain/entities/chat_entity.dart';
import 'message_model.dart';

class ChatModel extends ChatEntity {
  ChatModel({required super.id, required super.messages, required super.date,});
  factory ChatModel.fromJson(Map data){
    List<MessageModel> messages = [];
    if(data.containsKey('messages')&&data['messages']!=null){
      for(var i in data['messages']){
        messages.add(MessageModel.fromJson(i));
      }
    }
    return ChatModel(
      id: data['id'],
      messages: messages,
      date: DateTime.parse(data['created_at']),
    );
  }

}
