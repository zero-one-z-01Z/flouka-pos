enum WalletOperationDirection { increase, neutral, decrease }

enum WalletOperationType {
  charge,
  buy,
  refund,
  withdraw,
  earn,
  forAdmin,
  withdrawBalanceComplete,
  withdrawBalanceCanceled;

  // matches the raw value stored in the `operation` enum column
  String get raw {
    switch (this) {
      case WalletOperationType.charge:
        return 'charge';
      case WalletOperationType.buy:
        return 'buy';
      case WalletOperationType.refund:
        return 'refund';
      case WalletOperationType.withdraw:
        return 'withdraw';
      case WalletOperationType.earn:
        return 'earn';
      case WalletOperationType.forAdmin:
        return 'for_admin';
      case WalletOperationType.withdrawBalanceComplete:
        return 'withdraw_balance_complete';
      case WalletOperationType.withdrawBalanceCanceled:
        return 'withdraw_balance_canceled';
    }
  }

  static WalletOperationType fromRaw(String value) {
    return WalletOperationType.values.firstWhere(
      (e) => e.raw == value,
      orElse: () => WalletOperationType.charge,
    );
  }

  // green (increase): charge, refund, earn, withdraw_balance_canceled
  // yellow (neutral): withdraw_balance_complete
  // red (decrease): buy, withdraw, for_admin
  WalletOperationDirection get direction {
    switch (this) {
      case WalletOperationType.charge:
      case WalletOperationType.refund:
      case WalletOperationType.earn:
      case WalletOperationType.withdrawBalanceCanceled:
        return WalletOperationDirection.increase;
      case WalletOperationType.withdrawBalanceComplete:
        return WalletOperationDirection.neutral;
      case WalletOperationType.buy:
      case WalletOperationType.withdraw:
      case WalletOperationType.forAdmin:
        return WalletOperationDirection.decrease;
    }
  }
}

class WalletOperationEntity {
  final int id;
  final num amount;
  final WalletOperationType operation;
  final int? vendorId;
  final DateTime createdAt;

  const WalletOperationEntity({
    required this.id,
    required this.amount,
    required this.operation,
    this.vendorId,
    required this.createdAt,
  });
}
