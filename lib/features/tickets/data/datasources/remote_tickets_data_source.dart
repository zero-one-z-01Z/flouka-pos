import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/ticket_message_model.dart';
import '../models/ticket_model.dart';


class BannersTicketsDataSource {

  BannersTicketsDataSource(this.apiHandel);
  final ApiHandel apiHandel;
  static Future<Either<DioException, List<TicketModel>>> getTickets(
      Map<String, dynamic> data) async {
    var response =  await ApiHandel.getInstance.get('get_tickets', data);

    return response.fold((l) {
      return Left(l);}, (r) {
      List<TicketModel> list = [];
      for (var i in r.data['data']) {
        list.add(TicketModel.fromJson(i));
      }
      return Right(list);
    });
  }

  static Future<Either<DioException, TicketModel>> createTicket(Map<String, dynamic> data) async {
    var response =  await ApiHandel.getInstance.post('create_ticket', data);
    return response.fold((l) {
      return Left(l);}, (r) {
      return Right(TicketModel.fromJson(r.data['data']));
    });
  }


  static Future<Either<DioException, TicketModel>> getTicketDetails(Map<String, dynamic> data) async {
    var response =  await ApiHandel.getInstance.post('get_ticket_details', data);
    return response.fold((l) {
      return Left(l);}, (r) {
      return Right(TicketModel.fromJson(r.data['data']));
    });
  }

  static Future<Either<DioException, TicketMessageModel>> createTicketMessage(Map<String, dynamic> data) async {
    var response =  await ApiHandel.getInstance.post('create_ticket_message', data);
    return response.fold((l) {
      return Left(l);}, (r) {
      return Right(TicketMessageModel.fromJson(r.data['data']));
    });
  }

  static Future<Either<DioException, List<TicketProblemCategoryModel>>> getTicketCategory(
      Map<String, dynamic> data) async {
    var response =  await ApiHandel.getInstance.get('get_ticket_category', data);

    return response.fold((l) {
      return Left(l);}, (r) {
      List<TicketProblemCategoryModel> list = [];
      for (var i in r.data['data']) {
        list.add(TicketProblemCategoryModel.fromJson(i));
      }
      return Right(list);
    });
  }


}
