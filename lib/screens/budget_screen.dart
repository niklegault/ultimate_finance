import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Screen',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Center(child: const Text('Welcome to the Budget Screen!')),
      ),
    );
  }
}
