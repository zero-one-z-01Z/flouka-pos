import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class KnowUsEntity extends Equatable {
  final int id;
  final String image;
  final String name;
  TextEditingController controller=TextEditingController();
  KnowUsEntity({required this.id, required this.image, required this.name});

  @override
  List<Object?> get props => [id,image,name];
}
