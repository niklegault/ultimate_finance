import 'package:flutter/material.dart';
import 'package:ultimate_finance/models/budget_category.dart';
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
                      // if (_newCategoryName != null) {
                      //   var addedCategory = _addCategory(type, _newCategoryName!);
                      //   addedCategory.addPeriod(
                      //     _currentPeriod ?? DateTime.now(),
                      //     _budgetedAmount ?? 0.0,
                      //   );
                    }
                    Navigator.of(context).pop();
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
