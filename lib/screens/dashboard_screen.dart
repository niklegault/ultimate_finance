import 'package:flutter/material.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/transaction.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/service_locator.dart';
import 'package:ultimate_finance/theme/app_theme.dart';
import 'package:ultimate_finance/widgets/pie_chart.dart';
import 'package:ultimate_finance/widgets/period_selector.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime _currentPeriod = DateTime.now();

  void _handlePeriodChange(DateTime? newPeriod) {
    setState(() {
      _currentPeriod = newPeriod ?? DateTime.now();
    });
  }

  // Helper to generate pie chart slices with shaded colors.
  List<PieSlice> _generateSlicesForType({
    required List<BudgetCategory> categories,
    required Map<int, double> totals,
    required Color baseColor,
  }) {
    List<PieSlice> slices = [];
    final relevantCategories =
        categories
            .where((c) => totals.containsKey(c.id) && totals[c.id]! > 0)
            .toList();
    relevantCategories.sort((a, b) => totals[b.id]!.compareTo(totals[a.id]!));

    for (int i = 0; i < relevantCategories.length; i++) {
      final category = relevantCategories[i];
      final totalValue = totals[category.id]!;
      final color =
          HSLColor.fromColor(
            baseColor,
          ).withLightness(0.35 + (i * 0.08)).toColor();
      slices.add(
        PieSlice(
          categoryName: category.name,
          totalValue: totalValue,
          color: color,
        ),
      );
    }
    return slices;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<FinancialThemeExtension>()!;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 48,
              bottom: 8,
            ),
            child: PeriodSelector(
              selectedPeriod: _currentPeriod,
              onPeriodChanged: _handlePeriodChange,
            ),
          ),
          const Divider(height: 1),

          Expanded(
            child: StreamBuilder<List<BudgetCategory>>(
              stream: dataRepository.watchAllBudgetCategories(),
              builder: (context, categoriesSnapshot) {
                return StreamBuilder<List<BudgetPeriod>>(
                  stream: dataRepository.watchBudgetPeriodsForMonth(
                    _currentPeriod,
                  ),
                  builder: (context, periodsSnapshot) {
                    return StreamBuilder<List<Transaction>>(
                      stream: dataRepository.watchAllTransactions(),
                      builder: (context, transactionsSnapshot) {
                        if (!categoriesSnapshot.hasData ||
                            !periodsSnapshot.hasData ||
                            !transactionsSnapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // --- Data Processing ---
                        final allCategories = categoriesSnapshot.data!;
                        final budgetPeriods = periodsSnapshot.data!;
                        final budgetMap = {
                          for (var p in budgetPeriods)
                            p.categoryId: p.budgetedAmount,
                        };

                        final periodTransactions =
                            transactionsSnapshot.data!.where((t) {
                              return t.date.year == _currentPeriod.year &&
                                  t.date.month == _currentPeriod.month;
                            }).toList();

                        final Map<int, double> trackedTotals = {};
                        for (var transaction in periodTransactions) {
                          trackedTotals.update(
                            transaction.categoryId,
                            (value) => value + transaction.amount,
                            ifAbsent: () => transaction.amount,
                          );
                        }

                        // --- Generate Pie Chart Slices & Calculate Totals ---
                        final incomeCategories =
                            allCategories
                                .where((c) => c.type == Types.income)
                                .toList();
                        final expenseCategories =
                            allCategories
                                .where((c) => c.type == Types.expense)
                                .toList();
                        final savingCategories =
                            allCategories
                                .where((c) => c.type == Types.saving)
                                .toList();
                        final investmentCategories =
                            allCategories
                                .where((c) => c.type == Types.investment)
                                .toList();

                        // --- THIS IS THE KEY CHANGE ---
                        // Sort each list by the tracked total in descending order.
                        incomeCategories.sort(
                          (a, b) => (trackedTotals[b.id] ?? 0.0).compareTo(
                            trackedTotals[a.id] ?? 0.0,
                          ),
                        );
                        expenseCategories.sort(
                          (a, b) => (trackedTotals[b.id] ?? 0.0).compareTo(
                            trackedTotals[a.id] ?? 0.0,
                          ),
                        );
                        savingCategories.sort(
                          (a, b) => (trackedTotals[b.id] ?? 0.0).compareTo(
                            trackedTotals[a.id] ?? 0.0,
                          ),
                        );
                        investmentCategories.sort(
                          (a, b) => (trackedTotals[b.id] ?? 0.0).compareTo(
                            trackedTotals[a.id] ?? 0.0,
                          ),
                        );

                        final totalTrackedIncomeForPie = incomeCategories.fold(
                          0.0,
                          (sum, cat) => sum + (trackedTotals[cat.id] ?? 0.0),
                        );

                        final List<PieSlice> allSlices = [];
                        allSlices.addAll(
                          _generateSlicesForType(
                            categories: expenseCategories,
                            totals: trackedTotals,
                            baseColor: theme.expense,
                          ),
                        );
                        allSlices.addAll(
                          _generateSlicesForType(
                            categories: savingCategories,
                            totals: trackedTotals,
                            baseColor: theme.savings,
                          ),
                        );
                        allSlices.addAll(
                          _generateSlicesForType(
                            categories: investmentCategories,
                            totals: trackedTotals,
                            baseColor: theme.investment,
                          ),
                        );

                        // Calculate total budgeted/tracked amounts for each type for the list view
                        final totalTrackedIncome = incomeCategories.fold(
                          0.0,
                          (sum, cat) => sum + (trackedTotals[cat.id] ?? 0.0),
                        );
                        final totalBudgetedIncome = incomeCategories.fold(
                          0.0,
                          (sum, cat) => sum + (budgetMap[cat.id] ?? 0.0),
                        );
                        final totalTrackedExpenses = expenseCategories.fold(
                          0.0,
                          (sum, cat) => sum + (trackedTotals[cat.id] ?? 0.0),
                        );
                        final totalBudgetedExpenses = expenseCategories.fold(
                          0.0,
                          (sum, cat) => sum + (budgetMap[cat.id] ?? 0.0),
                        );
                        final totalTrackedSavings = savingCategories.fold(
                          0.0,
                          (sum, cat) => sum + (trackedTotals[cat.id] ?? 0.0),
                        );
                        final totalBudgetedSavings = savingCategories.fold(
                          0.0,
                          (sum, cat) => sum + (budgetMap[cat.id] ?? 0.0),
                        );
                        final totalTrackedInvestments = investmentCategories
                            .fold(
                              0.0,
                              (sum, cat) =>
                                  sum + (trackedTotals[cat.id] ?? 0.0),
                            );
                        final totalBudgetedInvestments = investmentCategories
                            .fold(
                              0.0,
                              (sum, cat) => sum + (budgetMap[cat.id] ?? 0.0),
                            );

                        return ListView(
                          padding: const EdgeInsets.all(8.0),
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Spending Breakdown',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: PieChart(
                                slices: allSlices,
                                totalIncome: totalTrackedIncomeForPie,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Divider(),

                            // --- List View Sections ---
                            _buildDashboardSection(
                              title: 'Income',
                              categories: incomeCategories,
                              budgetMap: budgetMap,
                              trackedTotals: trackedTotals,
                              totalBudgeted: totalBudgetedIncome,
                              totalTracked: totalTrackedIncome,
                              sectionColour: theme.income,
                            ),
                            _buildDashboardSection(
                              title: 'Expenses',
                              categories: expenseCategories,
                              budgetMap: budgetMap,
                              trackedTotals: trackedTotals,
                              totalBudgeted: totalBudgetedExpenses,
                              totalTracked: totalTrackedExpenses,
                              sectionColour: theme.expense,
                            ),
                            _buildDashboardSection(
                              title: 'Savings',
                              categories: savingCategories,
                              budgetMap: budgetMap,
                              trackedTotals: trackedTotals,
                              totalBudgeted: totalBudgetedSavings,
                              totalTracked: totalTrackedSavings,
                              sectionColour: theme.savings,
                            ),
                            _buildDashboardSection(
                              title: 'Investments',
                              categories: investmentCategories,
                              budgetMap: budgetMap,
                              trackedTotals: trackedTotals,
                              totalBudgeted: totalBudgetedInvestments,
                              totalTracked: totalTrackedInvestments,
                              sectionColour: theme.investment,
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // This helper widget to build each section remains the same
  Widget _buildDashboardSection({
    required String title,
    required List<BudgetCategory> categories,
    required Map<int, double> budgetMap,
    required Map<int, double> trackedTotals,
    required double totalBudgeted,
    required double totalTracked,
    required Color sectionColour,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: sectionColour,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Tracked: \$${totalTracked.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Budgeted: \$${totalBudgeted.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Tracked / Budgeted",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ...categories
              .where(
                (cat) =>
                    (budgetMap[cat.id] ?? 0) > 0 ||
                    (trackedTotals[cat.id] ?? 0) > 0,
              )
              .map((category) {
                final budgeted = budgetMap[category.id] ?? 0.0;
                final tracked = trackedTotals[category.id] ?? 0.0;
                return ListTile(
                  title: Text(category.name),
                  trailing: Text(
                    "\$${tracked.toStringAsFixed(2)} / \$${budgeted.toStringAsFixed(2)}",
                  ),
                );
              })
              .toList(),
        ],
      ),
    );
  }
}
