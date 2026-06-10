import 'package:equatable/equatable.dart';

import 'ticket_message_entity.dart';

class TicketEntity extends Equatable {
  final int id;
  final int userId;
  final int? supplierId;
  final dynamic ticketCategoryId;
  final String title;
  final String description;
  final dynamic reasonId;
  final String important;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TicketMessageEntity? lastMessage;
  final TicketProblemCategoryEntity? ticketCategory;
  final List<TicketMessageEntity>? messages;

  TicketEntity({
    required this.id,
    required this.userId,
    required this.ticketCategory,
    this.supplierId,
    required this.ticketCategoryId,
    required this.title,
    required this.description,
    required this.reasonId,
    required this.important,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
    required this.messages,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    supplierId,
    ticketCategoryId,
    title,
    description,
    reasonId,
    important,
    status,
    createdAt,
    updatedAt,
    lastMessage,
    messages,
  ];}

class TicketProblemCategoryEntity extends Equatable {
  final int id;
  final String name;

  const TicketProblemCategoryEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name,];

}