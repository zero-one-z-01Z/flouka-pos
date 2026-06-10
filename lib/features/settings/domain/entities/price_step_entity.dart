import 'package:equatable/equatable.dart';

class PriceStepEntity extends Equatable {
  int id;
  num from;
  num to;
  num price;

  PriceStepEntity({required this.id, required this.to, required this.from, required this.price});



  @override
  List<Object?> get props => [id, to, from, price,];
}
