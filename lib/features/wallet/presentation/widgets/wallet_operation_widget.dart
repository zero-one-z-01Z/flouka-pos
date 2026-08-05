import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entity/wallet_operation_entity.dart';

class WalletOperationWidget extends StatelessWidget {
  final WalletOperationEntity operation;
  const WalletOperationWidget({super.key, required this.operation});

  // green when it increases the wallet (charge, refund, earn, withdraw_balance_canceled)
  // yellow when nothing changes (withdraw_balance_complete)
  // red for everything else (buy, withdraw, for_admin)
  Color get _color {
    switch (operation.operation.direction) {
      case WalletOperationDirection.increase:
        return Colors.green;
      case WalletOperationDirection.neutral:
        return Colors.amber;
      case WalletOperationDirection.decrease:
        return Colors.red;
    }
  }

  IconData get _icon {
    switch (operation.operation.direction) {
      case WalletOperationDirection.increase:
        return Icons.arrow_upward;
      case WalletOperationDirection.neutral:
        return Icons.remove; // dash
      case WalletOperationDirection.decrease:
        return Icons.arrow_downward;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 1.6.h,
            backgroundColor: _color.withOpacity(0.15),
            child: Icon(_icon, color: _color, size: 1.8.h),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LanguageProvider.translate("wallet_operations", operation.operation.raw),
                  style: TextStyleClass.captionStyle(),
                ),
                Text(
                  "${operation.createdAt}",
                  style: TextStyleClass.captionStyle(color: Colors.grey).copyWith(fontSize: 10.sp),
                ),
              ],
            ),
          ),
          Text(
            operation.operation.direction == WalletOperationDirection.decrease
                ? "-${operation.amount}"
                : operation.operation.direction == WalletOperationDirection.increase
                    ? "+${operation.amount}"
                    : "${operation.amount}",
            style: TextStyleClass.captionStyle(color: _color).copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
