import 'package:flutter/material.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/theme/app_theme.dart';
import 'package:ultimate_finance/widgets/period_selector.dart';

List<BudgetCategory> _allBudgetCategories = [];

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  DateTime? _currentPeriod;

  late List<BudgetCategory> _incomeCategories;
  late double _totalIncome;
  late List<BudgetCategory> _expenseCategories;
  late double _totalExpenses;
  late List<BudgetCategory> _savingCategories;
  late double _totalSavings;
  late List<BudgetCategory> _investmentCategories;
  late double _totalInvestments;
  late double _unallocatedIncome;

  // Controller for Adding a new category
  final _formKey = GlobalKey<FormState>();
  String? _newCategoryName;
  double? _budgetedAmount;

  @override
  void initState() {
    super.initState();
    _currentPeriod = null;
    _filterCategorioes();
  }

  void _handlePeriodChange(DateTime? newPeriod) {
    setState(() {
      _currentPeriod = newPeriod;
    });
  }

  void _filterCategorioes() {
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

  void _calculateTotals() {
    _totalIncome = _incomeCategories.fold(
      0.0,
      (sum, category) =>
          sum +
          (category
                  .getPeriod(_currentPeriod ?? DateTime.now())
                  ?.budgetedAmount ??
              0.0),
    );
    _totalExpenses = _expenseCategories.fold(
      0.0,
      (sum, category) =>
          sum +
          (category
                  .getPeriod(_currentPeriod ?? DateTime.now())
                  ?.budgetedAmount ??
              0.0),
    );
    _totalSavings = _savingCategories.fold(
      0.0,
      (sum, category) =>
          sum +
          (category
                  .getPeriod(_currentPeriod ?? DateTime.now())
                  ?.budgetedAmount ??
              0.0),
    );
    _totalInvestments = _investmentCategories.fold(
      0.0,
      (sum, category) =>
          sum +
          (category
                  .getPeriod(_currentPeriod ?? DateTime.now())
                  ?.budgetedAmount ??
              0.0),
    );
    _unallocatedIncome =
        _totalIncome - _totalExpenses - _totalSavings - _totalInvestments;
  }

  BudgetCategory _addCategory(Types type, String name) {
    BudgetCategory newCategory = BudgetCategory(name: name, type: type);
    setState(() {
      _allBudgetCategories.add(newCategory);
      _filterCategorioes();
    });
    return newCategory;
  }

  Future<void> _showEditCategoryDialog(BudgetCategory category) async {
    String updateCategoryName = category.name;
    double? updatedBudgetedAmount =
        category.getPeriod(_currentPeriod ?? DateTime.now())?.budgetedAmount;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${category.type.name} Category'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    initialValue: category.name,
                    decoration: const InputDecoration(
                      hintText: 'Enter category name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      updateCategoryName = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: updatedBudgetedAmount?.toString() ?? '0.0',
                    decoration: const InputDecoration(
                      hintText: 'Enter budgeted amount',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a budgeted amount';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      updatedBudgetedAmount = double.tryParse(value!);
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
              child: const Text('Update'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {
                    var updatedCategory = category;
                    updatedCategory.name = updateCategoryName;

                    updatedCategory
                        .getPeriod(_currentPeriod ?? DateTime.now())
                        ?.setBudgetedAmount(updatedBudgetedAmount ?? 0.00);

                    _allBudgetCategories.remove(category);
                    _allBudgetCategories.add(updatedCategory);
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddCategoryDialog(Types type) async {
    _newCategoryName = null;
    _budgetedAmount = 0.0;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New ${type.name} Category'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter category name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newCategoryName = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter budgeted amount',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a budgeted amount';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _budgetedAmount = double.tryParse(value!);
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
                  if (_newCategoryName != null) {
                    var addedCategory = _addCategory(type, _newCategoryName!);
                    addedCategory.addPeriod(
                      _currentPeriod ?? DateTime.now(),
                      _budgetedAmount ?? 0.0,
                    );
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategorySection({
    required String title,
    required List<BudgetCategory> categories,
    required Types type,
    required Color sectionColour,
  }) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        initiallyExpanded: true,
        leading: Icon(
          type == Types.income
              ? Icons.account_balance
              : type == Types.expense
              ? Icons.shopping_cart_checkout
              : type == Types.saving
              ? Icons.savings
              : Icons.trending_up,
          color: sectionColour,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: sectionColour,
          ),
        ),
        trailing: Text(
          '\$ ${type == Types.income
              ? _totalIncome
              : type == Types.expense
              ? _totalExpenses
              : type == Types.saving
              ? _totalSavings
              : _totalInvestments}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: sectionColour,
          ),
        ),
        children: <Widget>[
          ...categories.map(
            (category) => ListTile(
              title: Text(category.name),
              onTap: () {
                _showEditCategoryDialog(category);
              },
              trailing: Text(
                '\$ ${category.getPeriod(_currentPeriod ?? DateTime.now())?.budgetedAmount ?? '0.00'}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add, color: sectionColour),
            title: Text(
              'Add New $title Category',
              style: TextStyle(color: sectionColour),
            ),
            onTap: () {
              _showAddCategoryDialog(type);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<FinancialThemeExtension>()!;
    _calculateTotals();

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
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            _unallocatedIncome == 0
                ? 'Budget is Balanced'
                : _unallocatedIncome > 0
                ? 'Unallocated Income: \$ ${_unallocatedIncome.abs()}'
                : 'Overallocated Income: \$ ${_unallocatedIncome.abs()}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _unallocatedIncome == 0 ? theme.income : theme.expense,
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
                categories: _incomeCategories,
                type: Types.income,
                sectionColour: theme.income,
              ),
              _buildCategorySection(
                title: 'Expenses',
                categories: _expenseCategories,
                type: Types.expense,
                sectionColour: theme.expense,
              ),
              _buildCategorySection(
                title: 'Savings',
                categories: _savingCategories,
                type: Types.saving,
                sectionColour: theme.savings,
              ),
              _buildCategorySection(
                title: 'Investments',
                categories: _investmentCategories,
                type: Types.investment,
                sectionColour: theme.investment,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
