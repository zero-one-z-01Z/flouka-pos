import 'package:equatable/equatable.dart';

class HighlightEntity extends Equatable {
  final int id;
  final String name;
  const HighlightEntity({required this.id, required this.name,});
  @override
  List<Object?> get props => [id, name,];
}
