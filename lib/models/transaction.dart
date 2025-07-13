import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';

class Transaction {
  final int id;
  DateTime date;
  Types type;
  int categoryId;
  double amount;
  String? description;

  Transaction({
    required this.id,
    required this.date,
    required this.type,
    required this.categoryId,
    required this.amount,
    this.description,
  });
}
