import 'package:flutter/material.dart';

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investment Screen',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Center(child: const Text('Welcome to the Investment Screen!')),
      ),
    );
  }
}
