import 'package:flutter/material.dart';
import 'package:flutter_secretcard/question_screen.dart';
import 'package:flutter_secretcard/rule_book.dart';

class ChoosePeopleScreen extends StatefulWidget {
  const ChoosePeopleScreen({super.key});

  @override
  State<ChoosePeopleScreen> createState() => _ChoosePeopleScreenState();
}

class _ChoosePeopleScreenState extends State<ChoosePeopleScreen> {
  int selectedPeople = 2;

  void increaseNumber() {
    if (selectedPeople < 6) {
      setState(() {
        selectedPeople++;
      });
    }
  }

  void decreaseNumber() {
    if (selectedPeople > 2) {
      setState(() {
        selectedPeople--;
      });
    }
  }

  void goPage(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const RuleBook(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Secret Card',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Choose People',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 30),
              Text(
                '$selectedPeople',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: decreaseNumber,
                    child: const Text('감소'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: increaseNumber,
                    child: const Text('증가'),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  goPage(QuestionScreen(selectedPeople: selectedPeople));
                },
                child: const Text('next'),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    _createRoute(),
                  );
                },
                child: const Text(
                  'rule',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
