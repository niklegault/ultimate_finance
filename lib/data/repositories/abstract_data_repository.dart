import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/models/budget_category.dart';

abstract class IDataRepository {
  Stream<List<BudgetCategory>> watchAllBudgetCategories();
  Future<void> addBudgetCategory(String name, Types type);

  Stream<List<BudgetPeriod>> watchAllBudgetPeriods();
  Future<void> addBudgetPeriod(int categoryId, DateTime period, double budgetedAmount);
}