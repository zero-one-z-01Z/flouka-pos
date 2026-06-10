import 'package:equatable/equatable.dart';

class WheelItemEntity extends Equatable {
  final int id;
  final String? image;
  final num percentage;
  final String name;

  const WheelItemEntity({required this.id, required this.image, required this.percentage,required this.name});

  @override
  List<Object?> get props => [id,image,percentage,name];


}
