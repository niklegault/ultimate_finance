import 'package:ultimate_finance/models/types.dart';

/// The BudgetCategory class represents a category of budget.
/// It contains a name, a type, and a list of budget periods.
class BudgetCategory {
  final int id;
  String name;
  Types type;
  
  BudgetCategory({
    required this.id,
    required this.name,
    required this.type,
  });
}

class BudgetPeriod {
  final int id;
  final int categoryId;
  final DateTime period;
  double budgetedAmount;

  BudgetPeriod({
    required this.id,
    required this.categoryId,
    required this.period,
    required this.budgetedAmount,
  });
}
