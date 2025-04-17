import 'package:flutter/material.dart';

import 'account_screen.dart';
import 'budget_screen.dart';
import 'tracking_screen.dart';
import 'investment_screen.dart';
import 'net_worth_screen.dart';
import 'dashboard_screen.dart';

import '../widgets/navigation_bar.dart' as custom;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    TrackingScreen(),
    BudgetScreen(),
    InvestmentScreen(),
    NetWorthScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ultimate Finance',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Ultimate Finance')),
        body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
        bottomNavigationBar: custom.NavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
