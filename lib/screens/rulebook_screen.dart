import 'package:flutter/material.dart';

class RuleBook extends StatelessWidget {
  const RuleBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rule Book',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              '이 게임은...',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            child: Text(
              '"Secret Card"는 아주 단순합니다.',
            ),
          ),
        ],
      ),
    );
  }
}
