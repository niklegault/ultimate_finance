import 'package:ultimate_finance/models/types.dart';

/// The BudgetCategory class represents a category of budget.
/// It contains a name, a type, and a list of budget periods.
class BudgetCategory {
  String name;
  Types type;
  List<BudgetPeriod> periods = [];

  BudgetCategory({required this.name, required this.type}) {
    periods = List<BudgetPeriod>.empty(growable: true);
  }

  void addPeriod(DateTime period, double budgetedAmount) {
    periods.add(BudgetPeriod(period: period, budgetedAmount: budgetedAmount));
  }

  BudgetPeriod? getPeriod(DateTime period) {
    return periods.firstWhere(
      (p) => p.period.year == period.year && p.period.month == period.month,
      orElse: () {
        var newPeriod = BudgetPeriod(period: period, budgetedAmount: 0.0);
        periods.add(newPeriod);
        return newPeriod;
      },
    );
  }

  @override
  String toString() {
    return 'BudgetCategory{name: $name}';
  }
}

class BudgetPeriod {
  final DateTime period;
  double budgetedAmount;
  double actualAmount = 0.0;

  BudgetPeriod({required this.period, required this.budgetedAmount});

  void addActualAmount(double amount) {
    actualAmount += amount;
  }

  void setBudgetedAmount(double amount) {
    budgetedAmount = amount;
  }
}
