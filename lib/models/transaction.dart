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

  Transaction copyWith({
    int? id,
    DateTime? date,
    Types? type,
    int? categoryId,
    double? amount,
    String? description,
  }) {
    return Transaction(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
    );
  }
}