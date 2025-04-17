import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';

class Transaction {
  final DateTime date;
  Types type;
  BudgetCategory category;
  double amount;
  String description;

  Transaction({
    required this.date,
    required this.type,
    required this.category,
    required this.amount,
    required this.description,
  });
}
