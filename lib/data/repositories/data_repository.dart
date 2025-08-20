import "package:rxdart/rxdart.dart";
import "package:flutter/material.dart";
import "package:ultimate_finance/models/dashboard_data.dart";
import "package:ultimate_finance/models/types.dart";
import "package:ultimate_finance/models/budget_category.dart";
import "package:ultimate_finance/models/transaction.dart";
import "package:ultimate_finance/data/repositories/abstract_data_repository.dart";
import "package:ultimate_finance/data/datasources/abstract_local_data_source.dart";
import "package:ultimate_finance/models/account.dart";
import "package:ultimate_finance/theme/app_theme.dart";
import "package:ultimate_finance/widgets/pie_chart.dart";

class DataRepository implements IDataRepository {
  final ILocalDataSource _localDataSource;

  DataRepository({required ILocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Stream<DashboardData> watchDashboardData(DateTime period, FinancialThemeExtension theme) {
    // Combine the three streams into one. When any of them update, this will re-fire.
    return Rx.combineLatest3(
      _localDataSource.watchAllBudgetCategories(),
      _localDataSource.watchBudgetPeriodsForMonth(period),
      _localDataSource.watchAllTransactions(),
      (allCategories, budgetPeriods, allTransactions) {
        
        // --- All the data processing from your old dashboard is now done here ---
        final categoryMap = {for (var cat in allCategories) cat.id: cat};
        final budgetMap = {for (var p in budgetPeriods) p.categoryId: p.budgetedAmount};
        final periodTransactions = allTransactions.where((t) => t.date.year == period.year && t.date.month == period.month).toList();

        final Map<int, double> trackedTotals = {};
        for (var transaction in periodTransactions) {
          trackedTotals.update(
            transaction.categoryId,
            (value) => value + transaction.amount,
            ifAbsent: () => transaction.amount,
          );
        }

        final incomeCategories = allCategories.where((c) => c.type == Types.income).toList();
        final expenseCategories = allCategories.where((c) => c.type == Types.expense).toList();
        final savingCategories = allCategories.where((c) => c.type == Types.saving).toList();
        final investmentCategories = allCategories.where((c) => c.type == Types.investment).toList();

        incomeCategories.sort((a, b) => (trackedTotals[b.id] ?? 0.0).compareTo(trackedTotals[a.id] ?? 0.0));
        expenseCategories.sort((a, b) => (trackedTotals[b.id] ?? 0.0).compareTo(trackedTotals[a.id] ?? 0.0));
        savingCategories.sort((a, b) => (trackedTotals[b.id] ?? 0.0).compareTo(trackedTotals[a.id] ?? 0.0));
        investmentCategories.sort((a, b) => (trackedTotals[b.id] ?? 0.0).compareTo(trackedTotals[a.id] ?? 0.0));

        final totalTrackedIncome = incomeCategories.fold(0.0, (sum, cat) => sum + (trackedTotals[cat.id] ?? 0.0));
        
        final List<PieSlice> allSlices = [];
        allSlices.addAll(_generateSlicesForType(categories: expenseCategories, totals: trackedTotals, baseColor: theme.expense));
        allSlices.addAll(_generateSlicesForType(categories: savingCategories, totals: trackedTotals, baseColor: theme.savings));
        allSlices.addAll(_generateSlicesForType(categories: investmentCategories, totals: trackedTotals, baseColor: theme.investment));
        
        return DashboardData(
          pieSlices: allSlices,
          totalTrackedIncome: totalTrackedIncome,
          incomeCategories: incomeCategories,
          expenseCategories: expenseCategories,
          savingCategories: savingCategories,
          investmentCategories: investmentCategories,
          trackedTotals: trackedTotals,
          budgetMap: budgetMap,
          totalBudgetedIncome: incomeCategories.fold(0.0, (sum, cat) => sum + (budgetMap[cat.id] ?? 0.0)),
          totalTrackedExpenses: expenseCategories.fold(0.0, (sum, cat) => sum + (trackedTotals[cat.id] ?? 0.0)),
          totalBudgetedExpenses: expenseCategories.fold(0.0, (sum, cat) => sum + (budgetMap[cat.id] ?? 0.0)),
          totalTrackedSavings: savingCategories.fold(0.0, (sum, cat) => sum + (trackedTotals[cat.id] ?? 0.0)),
          totalBudgetedSavings: savingCategories.fold(0.0, (sum, cat) => sum + (budgetMap[cat.id] ?? 0.0)),
          totalTrackedInvestments: investmentCategories.fold(0.0, (sum, cat) => sum + (trackedTotals[cat.id] ?? 0.0)),
          totalBudgetedInvestments: investmentCategories.fold(0.0, (sum, cat) => sum + (budgetMap[cat.id] ?? 0.0)),
        );
      },
    );
  }

  // Helper method moved here from the dashboard screen
  List<PieSlice> _generateSlicesForType({
    required List<BudgetCategory> categories,
    required Map<int, double> totals,
    required Color baseColor,
  }) {
    List<PieSlice> slices = [];
    final relevantCategories = categories.where((c) => totals.containsKey(c.id) && totals[c.id]! > 0).toList();
    relevantCategories.sort((a, b) => totals[b.id]!.compareTo(totals[a.id]!));
    for (int i = 0; i < relevantCategories.length; i++) {
      final category = relevantCategories[i];
      final totalValue = totals[category.id]!;
      final color = HSLColor.fromColor(baseColor).withLightness(0.35 + (i * 0.08)).toColor();
      slices.add(PieSlice(categoryName: category.name, totalValue: totalValue, color: color));
    }
    return slices;
  }

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
