// import 'package:equatable/equatable.dart';

// import '../../../../core/helper_function/convert.dart';

// class CommissionEntity extends Equatable {
//   final int id;
//   // final String status;
//   final bool commission;
//   final String title;
//   final num price;
//   final num commissionPercentage;
//   final bool isFavorite;
//   final bool isRated;
//   bool?isSelected;

//    CommissionEntity(
//       {required this.id,
//       // required this.status,
//       required this.commission,
//       required this.commissionPercentage,
//       required this.title,
//       required this.price,
//       required this.isFavorite,
//       required this.isRated});



//   @override
//   List<Object?> get props => [
//     id,
//     // status,
//     commission,
//     title,
//     price,
//     isFavorite,
//     isRated,
//       ];

//   num calcCommission(){
//     return convertDataToNum((commissionPercentage / 100 * price).toStringAsFixed(2));
//   }
// }
