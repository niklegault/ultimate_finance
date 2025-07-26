import 'package:ultimate_finance/models/types.dart';

class Transaction {
  final int id;
  final DateTime date;
  final Types type;
  final int categoryId;
  final double amount;
  final String? description;

  Transaction({
    required this.id,
    required this.date,
    required this.type,
    required this.categoryId,
    required this.amount,
    this.description,
  });
}