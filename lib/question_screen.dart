import 'package:flutter/material.dart';
import 'package:flutter_secretcard/secretcard_screen.dart';

class QuestionScreen extends StatefulWidget {
  final int selectedPeople;
  const QuestionScreen({super.key, required this.selectedPeople});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<String> checkedQuestions = [];
  final List<String> questions = [
    '제일 안 씻을 것 같은 사람?',
    '제일 잘생긴 사람? ',
    '제일 귀여운 사람은? ',
  ];
  List<bool> checkQuestion = [];
  Map<String, String> questionAnswers = {};
  Map<String, String> extendquestionAnswers = {};
  final TextEditingController answerController = TextEditingController();

  void showAnswerDialog(String question) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(question),
              TextField(
                controller: answerController,
                decoration: const InputDecoration(labelText: 'Answer'),
              ),
              ElevatedButton(
                onPressed: () {
                  final answer = answerController.text;
                  questionAnswers[question] = answer;

                  answerController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Submit Answer'),
              ),
            ],
          ),
        );
      },
    );
  }

  void goPage(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  void initState() {
    super.initState();
    checkQuestion = List.filled(questions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Question Screen'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(questions[index]),
                    trailing: Checkbox(
                      value: checkQuestion[index],
                      onChanged: (value) {
                        setState(
                          () {
                            checkQuestion[index] = value!;
                            if (value) {
                              checkedQuestions.add(questions[index]);
                              showAnswerDialog(questions[index]);
                            } else {
                              checkedQuestions.remove(questions[index]);
                              questionAnswers.remove(questions[index]);
                            }
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            onPressed: () {
              while (questionAnswers.length < 12) {
                questionAnswers[
                        '${questionAnswers.length + 1} Do you want to know Answer?'] =
                    'Just one shot';
              }
              goPage(SecretCardScreen(
                  selectedPeople: widget.selectedPeople,
                  questionAnswers: questionAnswers));
            },
            child: const Text('next'),
          ),
        ));
  }
}
