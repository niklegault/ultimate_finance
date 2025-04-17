import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Screen',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Center(child: const Text('Welcome to the Dashboard Screen!')),
      ),
    );
  }
}
