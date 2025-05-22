import 'package:flutter/material.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/theme/app_theme.dart';
import 'package:ultimate_finance/widgets/period_selector.dart';

// Dummy categories
List<BudgetCategory> _allBudgetCategories = [
  BudgetCategory(name: 'Salary', type: Types.income),
  BudgetCategory(name: 'Freelance', type: Types.income),
  BudgetCategory(name: 'Rent', type: Types.expense),
  BudgetCategory(name: 'Groceries', type: Types.expense),
  BudgetCategory(name: 'Emergency Fund', type: Types.saving),
  BudgetCategory(name: 'Vacation Fund', type: Types.saving),
  BudgetCategory(name: 'Stocks', type: Types.investment),
  BudgetCategory(name: 'Crypto', type: Types.investment),
];

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late List<BudgetCategory> _incomeCategories;
  late List<BudgetCategory> _expenseCategories;
  late List<BudgetCategory> _savingCategories;
  late List<BudgetCategory> _investmentCategories;

  // Controller for Adding a new category
  final _formKey = GlobalKey<FormState>();
  String? _newCategoryName;

  @override
  void initState() {
    super.initState();
    _filterCategorioes();
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

  void _addCategory(Types type, String name) {
    setState(() {
      _allBudgetCategories.add(BudgetCategory(name: name, type: type));
      _filterCategorioes();
    });
  }

  Future<void> _showAddCategoryDialog(Types type) async {
    _newCategoryName = null;
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
                    _addCategory(type, _newCategoryName!);
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
        children: <Widget>[
          ...categories.map(
            (category) => ListTile(
              title: Text(category.name),
              onTap: () {
                // TODO: Navigate to category detail or edit
                print('Tapped on ${category.name}');
              },
              trailing: IconButton(
                icon: Icon(Icons.edit, size: 20, color: Colors.grey[600]),
                onPressed: () {
                  // TODO: Implement edit category
                },
              ),
            ),
          ),
          // "Add New Category" button for this section
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PeriodSelector(
            selectedPeriod: null,
            onPeriodChanged: (period) {},
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
