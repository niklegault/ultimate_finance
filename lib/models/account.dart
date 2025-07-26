import 'package:ultimate_finance/models/types.dart';

class Account {
  final int id;
  final String name;
  final Types type;

  Account({
    required this.id,
    required this.name,
    required this.type,
  });
}

class AccountPeriod {
  final int id;
  final DateTime period;
  final double balance;
  final double deposits;
  final double withdrawals;
  final double interest;

  AccountPeriod({
    required this.id,
    required this.period,
    required this.balance,
    required this.deposits,
    required this.withdrawals,
    required this.interest,
  });
}
