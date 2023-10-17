import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String question;
  final String answer;

  const CardWidget({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(question),
          Text(answer),
        ],
      ),
    );
  }
}
