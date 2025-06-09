import 'package:flutter/material.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/transaction.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/theme/app_theme.dart';
import 'package:ultimate_finance/widgets/information_box.dart';

List<BudgetCategory> _allBudgetCategories = [
  BudgetCategory(name: 'Salary', type: Types.income),
  BudgetCategory(name: 'Groceries', type: Types.expense),
  BudgetCategory(name: 'Savings Account', type: Types.saving),
  BudgetCategory(name: 'Stocks', type: Types.investment),
  BudgetCategory(name: 'Dining Out', type: Types.expense),
];

List<Transaction> _allTransactions = [
  Transaction(
    type: Types.income,
    category: _allBudgetCategories[0],
    amount: 5000.00,
    date: DateTime.now(),
    description: 'Monthly salary',
  ),
  Transaction(
    type: Types.expense,
    category: _allBudgetCategories[1],
    amount: 200.00,
    date: DateTime.now(),
    description: 'Weekly groceries',
  ),
  Transaction(
    type: Types.saving,
    category: _allBudgetCategories[2],
    amount: 300.00,
    date: DateTime.now(),
    description: 'Monthly savings deposit',
  ),
];

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late List<BudgetCategory> _incomeCategories;
  late List<BudgetCategory> _expenseCategories;
  late List<BudgetCategory> _savingCategories;
  late List<BudgetCategory> _investmentCategories;

  final _formKey = GlobalKey<FormState>();
  Types? _itemType;
  BudgetCategory? _itemCategory;
  double _amount = 0.00;
  DateTime _date = DateTime.now();
  String _notes = '';

  @override
  void initState() {
    super.initState();
    _filterCategories();
  }

  void _filterCategories() {
    _incomeCategories =
        _allBudgetCategories
            .where((category) => category.type == Types.income)
            .toList();
    _expenseCategories =
        _allBudgetCategories
            .where((category) => category.type == Types.expense)
            .toList();
    _savingCategories =
        _allBudgetCategories
            .where((category) => category.type == Types.saving)
            .toList();
    _investmentCategories =
        _allBudgetCategories
            .where((category) => category.type == Types.investment)
            .toList();
  }

  Widget _buildTrackedItem(Transaction transaction) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getTypeColor(transaction.type),
          child: Icon(_getTypeIcon(transaction.type), color: Colors.white),
        ),
        title: Text(
          transaction.category.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${transaction.type.toString().split('.').last} • ${_formatDate(transaction.date)}",
              style: const TextStyle(fontSize: 12),
            ),
            if (transaction.description != null &&
                transaction.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  transaction.description!,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
          ],
        ),
        trailing: Text(
          "${transaction.type == Types.expense ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _getTypeColor(transaction.type),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Helper to get color based on transaction type
  Color _getTypeColor(Types type) {
    final theme = Theme.of(context).extension<FinancialThemeExtension>()!;
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

  // Helper to get icon based on transaction type
  IconData _getTypeIcon(Types type) {
    switch (type) {
      case Types.income:
        return Icons.account_balance;
      case Types.expense:
        return Icons.shopping_cart_checkout;
      case Types.saving:
        return Icons.savings;
      case Types.investment:
        return Icons.trending_up;
    }
  }

  // Helper to format date
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Transaction _addTransaction(
    Types type,
    BudgetCategory category,
    double amount,
    DateTime date, {
    String notes = '',
  }) {
    final transaction = Transaction(
      type: type,
      category: category,
      amount: amount,
      date: date,
      description: notes,
    );
    _allTransactions.add(transaction);
    return transaction;
  }

  Future<void> _showAddItemDialog() {
    _itemType = null;
    _itemCategory = null;
    _amount = 0.00;
    _date = DateTime.now();
    _notes = '';
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add New Item'),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: ListBody(
                    children: <Widget>[
                      DropdownButtonFormField<Types>(
                        decoration: const InputDecoration(
                          hintText: 'Select item type',
                        ),
                        value: _itemType,
                        items:
                            Types.values.map((type) {
                              return DropdownMenuItem<Types>(
                                value: type,
                                child: Text(type.toString().split('.').last),
                              );
                            }).toList(),
                        onChanged: (Types? newValue) {
                          setState(() {
                            _itemType = newValue;
                            _itemCategory =
                                null; // Reset category when type changes
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an item type';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _itemType = value;
                        },
                      ),
                      DropdownButtonFormField<BudgetCategory>(
                        decoration: const InputDecoration(
                          hintText: 'Select category',
                        ),
                        value: _itemCategory,
                        items:
                            (_itemType == null
                                    ? <BudgetCategory>[]
                                    : _allBudgetCategories
                                        .where((cat) => cat.type == _itemType)
                                        .toList())
                                .map((category) {
                                  return DropdownMenuItem<BudgetCategory>(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                })
                                .toList(),
                        onChanged: (BudgetCategory? newValue) {
                          setState(() {
                            _itemCategory = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _itemCategory = value;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter item amount',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter item amount';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _amount = double.tryParse(value!) ?? 0.00;
                        },
                      ),
                      GestureDetector(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _date = pickedDate;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Select date',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            controller: TextEditingController(
                              text:
                                  "${_date.year}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}",
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter notes (optional)',
                        ),
                        onSaved: (value) {
                          _notes = value ?? '';
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (_itemType != null && _itemCategory != null) {
                        _addTransaction(
                          _itemType!,
                          _itemCategory!,
                          _amount,
                          _date,
                          notes: _notes,
                        );
                        Navigator.of(context).pop();
                      }
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

  Widget _buildTrackedList() {
    return Column(
      children: [
        ..._allTransactions.map(
          (transaction) => _buildTrackedItem(transaction),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Track New Item'),
          onTap: () {
            _showAddItemDialog();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<FinancialThemeExtension>()!;

    return Column(
      children: [
        Row(
          children: [
            InformationBox(label: "Tracked Records", content: "5"),
            InformationBox(label: "Monthly Balance", content: "\$1500"),
          ],
        ),
        _buildTrackedList(),
      ],
    );
  }
}
