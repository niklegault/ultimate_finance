import 'package:flutter/material.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/transaction.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/models/dashboard_data.dart';
import 'package:ultimate_finance/service_locator.dart';
import 'package:ultimate_finance/theme/app_theme.dart';
import 'package:ultimate_finance/widgets/pie_chart.dart';
import 'package:ultimate_finance/widgets/period_selector.dart';
import 'package:ultimate_finance/widgets/information_box.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<FinancialThemeExtension>()!;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 48, bottom: 8),
            child: PeriodSelector(
              selectedPeriod: _currentPeriod,
              onPeriodChanged: _handlePeriodChange,
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: StreamBuilder<DashboardData>(
              // Use the new, single stream from the repository
              stream: dataRepository.watchDashboardData(_currentPeriod, theme),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final data = snapshot.data!;

                return ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    const SizedBox(height: 10),
                    Row(children: [
                      InformationBox(
                        label: 'Savings Rate',
                        content: data.totalTrackedIncome > 0
                          ? '${(((data.totalTrackedSavings + data.totalTrackedInvestments) / data.totalTrackedIncome) * 100).toStringAsFixed(1)}%'
                          : 'N/A',
                      ),
                      InformationBox(
                        label: 'Monthly Balance',
                        content: data.totalTrackedIncome > 0
                            ? (data.totalTrackedIncome - (data.totalTrackedExpenses + data.totalTrackedInvestments + data.totalTrackedSavings)).toStringAsFixed(2)
                            : 'N/A',
                      )
                    ]),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PieChart(
                        slices: data.pieSlices,
                        totalIncome: data.totalTrackedIncome,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    _buildDashboardSection(
                      title: 'Income',
                      categories: data.incomeCategories,
                      budgetMap: data.budgetMap,
                      trackedTotals: data.trackedTotals,
                      totalBudgeted: data.totalBudgetedIncome,
                      totalTracked: data.totalTrackedIncome,
                      sectionColour: theme.income,
                    ),
                    _buildDashboardSection(
                      title: 'Expenses',
                      categories: data.expenseCategories,
                      budgetMap: data.budgetMap,
                      trackedTotals: data.trackedTotals,
                      totalBudgeted: data.totalBudgetedExpenses,
                      totalTracked: data.totalTrackedExpenses,
                      sectionColour: theme.expense,
                    ),
                    _buildDashboardSection(
                      title: 'Savings',
                      categories: data.savingCategories,
                      budgetMap: data.budgetMap,
                      trackedTotals: data.trackedTotals,
                      totalBudgeted: data.totalBudgetedSavings,
                      totalTracked: data.totalTrackedSavings,
                      sectionColour: theme.savings,
                    ),
                    _buildDashboardSection(
                      title: 'Investments',
                      categories: data.investmentCategories,
                      budgetMap: data.budgetMap,
                      trackedTotals: data.trackedTotals,
                      totalBudgeted: data.totalBudgetedInvestments,
                      totalTracked: data.totalTrackedInvestments,
                      sectionColour: theme.investment,
                    ),
        ],

      );
              },
            ),
          ),
        ],
      ),
    );





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
