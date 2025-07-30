import 'package:ultimate_finance/models/types.dart';

class Account {
  final int id;
  final int categoryId;
  final String name;
  final Types type;

  Account({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.type,
  });

  Account copyWith({int? id, int? categoryId, String? name, Types? type}) {
    return Account(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}

class AccountPeriod {
  final int id;
  final int accountId;
  final DateTime period;
  final double balance;
  final double deposits;
  final double withdrawals;
  final double interest;

  AccountPeriod({
    required this.id,
    required this.accountId,
    required this.period,
    required this.balance,
    required this.deposits,
    required this.withdrawals,
    required this.interest,
  });
}
