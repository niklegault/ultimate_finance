import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/transaction.dart';

abstract class IDataRepository {
  Stream<List<BudgetCategory>> watchAllBudgetCategories();
  Future<int> addBudgetCategory(String name, Types type);

  // This method now matches the data source and UI needs
  Stream<List<BudgetPeriod>> watchBudgetPeriodsForMonth(DateTime month);
  Future<void> updateBudgetPeriod(int categoryId, DateTime period, double budgetedAmount);

  Stream<List<Transaction>> watchAllTransactions();
  Future<void> addTransaction({
    required DateTime date,
    required Types type,
    required int categoryId,
    required double amount,
    String? description,
  });
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(int id);
}