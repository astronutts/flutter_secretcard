import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secretcard/card_data.dart';

class SecretCardScreen extends StatefulWidget {
  final int selectedPeople;
  final Map<String, String> questionAnswers;
  const SecretCardScreen(
      {super.key, required this.selectedPeople, required this.questionAnswers});

  @override
  State<SecretCardScreen> createState() => _SecretCardScreenState();
}

class _SecretCardScreenState extends State<SecretCardScreen> {
  Map<String, String> questionAnswers = {};
  List<MapEntry<String, String>> questionAnswerPairs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    questionAnswerPairs = widget.questionAnswers.entries.toList();
    questionAnswerPairs.shuffle();
    print(questionAnswerPairs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secret Card Screen'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // 각 그리드 항목의 최대 너비
              mainAxisSpacing: 10, // 주축 (수평 방향) 간격
              crossAxisSpacing: 10, // 교차축 (수직 방향) 간격
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final question = questionAnswerPairs[index].key;
                final answer = questionAnswerPairs[index].value;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Question:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(question),
                        const SizedBox(height: 10),
                        const Text(
                          'Answer:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(answer),
                      ],
                    ),
                  ),
                );
              },
              childCount: questionAnswerPairs.length,
            ),
          ),
        ],
      ),
    );
  }
}
