import 'package:flutter/material.dart';
import 'package:flutter_secretcard/screens/show_hiddencard_screen.dart';

class CheckHiddenCardScreen extends StatefulWidget {
  const CheckHiddenCardScreen({super.key});

  @override
  State<CheckHiddenCardScreen> createState() => _CheckHiddenCardScreenState();
}

class _CheckHiddenCardScreenState extends State<CheckHiddenCardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            bottom: 30,
            right: 30,
            child: Text(
              'Slide >',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              '비밀을 확인하고 싶나요?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
