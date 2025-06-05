import 'package:flutter/material.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/theme/app_theme.dart';
import 'package:ultimate_finance/widgets/information_box.dart';

List<BudgetCategory> _allBudgetCategories = [];

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

  Widget _buildTrackedItem() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("Tracked Item"),
            const Divider(height: 1.0),
            Text("Details about the tracked item go here."),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddItemDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: SingleChildScrollView(
            child: Form(
              //key: _formKey,
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
                      //_newCategoryName = value;
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
                      //_budgetedAmount = double.tryParse(value!);
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
                // if (_formKey.currentState!.validate()) {
                //   _formKey.currentState!.save();
                //   if (_newCategoryName != null) {
                //     var addedCategory = _addCategory(type, _newCategoryName!);
                //     addedCategory.addPeriod(
                //       _currentPeriod ?? DateTime.now(),
                //       _budgetedAmount ?? 0.0,
                //     );
                //   }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrackedList() {
    return Column(
      children: [
        _buildTrackedItem(),
        _buildTrackedItem(),
        _buildTrackedItem(),
        _buildTrackedItem(),
        _buildTrackedItem(),
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
