import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/tickets_repository.dart';
import '../datasources/remote_tickets_data_source.dart';
import '../models/ticket_message_model.dart';
import '../models/ticket_model.dart';

class TicketsRepoImpl implements TicketsRepository {
  final BannersTicketsDataSource bannersTicketsDataSource;
  TicketsRepoImpl(this.bannersTicketsDataSource);
  @override
  Future<Either<DioException, List<TicketModel>>> getTickets(Map<String, dynamic> data)async {
    return await BannersTicketsDataSource.getTickets(data);
  }
  @override
  Future<Either<DioException, List<TicketProblemCategoryModel>>> getTicketCategory(Map<String, dynamic> data)async {
    return await BannersTicketsDataSource.getTicketCategory(data);
  }
  @override
  Future<Either<DioException, TicketMessageModel>> createTicketMessage(Map<String, dynamic> data)async {
    return await BannersTicketsDataSource.createTicketMessage(data);
  }
  @override
  Future<Either<DioException, TicketModel>> createTicket(Map<String, dynamic> data)async {
    return await BannersTicketsDataSource.createTicket(data);
  }

  @override
  Future<Either<DioException, TicketModel>> getTicketDetails(Map<String, dynamic> data)async {
    return await BannersTicketsDataSource.getTicketDetails(data);
  }
}