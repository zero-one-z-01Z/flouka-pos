import '../../domain/entities/ticket_entity.dart';
import 'ticket_message_model.dart';

class TicketModel extends TicketEntity {
  TicketModel({
    required super.id,
    required super.userId,
    required super.ticketCategory,
    super.supplierId,
    required super.ticketCategoryId,
    required super.title,
    required super.description,
    required super.reasonId,
    required super.important,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.lastMessage,
    required super.messages,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    List<TicketMessageModel> messages=[];
    if(json['messages']!=null){
      for(var element in json['messages']){
        messages.add(TicketMessageModel.fromJson(element));
      }
    }
    return TicketModel(
      id: json['id'],
      userId: json['user_id']??0,
      supplierId: json['supplier_id'],
      ticketCategoryId: json['ticket_category_id'],
      title: json['title'],
      description: json['description'],
      reasonId: json['reason_id'],
      important: json['important'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      lastMessage: json['last_message'] != null
          ? TicketMessageModel.fromJson(json['last_message'])
          : null,
      ticketCategory: json['ticket_category'] != null
          ? TicketProblemCategoryModel.fromJson(json['ticket_category'])
          : null,
      messages: messages,
    );
  }
}


class TicketProblemCategoryModel extends TicketProblemCategoryEntity {
  const TicketProblemCategoryModel({
    required super.id,
    required super.name,
  });

  factory TicketProblemCategoryModel.fromJson(Map<String, dynamic> json) {
    return TicketProblemCategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
