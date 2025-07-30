import "package:ultimate_finance/models/types.dart";
import "package:ultimate_finance/models/budget_category.dart";
import "package:ultimate_finance/models/transaction.dart";
import "package:ultimate_finance/data/repositories/abstract_data_repository.dart";
import "package:ultimate_finance/data/datasources/abstract_local_data_source.dart";
import "package:ultimate_finance/models/account.dart";

class DataRepository implements IDataRepository {
  final ILocalDataSource _localDataSource;

  DataRepository({required ILocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Stream<List<BudgetCategory>> watchAllBudgetCategories() {
    return _localDataSource.watchAllBudgetCategories();
  }

  @override
  Future<int> addBudgetCategory(String name, Types type) {
    return _localDataSource.addBudgetCategory(name, type);
  }

  @override
  Future<void> updateBudgetCategory(BudgetCategory category) {
    return _localDataSource.updateBudgetCategory(category);
  }

  @override
  Future<void> deleteBudgetCategory(int id) {
    return _localDataSource.deleteBudgetCategory(id);
  }

  @override
  Stream<List<BudgetPeriod>> watchBudgetPeriodsForMonth(DateTime month) {
    return _localDataSource.watchBudgetPeriodsForMonth(month);
  }

  @override
  Future<void> updateBudgetPeriod(
    int categoryId,
    DateTime period,
    double budgetedAmount,
  ) {
    return _localDataSource.updateBudgetPeriod(
      categoryId,
      period,
      budgetedAmount,
    );
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

  @override
  Stream<List<Account>> watchAllAccounts() {
    return _localDataSource.watchAllAccounts();
  }

  @override
  Future<int> addAccount(String name, Types type, int catId) {
    return _localDataSource.addAccount(name, type, catId);
  }

  @override
  Future<void> updateAccount(Account account) {
    return _localDataSource.updateAccount(account);
  }

  @override
  Future<void> deleteAccount(int id) {
    return _localDataSource.deleteAccount(id);
  }

  @override
  Future<Account> getAccountByCategoryId(int categoryId) {
    return _localDataSource.getAccountByCategoryId(categoryId);
  }

  @override
  Future<AccountPeriod> getAccountPeriodFromCategoryId(
    int categoryId,
    DateTime month,
  ) {
    return _localDataSource.getAccountPeriodFromCategoryId(categoryId, month);
  }

  @override
  Stream<List<AccountPeriod>> watchAccountPeriodsForMonth(DateTime month) {
    return _localDataSource.watchAccountPeriodsForMonth(month);
  }

  @override
  Future<void> updateAccountPeriod(
    int accountId,
    DateTime period,
    double balance,
    double deposit,
    double withdrawal,
    double interest,
  ) {
    return _localDataSource.updateAccountPeriod(
      accountId,
      period,
      balance,
      deposit,
      withdrawal,
      interest,
    );
  }
}
