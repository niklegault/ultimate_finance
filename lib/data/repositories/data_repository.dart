import "package:ultimate_finance/models/types.dart";
import "package:ultimate_finance/models/budget_category.dart";
import "package:ultimate_finance/models/transaction.dart";
import "package:ultimate_finance/data/repositories/abstract_data_repository.dart";
import "package:ultimate_finance/data/datasources/abstract_local_data_source.dart";

class DataRepository implements IDataRepository {
  final ILocalDataSource _localDataSource;

  DataRepository({required ILocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Stream<List<BudgetCategory>> watchAllBudgetCategories() {
    return _localDataSource.watchAllBudgetCategories();
  }

  @override
  Future<void> addBudgetCategory(String name, Types type) {
    return _localDataSource.addBudgetCategory(name, type);
  }

  @override
  Stream<List<BudgetPeriod>> watchAllBudgetPeriods() {
    return _localDataSource.watchAllBudgetPeriods();
  }

  @override
  Future<void> addBudgetPeriod(int categoryId, DateTime period, double budgetedAmount) {
    return _localDataSource.addBudgetPeriod(categoryId, period, budgetedAmount);
  }

  @override
  Stream<List<Transaction>> watchAllTransactions() {
    return _localDataSource.watchAllTransactions();
  }

  @override
  Future<void> addTransaction({
    required DateTime date,
    required Types type,
    required int categoryId,
    required double amount,
    String? description,
  }) {
    return _localDataSource.addTransaction(
      date: date,
      type: type,
      categoryId: categoryId,
      amount: amount,
      description: description,
    );
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    return _localDataSource.updateTransaction(transaction); 
  }

  @override
  Future<void> deleteTransaction(int id) {
    return _localDataSource.deleteTransaction(id);
  }
}