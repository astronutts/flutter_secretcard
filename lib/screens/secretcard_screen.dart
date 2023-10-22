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
                  title: const Text('Don\'t tell anyone else'),
                  content: Text('You found a secret : ${widget.knowAnswer}'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Play Again'),
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
              title: const Text('Game Over'),
              content: const Text(
                  'You did not find the answer within the allowed flips.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Play Again'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
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

                return GestureDetector(
                  onTap: () => flipCard(index),
                  child: Card(
                    child: Center(
                      child: isCardFlipped[index]
                          ? Text(
                              answer,
                              textAlign: TextAlign.center,
                            )
                          : const Text(
                              'Tap to reveal',
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
