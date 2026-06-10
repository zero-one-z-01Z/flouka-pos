import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:voice_message_package/voice_message_package.dart';

class TicketMessageEntity extends Equatable {
  int id;
  int ticketId;
  String message;
  String type;
  String sender;
  double? duration;
  DateTime createdAt;
  DateTime updatedAt;
  VoiceController? voiceController;
  bool isFile;

  TicketMessageEntity({
    required this.id,
    required this.ticketId,
    required this.message,
    required this.isFile,
    required this.voiceController,
    required this.type,
    required this.sender,
    this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    ticketId,
    message,
    type,
    sender,
    duration,
    createdAt,
    updatedAt,
  ];


  bool fromMe(){
    return sender=="user";
  }
  ImageProvider imageProvider(){
    return (isFile?FileImage(File(message)):CachedNetworkImageProvider(message)) as ImageProvider;
  }

}
