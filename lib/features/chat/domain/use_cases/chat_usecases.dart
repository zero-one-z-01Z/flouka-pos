import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class ChatUseCases {
  ChatRepository chatRepository;

  ChatUseCases(this.chatRepository);

  Future<Either<DioException, ChatEntity>> getChatDetails(Map<String, dynamic> data) async {
    return await chatRepository.getChatDetails(data);
  }

  Future<Either<DioException, MessageEntity>> createMessage(Map<String, dynamic> data) async {
    return await chatRepository.createMessage(data);
  }


  Future<Either<DioException, ChatEntity>> getSupportChatDetails(Map<String, dynamic> data) async {
    return await chatRepository.getSupportChatDetails(data);
  }

  Future<Either<DioException, MessageEntity>> createSupportMessage(Map<String, dynamic> data) async {
    return await chatRepository.createSupportMessage(data);
  }

}
