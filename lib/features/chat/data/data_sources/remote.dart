import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRemoteDataSources {

  Future<Either<DioException, ChatModel>> getChatDetails(Map<String, dynamic> data) async {
    var response = await ApiHandel.getInstance.post('get_chat_details', data);
    return response.fold((l) => Left(l), (r) {
      return Right(ChatModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, MessageModel>> createMessage(Map<String, dynamic> data) async {
    var response = await ApiHandel.getInstance.post('create_message', data);
    return response.fold((l) => Left(l), (r) {
      return Right(MessageModel.fromJson(r.data['data']));
    });
  }


  Future<Either<DioException, ChatModel>> getSupportChatDetails(Map<String, dynamic> data) async {
    var response = await ApiHandel.getInstance.get('user/get_support_chat_details', data);
    return response.fold((l) => Left(l), (r) {
      return Right(ChatModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, MessageModel>> createSupportMessage(Map<String, dynamic> data) async {
    var response = await ApiHandel.getInstance.post('user/create_support_message', data);
    return response.fold((l) => Left(l), (r) {
      return Right(MessageModel.fromJson(r.data['data']));
    });
  }

}
