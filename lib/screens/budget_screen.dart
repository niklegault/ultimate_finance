import 'package:flutter/material.dart';
import 'package:ultimate_finance/data/repositories/abstract_data_repository.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/theme/app_theme.dart';
import 'package:ultimate_finance/widgets/period_selector.dart';
import 'package:ultimate_finance/service_locator.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  DateTime _currentPeriod = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  void _handlePeriodChange(DateTime? newPeriod) {
    setState(() {
      // Use the current month if null is passed, otherwise use the selected month.
      _currentPeriod = newPeriod ?? DateTime.now();
      print('Selected period: $_currentPeriod');
    });
  }

  // --- Database Methods ---
  Future<void> _addCategory(Types type, String name, double budgetedAmount) async {
    // We first add the category to get its ID, then add the budgeted amount for the current month.
    // In a real app, you might want to wrap this in a transaction.
    await dataRepository.addBudgetCategory(name, type);
    // This is a simplified approach. A more robust way would be to get the newly created category's ID
    // and then use it to add the budgeted amount. For now, we'll add the amount in the dialog.
  }

  Future<void> _updateBudgetedAmount(int categoryId, double amount) async {
    await dataRepository.updateBudgetPeriod(categoryId, _currentPeriod, amount);
  }

  // --- Dialogs ---
  Future<void> _showAddCategoryDialog(Types type) async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Add New ${type.name} Category'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Category Name'),
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter a name' : null,
                ),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Budgeted Amount'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                   validator: (value) {
                      if (value == null || value.isEmpty || double.tryParse(value) == null) {
                        return 'Please enter a valid amount';
                      }
                      return null;
                    },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(child: const Text('Cancel'), onPressed: () => Navigator.of(dialogContext).pop()),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = nameController.text;
                  final amount = double.parse(amountController.text);
                  _addCategory(type, name, amount);
                  // After adding, we would ideally get the new category's ID
                  // and call _updateBudgetedAmount. This part of the logic
                  // will be more robust as the repository evolves.
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditCategoryDialog(BudgetCategory category, BudgetPeriod? budgetedAmount) async {
    final amountController = TextEditingController(text: budgetedAmount?.budgetedAmount.toStringAsFixed(2) ?? '0.00');

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Edit Budget for ${category.name}'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Budgeted Amount'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty || double.tryParse(value) == null) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(child: const Text('Cancel'), onPressed: () => Navigator.of(dialogContext).pop()),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newAmount = double.parse(amountController.text);
                  _updateBudgetedAmount(category.id, newAmount);
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    final financialTheme = Theme.of(context).extension<FinancialThemeExtension>()!;

    return Column(
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
          // This top-level StreamBuilder gets all categories once.
          child: StreamBuilder<List<BudgetCategory>>(
            stream: dataRepository.watchAllBudgetCategories(),
            builder: (context, categoriesSnapshot) {
              if (!categoriesSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final allCategories = categoriesSnapshot.data!;
              
              // This nested StreamBuilder gets the budgeted amounts for the selected month.
              return StreamBuilder<List<BudgetPeriod>>(
                stream: dataRepository.watchBudgetPeriodsForMonth(_currentPeriod),
                builder: (context, amountsSnapshot) {
                  final budgetedAmounts = amountsSnapshot.data ?? [];

                  // Create a map for quick lookup of budgeted amounts by category ID.
                  final amountMap = {for (var e in budgetedAmounts) e.categoryId: e};

                  // Filter categories into their respective types.
                  final incomeCategories = allCategories.where((c) => c.type == Types.income).toList();
                  final expenseCategories = allCategories.where((c) => c.type == Types.expense).toList();
                  final savingCategories = allCategories.where((c) => c.type == Types.saving).toList();
                  final investmentCategories = allCategories.where((c) => c.type == Types.investment).toList();

                  // Calculate totals using the amountMap.
                  final totalIncome = incomeCategories.fold(0.0, (sum, cat) => sum + (amountMap[cat.id]?.budgetedAmount ?? 0.0));
                  final totalExpenses = expenseCategories.fold(0.0, (sum, cat) => sum + (amountMap[cat.id]?.budgetedAmount ?? 0.0));
                  final totalSavings = savingCategories.fold(0.0, (sum, cat) => sum + (amountMap[cat.id]?.budgetedAmount ?? 0.0));
                  final totalInvestments = investmentCategories.fold(0.0, (sum, cat) => sum + (amountMap[cat.id]?.budgetedAmount ?? 0.0));
                  final unallocatedIncome = totalIncome - totalExpenses - totalSavings - totalInvestments;

                  return Column(
                    children: [
                       Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          unallocatedIncome == 0
                              ? 'Budget is Balanced'
                              : 'Unallocated: \$${unallocatedIncome.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: unallocatedIncome >= 0 ? financialTheme.income : financialTheme.expense,
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(8.0),
                          children: <Widget>[
                            _buildCategorySection(
                              title: 'Income',
                              categories: incomeCategories,
                              amountMap: amountMap,
                              type: Types.income,
                              sectionColour: financialTheme.income,
                              total: totalIncome,
                            ),
                            _buildCategorySection(
                              title: 'Expenses',
                              categories: expenseCategories,
                              amountMap: amountMap,
                              type: Types.expense,
                              sectionColour: financialTheme.expense,
                              total: totalExpenses,
                            ),
                             _buildCategorySection(
                              title: 'Savings',
                              categories: savingCategories,
                              amountMap: amountMap,
                              type: Types.saving,
                              sectionColour: financialTheme.savings,
                              total: totalSavings,
                            ),
                             _buildCategorySection(
                              title: 'Investments',
                              categories: investmentCategories,
                              amountMap: amountMap,
                              type: Types.investment,
                              sectionColour: financialTheme.investment,
                              total: totalInvestments,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection({
    required String title,
    required List<BudgetCategory> categories,
    required Map<int, BudgetPeriod> amountMap,
    required Types type,
    required Color sectionColour,
    required double total,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        initiallyExpanded: true,
        leading: Icon(
          type == Types.income ? Icons.arrow_downward : Icons.arrow_upward,
          color: sectionColour,
        ),
        title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: sectionColour)),
        trailing: Text('\$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: sectionColour)),
        children: <Widget>[
          ...categories.map((category) {
            final budgetedAmount = amountMap[category.id];
            return ListTile(
              title: Text(category.name),
              onTap: () => _showEditCategoryDialog(category, budgetedAmount),
              trailing: Text(
                '\$${budgetedAmount?.budgetedAmount.toStringAsFixed(2) ?? '0.00'}',
                style: const TextStyle(fontSize: 16),
              ),
            );
          }),
          ListTile(
            leading: Icon(Icons.add, color: sectionColour),
            title: Text('Add New $title Category', style: TextStyle(color: sectionColour)),
            onTap: () => _showAddCategoryDialog(type),
          ),
        ],
      ),
    );
  }
}
