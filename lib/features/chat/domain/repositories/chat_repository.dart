import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<DioException, ChatEntity>> getChatDetails(Map<String, dynamic> data);
  Future<Either<DioException, MessageEntity>> createMessage(Map<String, dynamic> data);
  Future<Either<DioException, ChatEntity>> getSupportChatDetails(Map<String, dynamic> data);
  Future<Either<DioException, MessageEntity>> createSupportMessage(Map<String, dynamic> data);
}
