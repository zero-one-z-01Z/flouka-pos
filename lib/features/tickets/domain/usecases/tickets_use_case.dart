import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/ticket_entity.dart';
import '../entities/ticket_message_entity.dart';
import '../repositories/tickets_repository.dart';

class TicketsUseCase {
  final TicketsRepository marketRepository;
  TicketsUseCase(this.marketRepository);

  Future<Either<DioException, List<TicketEntity>>> getTickets(Map<String, dynamic> data) async {
    return await marketRepository.getTickets(data);
  }


  Future<Either<DioException, TicketEntity>> getTicketDetails(Map<String, dynamic> data) async {
    return await marketRepository.getTicketDetails(data);
  }


  Future<Either<DioException, TicketEntity>> createTicket(Map<String, dynamic> data) async {
    return await marketRepository.createTicket(data);
  }

  Future<Either<DioException, List<TicketProblemCategoryEntity>>> getTicketCategory(Map<String, dynamic> data) async {
    return await marketRepository.getTicketCategory(data);
  }

  Future<Either<DioException, TicketMessageEntity>> createTicketMessage(Map<String, dynamic> data) async {
    return await marketRepository.createTicketMessage(data);
  }

}
