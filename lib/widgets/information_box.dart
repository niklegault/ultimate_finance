import 'package:flutter/material.dart';

class InformationBox extends StatelessWidget {
  final String label;
  final String content;

  const InformationBox({super.key, required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [Text(label), const Divider(height: 1.0), Text(content)],
          ),
        ),
      ),
    );
  }
}
