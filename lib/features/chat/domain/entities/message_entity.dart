import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:voice_message_package/voice_message_package.dart';


class MessageEntity extends Equatable {
  int id;
  int chatId;
  String type;
  String message;
  String sender;
  bool? fromAdmin;
  DateTime date;
  bool isFile;
  double? duration;
  VoiceController? voiceController;
  // ChatEntity? chatEntity;


  MessageEntity(
      {required this.id,
      required this.date,
      required this.type,
      required this.message,
      required this.isFile,
      required this.duration,
      required this.voiceController,
      required this.sender,
      required this.fromAdmin,
      required this.chatId});

  @override
  List<Object?> get props => [id, type, sender,message, chatId];

  bool fromMe(){
    return 'operator'==sender;
  }

  ImageProvider imageProvider(){
    return (isFile?FileImage(File(message)):CachedNetworkImageProvider(message)) as ImageProvider;
  }





}
