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

  // --- Helper to generate shades. Darkest for the highest value. ---
  List<PieSlice> _generateSlicesForType({
    required List<BudgetCategory> categories,
    required Map<int, double> totals,
    required Color baseColor,
  }) {
    List<PieSlice> slices = [];

    // Create a list of categories that actually have transactions
    final relevantCategories =
        categories
            .where((c) => totals.containsKey(c.id) && totals[c.id]! > 0)
            .toList();

    // Sort them by their total value in descending order
    relevantCategories.sort((a, b) => totals[b.id]!.compareTo(totals[a.id]!));

    // Generate a slice with a unique shade for each category
    for (int i = 0; i < relevantCategories.length; i++) {
      final category = relevantCategories[i];
      final totalValue = totals[category.id]!;

      // The first item (i=0) will be the darkest.
      final color =
          HSLColor.fromColor(baseColor)
              .withLightness(0.35 + (i * 0.08)) // Adjust lightness for shading
              .toColor();

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
      body: SingleChildScrollView(
        child: Column(
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
            const SizedBox(height: 20),
            const Text(
              'Spending Breakdown',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // This is the main data-handling part of the screen
            StreamBuilder<List<BudgetCategory>>(
              stream: dataRepository.watchAllBudgetCategories(),
              builder: (context, categoriesSnapshot) {
                return StreamBuilder<List<Transaction>>(
                  stream: dataRepository.watchAllTransactions(),
                  builder: (context, transactionsSnapshot) {
                    if (!categoriesSnapshot.hasData ||
                        !transactionsSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final allCategories = categoriesSnapshot.data!;
                    final categoryMap = {
                      for (var cat in allCategories) cat.id: cat,
                    };

                    // Filter transactions for the selected period
                    final periodTransactions =
                        transactionsSnapshot.data!.where((t) {
                          return t.date.year == _currentPeriod.year &&
                              t.date.month == _currentPeriod.month;
                        }).toList();

                    // --- Data Processing ---
                    double totalIncome = 0;
                    final Map<int, double> categoryTotals = {};

                    for (var transaction in periodTransactions) {
                      final category = categoryMap[transaction.categoryId];
                      if (category == null) continue;

                      if (category.type == Types.income) {
                        totalIncome += transaction.amount;
                      } else {
                        categoryTotals.update(
                          category.id,
                          (value) => value + transaction.amount,
                          ifAbsent: () => transaction.amount,
                        );
                      }
                    }

                    // --- Generate Slices with Shaded Colors ---
                    final List<PieSlice> allSlices = [];
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

                    allSlices.addAll(
                      _generateSlicesForType(
                        categories: expenseCategories,
                        totals: categoryTotals,
                        baseColor: theme.expense,
                      ),
                    );
                    allSlices.addAll(
                      _generateSlicesForType(
                        categories: savingCategories,
                        totals: categoryTotals,
                        baseColor: theme.savings,
                      ),
                    );
                    allSlices.addAll(
                      _generateSlicesForType(
                        categories: investmentCategories,
                        totals: categoryTotals,
                        baseColor: theme.investment,
                      ),
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PieChart(
                        slices: allSlices,
                        totalIncome: totalIncome,
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            // TODO: Add a legend here using the generated `allSlices` data
          ],
        ),
      ),
    );
  }
}
