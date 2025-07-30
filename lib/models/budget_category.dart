import 'package:ultimate_finance/models/types.dart';

class BudgetCategory {
  final int id;
  final String name;
  final Types type;

  BudgetCategory({
    required this.id,
    required this.name,
    required this.type,
  });

  BudgetCategory copyWith({
    int? id,
    String? name,
    Types? type,
  }) {
    return BudgetCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  } 
}

class BudgetPeriod {
  final int id;
  final int categoryId;
  final DateTime period;
  final double budgetedAmount;

  BudgetPeriod({
    required this.id,
    required this.categoryId,
    required this.period,
    required this.budgetedAmount,
  });
}