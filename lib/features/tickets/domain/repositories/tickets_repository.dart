import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/ticket_entity.dart';
import '../entities/ticket_message_entity.dart';

abstract class TicketsRepository {
  Future<Either<DioException, List<TicketEntity>>> getTickets(Map<String,dynamic> data);
  Future<Either<DioException, List<TicketProblemCategoryEntity>>> getTicketCategory(Map<String,dynamic> data);
  Future<Either<DioException, TicketEntity>> getTicketDetails(Map<String,dynamic> data);
  Future<Either<DioException, TicketEntity>> createTicket(Map<String,dynamic> data);
  Future<Either<DioException, TicketMessageEntity>> createTicketMessage(Map<String,dynamic> data);
}
