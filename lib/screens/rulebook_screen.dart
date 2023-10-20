import 'package:flutter/material.dart';

class RuleBook extends StatelessWidget {
  const RuleBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rule Book'),
      ),
      body: Center(
        child: Container(
          child: const Text('This is Rule book'),
        ),
      ),
    );
  }
}
