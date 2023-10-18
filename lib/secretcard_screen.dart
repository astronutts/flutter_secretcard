import 'package:flutter/material.dart';

class SecretCardScreen extends StatefulWidget {
  final int selectedPeople;
  final Map<String, String> questionAnswers;

  const SecretCardScreen({
    Key? key,
    required this.selectedPeople,
    required this.questionAnswers,
  }) : super(key: key);

  @override
  _SecretCardScreenState createState() => _SecretCardScreenState();
}

class _SecretCardScreenState extends State<SecretCardScreen> {
  List<MapEntry<String, String>> questionAnswerPairs = [];

  List<bool> isCardFlipped = [];
  int selectedCardIndex = -1;

  @override
  void initState() {
    super.initState();

    questionAnswerPairs = widget.questionAnswers.entries.toList()..shuffle();
    isCardFlipped = List.filled(questionAnswerPairs.length, false);
  }

  void flipCard(int index) {
    setState(() {
      isCardFlipped[index] = !isCardFlipped[index];

      if (isCardFlipped[index]) {
        // Check if the selected card's answer matches the question's answer
        if (widget.questionAnswers[questionAnswerPairs[index].value] ==
            questionAnswerPairs[index].value) {
          // Set the selected card index to trigger animation
          selectedCardIndex = index;
        }
      } else {
        selectedCardIndex = -1; // Reset selected card index
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.questionAnswers.keys.toList()[0]),
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
                final question = questionAnswerPairs[index].key;
                final answer = questionAnswerPairs[index].value;

                return GestureDetector(
                  onTap: () => flipCard(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    color:
                        selectedCardIndex == index ? Colors.red : Colors.white,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
