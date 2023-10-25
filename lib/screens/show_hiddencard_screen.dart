import 'package:flutter/material.dart';

class ShowHiddenCardScreen extends StatelessWidget {
  final String knowAnswer;
  const ShowHiddenCardScreen({super.key, required this.knowAnswer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Positioned(
            bottom: 30,
            right: 30,
            child: Text(
              knowAnswer,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: TextButton(
              child: const Text(
                'Play Again',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          )
        ],
      ),
    );
  }
}
