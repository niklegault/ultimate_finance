import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String _displayMonthYear(DateTime? date) {
  if (date == null) {
    return 'Current Month';
  }
  return DateFormat('MMMM yyyy').format(date);
}

class PeriodSelector extends StatelessWidget {
  final DateTime? selectedPeriod;
  final ValueChanged<DateTime?> onPeriodChanged;

  const PeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  void _previousMonth() {
    DateTime newPeriod;
    if (selectedPeriod == null) {
      final now = DateTime.now();
      newPeriod = DateTime(now.year, now.month - 1);
    } else {
      newPeriod = DateTime(selectedPeriod!.year, selectedPeriod!.month - 1);
    }
    onPeriodChanged(newPeriod);
  }

  void _nextMonth() {
    DateTime newPeriod;
    if (selectedPeriod == null) {
      final now = DateTime.now();
      newPeriod = DateTime(now.year, now.month + 1);
    } else {
      newPeriod = DateTime(selectedPeriod!.year, selectedPeriod!.month + 1);
    }
    onPeriodChanged(newPeriod);
  }

  Future<void> _selectPeriod(BuildContext context) async {
    final DateTime initialDate = selectedPeriod ?? DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(initialDate.year, initialDate.month, 1),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'SELECT MONTH & YEAR',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final selectedMonthYear = DateTime(pickedDate.year, pickedDate.month, 1);
      final now = DateTime.now();
      if (selectedMonthYear.year == now.year &&
          selectedMonthYear.month == now.month) {
        onPeriodChanged(null);
      } else {
        onPeriodChanged(selectedMonthYear);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayPeriod = _displayMonthYear(selectedPeriod);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _previousMonth,
        ),
        TextButton(
          onPressed: () => _selectPeriod(context),
          child: Text(
            _displayMonthYear(selectedPeriod),
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: _nextMonth,
        ),
      ],
    );
  }
}
