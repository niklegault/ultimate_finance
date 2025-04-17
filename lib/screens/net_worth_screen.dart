import 'package:flutter/material.dart';

class NetWorthScreen extends StatelessWidget {
  const NetWorthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Net Worth Screen',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Center(child: const Text('Welcome to the Net Worth Screen!')),
      ),
    );
  }
}
