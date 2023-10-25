import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secretcard/screens/show_hiddencard_screen.dart';

import '../componant/custom_button.dart';
import 'check_hiddencard_screen.dart';

class SecretCardScreen extends StatefulWidget {
  final String knowAnswer;
  final int selectedPeople;
  final Map<String, String> questionAnswers;

  const SecretCardScreen({
    Key? key,
    required this.selectedPeople,
    required this.questionAnswers,
    required this.knowAnswer,
  }) : super(key: key);

  @override
  _SecretCardScreenState createState() => _SecretCardScreenState();
}

class _SecretCardScreenState extends State<SecretCardScreen>
    with SingleTickerProviderStateMixin {
  List<MapEntry<String, String>> questionAnswerPairs = [];
  int flipCount = 1;
  List<bool> isCardFlipped = [];
  int selectedCardIndex = -1;
  late AnimationController _controller = AnimationController(vsync: this);
  late Animation<double> _animation;
  late PageController _pageController;

  List<Color> cardColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.pinkAccent,
    Colors.blue,
    Colors.green,
    Colors.indigo,
    Colors.purple,
    Colors.black,
  ];

  @override
  void initState() {
    super.initState();

    questionAnswerPairs = widget.questionAnswers.entries.toList()..shuffle();
    isCardFlipped = List.filled(questionAnswerPairs.length, false);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _pageController = PageController(
      initialPage: 0,
    )..addListener(() {
        setState(() {});
      });
  }

  void flipCard(int index) {
    if (!isCardFlipped[index]) {
      if (flipCount <= (widget.selectedPeople - 1) * 2) {
        setState(() {
          isCardFlipped[index] = true;
          flipCount++;
          print(flipCount);
          print(widget.questionAnswers[questionAnswerPairs[index].key]);

          if (widget.questionAnswers[questionAnswerPairs[index].key] ==
              widget.knowAnswer) {
            // User found the answer within the allowed flips
            selectedCardIndex = index;
            // Show a "Congratulations" message
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('아무에게도 말하지 마세요!!'),
                  content: Text('질문의 답 : ${widget.knowAnswer}'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('게임 다시하기'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                    ),
                  ],
                );
              },
            );
          }
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Game Over',
                textAlign: TextAlign.center,
              ),
              content: const Text('당신은 비밀을 알아내지 못했습니다.'),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: const Text(
                      textAlign: TextAlign.center,
                      '게임 다시하기',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        //automaticallyImplyLeading: false, 뒤로가기 불가능!
        title: Text(
          widget.questionAnswers.keys.toList()[0],
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: questionAnswerPairs.length,
              itemBuilder: (context, index) {
                //final question = questionAnswerPairs[index].key;
                final answer = questionAnswerPairs[index].value;
                Color cardColor = cardColors[index % cardColors.length];

                return GestureDetector(
                  onTap: () => flipCard(index),
                  child: Card(
                    color: cardColor,
                    child: Center(
                      child: isCardFlipped[index]
                          ? Text(
                              answer,
                              textAlign: TextAlign.center,
                            )
                          : const Text(
                              'Tap to reveal',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomButton(
            controller: _controller,
            text: 'Hidden Card',
            onPressed: () {
              showModalBottomSheet(
                barrierColor: Colors.black,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(42),
                    topRight: Radius.circular(42),
                  ),
                ),
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 200,
                    child: PageView(
                      pageSnapping: true,
                      controller: _pageController,
                      children: [
                        const Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(42),
                                topRight: Radius.circular(42),
                              ),
                            ),
                            child: CheckHiddenCardScreen()),
                        Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(42),
                              topRight: Radius.circular(42),
                            ),
                          ),
                          child: ShowHiddenCardScreen(
                            knowAnswer: widget.knowAnswer,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            buttonColor: Colors.black,
          );
        },
      )),
    );
  }
}
