import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/widgets/pie_chart.dart';

class DashboardData {
  final List<PieSlice> pieSlices;
  final double totalTrackedIncome;
  
  final List<BudgetCategory> incomeCategories;
  final List<BudgetCategory> expenseCategories;
  final List<BudgetCategory> savingCategories;
  final List<BudgetCategory> investmentCategories;
  
  final Map<int, double> trackedTotals;
  final Map<int, double> budgetMap;

  final double totalBudgetedIncome;
  final double totalBudgetedExpenses;
  final double totalBudgetedSavings;
  final double totalBudgetedInvestments;

  final double totalTrackedExpenses;
  final double totalTrackedSavings;
  final double totalTrackedInvestments;

  DashboardData({
    required this.pieSlices,
    required this.totalTrackedIncome,
    required this.incomeCategories,
    required this.expenseCategories,
    required this.savingCategories,
    required this.investmentCategories,
    required this.trackedTotals,
    required this.budgetMap,
    required this.totalBudgetedIncome,
    required this.totalBudgetedExpenses,
    required this.totalBudgetedSavings,
    required this.totalBudgetedInvestments,
    required this.totalTrackedExpenses,
    required this.totalTrackedSavings,
    required this.totalTrackedInvestments,
  });
}