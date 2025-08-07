import 'package:flutter/material.dart';
import 'package:ultimate_finance/theme/app_theme.dart';
import 'package:ultimate_finance/widgets/period_selector.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime _currentPeriod = DateTime.now();

  void _handlePeriodChange(DateTime? newPeriod) {
    // Handle period change logic here
    setState(() {
      _currentPeriod = newPeriod ?? DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final financialTheme =
        Theme.of(context).extension<FinancialThemeExtension>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 48, bottom: 8),
          child: PeriodSelector(
            selectedPeriod: _currentPeriod,
            onPeriodChanged: _handlePeriodChange,
          ),
        ),
        const Center(child: Text('Welcome to the Dashboard Screen!')),
      ],
    );
  }
}
