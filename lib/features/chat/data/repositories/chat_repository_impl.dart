import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/chat_repository.dart';
import '../data_sources/remote.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl extends ChatRepository {
  @override
  Future<Either<DioException, MessageModel>> createMessage(Map<String, dynamic> data) async {
    return await ChatRemoteDataSources().createMessage(data);
  }
  @override
  Future<Either<DioException, ChatModel>> getChatDetails(Map<String, dynamic> data) async {
    return await ChatRemoteDataSources().getChatDetails(data);
  }

  @override
  Future<Either<DioException, MessageModel>> createSupportMessage(Map<String, dynamic> data) async {
    return await ChatRemoteDataSources().createSupportMessage(data);
  }
  @override
  Future<Either<DioException, ChatModel>> getSupportChatDetails(Map<String, dynamic> data) async {
    return await ChatRemoteDataSources().getSupportChatDetails(data);
  }

}
