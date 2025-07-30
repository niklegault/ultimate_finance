import 'package:ultimate_finance/models/account.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/transaction.dart';

abstract class ILocalDataSource {
  Stream<List<BudgetCategory>> watchAllBudgetCategories();
  Future<int> addBudgetCategory(String name, Types type);
  Future<void> updateBudgetCategory(BudgetCategory category);
  Future<void> deleteBudgetCategory(int id);

  // This is the correct, efficient method for the UI
  Stream<List<BudgetPeriod>> watchBudgetPeriodsForMonth(DateTime month);
  Future<void> updateBudgetPeriod(
    int categoryId,
    DateTime period,
    double budgetedAmount,
  );

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

  Stream<List<Account>> watchAllAccounts();
  Future<int> addAccount(String name, Types type, int catId);
  Future<void> updateAccount(Account account);
  Future<void> deleteAccount(int id);

  Stream<List<AccountPeriod>> watchAccountPeriodsForMonth(DateTime month);
  Future<void> updateAccountPeriod(
    int accountId,
    DateTime period,
    double balance,
    double deposit,
    double withdrawal,
    double interest,
  );
}
