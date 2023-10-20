import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secretcard/componant/custom_button.dart';
import 'package:flutter_secretcard/screens/secretcard_screen.dart';

class QuestionScreen extends StatefulWidget {
  final int selectedPeople;
  const QuestionScreen({super.key, required this.selectedPeople});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<String> checkedQuestions = [];
  final List<String> questions = [
    '제일 잘생긴 사람? ',
    '제일 안 씻을 것 같은 사람?',
    '첫인상과 지금이 가장 다른 사람은?',
    '가장 매력있는 사람은?',
    '연애를 가장 잘할 것 같은 사람은?',
    '가장 맘에 드는 사람은?',
    '단둘이 있으면 가장 어색한 사람은?',
    '친구 이상으로는 절대 생각할 수 없는 사람은?',
    'X의 SNS를 들어가볼 것 같은 사람은?',
    '돈에 굉장히 인색할 것 같은 사람은?',
    '가장 꼰대 같은 사람은?'
  ];
  List<bool> checkQuestion = [];
  Map<String, String> questionAnswers = {};

  final TextEditingController answerController = TextEditingController();

  void showAnswerDialog(String question) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  question,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 1,
                  controller: answerController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.red),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    labelText: 'Answer',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    final answer = answerController.text;
                    questionAnswers[question] = answer;

                    answerController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Submit Answer',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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

  @override
  void initState() {
    super.initState();
    checkQuestion = List.filled(questions.length, false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    answerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Choose Question',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
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
                return Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${index + 1}.',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(questions[index]),
                        trailing: Checkbox(
                          activeColor: Colors.black,
                          checkColor: Colors.red,
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
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Your code for the button action
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded, // 사용자 정의 아이콘으로 변경 가능
                    color: Colors.black,
                    size: 32.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    var knowAnswer = questionAnswers.values.first;
                    print(knowAnswer);
                    while (
                        questionAnswers.length < (widget.selectedPeople * 3)) {
                      questionAnswers['${questionAnswers.length + 1}'] =
                          'Try Again';
                    }
                    goPage(SecretCardScreen(
                        selectedPeople: widget.selectedPeople,
                        questionAnswers: questionAnswers,
                        knowAnswer: knowAnswer));
                    // Your code for the button action
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded, // 사용자 정의 아이콘으로 변경 가능
                    color: Colors.black,
                    size: 32.0,
                  ),
                ),
                // You can add more buttons or customize the design here
              ],
            ),
          )
        ],
      ),
    );
  }
}
