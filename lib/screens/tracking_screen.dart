import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/transaction.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/service_locator.dart';
import 'package:ultimate_finance/theme/app_theme.dart';
import 'package:ultimate_finance/widgets/information_box.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final _formKey = GlobalKey<FormState>();

  // --- Database Methods ---
  Future<void> _addTransaction({
    required Types type,
    required int categoryId,
    required double amount,
    required DateTime date,
    required String notes,
  }) async {
    await dataRepository.addTransaction(
      type: type,
      categoryId: categoryId,
      amount: amount,
      date: date,
      description: notes,
    );
  }

  Future<void> _updateTransaction(Transaction transaction) async {
    await dataRepository.updateTransaction(transaction);
  }

  Future<void> _deleteTransaction(int transactionId) async {
    await dataRepository.deleteTransaction(transactionId);
  }

  // --- Dialogs ---
  Future<void> _showAddItemDialog(List<BudgetCategory> allCategories) async {
    Types? selectedType;
    BudgetCategory? selectedCategory;
    final amountController = TextEditingController();
    final notesController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            final filteredCategories =
                allCategories.where((cat) => cat.type == selectedType).toList();

            return AlertDialog(
              title: const Text('Add New Transaction'),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: ListBody(
                    children: <Widget>[
                      DropdownButtonFormField<Types>(
                        decoration: const InputDecoration(labelText: 'Type'),
                        value: selectedType,
                        onChanged: (Types? newValue) {
                          setState(() {
                            selectedType = newValue;
                            selectedCategory = null;
                          });
                        },
                        items: Types.values
                            .map((type) =>
                                DropdownMenuItem(value: type, child: Text(type.name)))
                            .toList(),
                        validator: (v) =>
                            v == null ? 'Please select a type' : null,
                      ),
                      if (selectedType != null)
                        DropdownButtonFormField<BudgetCategory>(
                          decoration:
                              const InputDecoration(labelText: 'Category'),
                          value: selectedCategory,
                          onChanged: (BudgetCategory? newValue) =>
                              setState(() => selectedCategory = newValue),
                          items: filteredCategories
                              .map((cat) => DropdownMenuItem(
                                  value: cat, child: Text(cat.name)))
                              .toList(),
                          validator: (v) =>
                              v == null ? 'Please select a category' : null,
                        ),
                      TextFormField(
                        controller: amountController,
                        decoration: const InputDecoration(labelText: 'Amount'),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (v) => (v == null ||
                                v.isEmpty ||
                                double.tryParse(v) == null)
                            ? 'Enter a valid amount'
                            : null,
                      ),
                      TextFormField(
                        controller: notesController,
                        decoration:
                            const InputDecoration(labelText: 'Notes (Optional)'),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                            "Date: ${DateFormat.yMd().format(selectedDate)}"),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() => selectedDate = pickedDate);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(dialogContext).pop()),
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addTransaction(
                        type: selectedType!,
                        categoryId: selectedCategory!.id,
                        amount: double.parse(amountController.text),
                        date: selectedDate,
                        notes: notesController.text,
                      );
                      Navigator.of(dialogContext).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTrackedItem(
    Transaction transaction,
    Map<int, BudgetCategory> categoryMap,
  ) {
    final theme = Theme.of(context).extension<FinancialThemeExtension>()!;
    final category = categoryMap[transaction.categoryId];
    if (category == null) {
      return const SizedBox.shrink();
    }

    final color = _getTypeColor(category.type, theme);
    final icon = _getTypeIcon(category.type);
    final sign = category.type == Types.income ? '+' : '-';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(category.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: Text(
          "$sign\$${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: color, fontSize: 16),
        ),
        onTap: () {
          // TODO: Implement _showEditItemDialog
        },
      ),
    );
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BudgetCategory>>(
      stream: dataRepository.watchAllBudgetCategories(),
      builder: (context, categoriesSnapshot) {
        if (!categoriesSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final allCategories = categoriesSnapshot.data!;
        final categoryMap = {for (var cat in allCategories) cat.id: cat};

        // This nested StreamBuilder now watches the real transaction stream
        return StreamBuilder<List<Transaction>>(
          // --- THIS IS THE KEY FIX ---
          stream: dataRepository.watchAllTransactions(),
          builder: (context, transactionsSnapshot) {
            // Use the data if available, otherwise an empty list.
            final allTransactions = transactionsSnapshot.data ?? [];
            
            // Sort transactions by date, most recent first.
            allTransactions.sort((a, b) => b.date.compareTo(a.date));

            final monthlyTransactions = allTransactions.where((t) {
              final now = DateTime.now();
              return t.date.year == now.year && t.date.month == now.month;
            }).toList();

            final monthBalance = monthlyTransactions.fold<double>(0.0, (sum, t) {
              final category = categoryMap[t.categoryId];
              if (category?.type == Types.income) return sum + t.amount;
              if (category?.type == Types.expense) return sum - t.amount;
              return sum; // Savings and Investments don't affect the balance
            });

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 48.0, bottom: 8.0),
                  child: Row(
                    children: [
                      InformationBox(
                        label: "Transactions (This Month)",
                        content: "${monthlyTransactions.length}",
                      ),
                      InformationBox(
                        label: "Monthly Balance",
                        content: "\$${monthBalance.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Icon(Icons.add),
                  onTap: () => _showAddItemDialog(allCategories),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: allTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = allTransactions[index];
                      return _buildTrackedItem(transaction, categoryMap);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --- Helper Functions ---
  Color _getTypeColor(Types type, FinancialThemeExtension theme) {
    switch (type) {
      case Types.income:
        return theme.income;
      case Types.expense:
        return theme.expense;
      case Types.saving:
        return theme.savings;
      case Types.investment:
        return theme.investment;
    }
  }

  IconData _getTypeIcon(Types type) {
    switch (type) {
      case Types.income:
        return Icons.arrow_downward;
      case Types.expense:
        return Icons.arrow_upward;
      case Types.saving:
        return Icons.savings;
      case Types.investment:
        return Icons.trending_up;
    }
  }
}