import 'message_entity.dart';

class ChatEntity{
  int id;
  List<MessageEntity> messages;
  DateTime? date;
  ChatEntity(
      {required this.id, required this.messages, required this.date,});
}
