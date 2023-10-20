import 'package:flutter/material.dart';
import 'package:flutter_secretcard/screens/choose_question_screen.dart';
import 'package:flutter_secretcard/screens/rulebook_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../componant/custom_button.dart';

class ChoosePeopleScreen extends StatefulWidget {
  const ChoosePeopleScreen({super.key});

  @override
  State<ChoosePeopleScreen> createState() => _ChoosePeopleScreenState();
}

class _ChoosePeopleScreenState extends State<ChoosePeopleScreen>
    with SingleTickerProviderStateMixin {
  int selectedPeople = 2;
  late AnimationController _controller = AnimationController(vsync: this);
  late Animation<double> _animation;

  void increaseNumber() {
    if (selectedPeople < 6) {
      setState(() {
        selectedPeople++;
        _controller.forward();
      });
    }
  }

  void decreaseNumber() {
    if (selectedPeople > 2) {
      setState(() {
        selectedPeople--;
        _controller.forward();
      });
    }
  }

  void goPage(Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // 시작 위치 (오른쪽에서 왼쪽으로)
          const end = Offset.zero; // 끝 위치 (화면 중앙)
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
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
  void initState() {
    // TODO: implement initState
    super.initState();
    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Listen to animation status
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SafeArea(
      child: Stack(
        children: [
          const Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Secret Card',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + 0.1 * _animation.value,
                  child: const Text(
                    'Choose People',
                    style: TextStyle(fontSize: 30),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 130,
            right: 40,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                        scale: 1 + 0.2 * _animation.value,
                        child: Text(
                          '$selectedPeople',
                          style: const TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ));
                  },
                ),
                const Text(
                  'min2 max6',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Positioned(
            right: 30,
            bottom: 40,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + 0.2 * _animation.value,
                  child: CustomButton(
                    controller: _controller,
                    text: 'Next',
                    onPressed: () {
                      goPage(QuestionScreen(selectedPeople: selectedPeople));
                    },
                    buttonColor: Colors.black, // 버튼 색상 변경
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 30,
            bottom: 40,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + 0.2 * _animation.value,
                  child: CustomButton(
                    controller: _controller,
                    text: 'Rule',
                    onPressed: () {
                      Navigator.of(context).push(_createRoute());
                    },
                    buttonColor: Colors.black, // 버튼 색상 변경
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 320,
            right: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: decreaseNumber,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const FaIcon(Icons.remove),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: increaseNumber,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const FaIcon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
