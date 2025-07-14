import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/transaction.dart';

abstract class ILocalDataSource {
  Stream<List<BudgetCategory>> watchAllBudgetCategories();
  Future<void> addBudgetCategory(String name, Types type);

  Stream<List<BudgetPeriod>> watchAllBudgetPeriods();
  Future<void> addBudgetPeriod(int categoryId, DateTime period, double budgetedAmount);

  Stream<List<Transaction>> watchAllTransactions();
  Future<void> addTransaction({
    required DateTime date,
    required Types type,
    required int categoryId,
    required double amount,
    String? description,
  });
  Future<void> updateBudgetPeriod(int categoryId, DateTime period, double budgetedAmount);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(int id);

//   Stream<List<Account>> watchAllAccounts();
//   Future<void> addAccount(String name, double initialBalance);

//   Stream<List<AccountPeriod>> watchAllAccountPeriods();
//   Future<void> addAccountPeriod(int accountId, DateTime period, double balance);
}