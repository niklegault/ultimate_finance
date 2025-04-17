import 'package:ultimate_finance/models/types.dart';

class Account {
  String name;
  Types type;
  List<AccountPeriod> periods = [];
  double balance = 0.0;

  Account({required this.name, required this.type}) {
    periods = List<AccountPeriod>.empty(growable: true);
  }
}

class AccountPeriod {
  final DateTime period;
  double balance;
  double deposits;
  double withdrawals;
  double interest;

  AccountPeriod({
    required this.period,
    required this.balance,
    required this.deposits,
    required this.withdrawals,
    required this.interest,
  });
}
