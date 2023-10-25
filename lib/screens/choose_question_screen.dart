import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    '제일 잘생긴 사람 ',
    '제일 안 씻을 것 같은 사람',
    '첫인상과 지금이 가장 다른 사람',
    '성적 취향이 독특할 것 같은 사람',
    '가장 매력있는 사람',
    '거짓말을 가장 잘할 것 같은 사람',
    '연애를 가장 잘할 것 같은 사람',
    'SNS중독인 것 같은 사람',
    '내가 꼬실수 있을 것 같은 사람',
    '첫사랑을 못잊을 것 같은 사람',
    '가장 맘에 드는 사람',
    '단둘이 있으면 가장 어색한 사람',
    '친구 이상으로는 절대 생각할 수 없는 사람',
    '드라마에 감정이입을 많이 할 것 같은 사람',
    'X의 SNS를 들어가볼 것 같은 사람',
    '돈에 굉장히 인색할 것 같은 사람',
    '가장 꼰대 같은 사람',
    '옷을 환불할 때 같이 가고 싶은 사람',
    '생각없이 살 것 같은 사람',
    '군대 선임으로 만나면 큰일날 것 같은 사람',
    '결혼을 제일 빨리 할 것 같은 사람',
    '가장 눈치가 없어 보이는 사람',
    '가장 의리가 있을 것 같은 사람',
    '여기서 가장 짠돌이/짠순이'
  ];
  List<bool> checkQuestion = [];
  Map<String, String> questionAnswers = {};

  final TextEditingController answerController = TextEditingController();
  final TextEditingController newQuestionController = TextEditingController();
  final TextEditingController newAnswerController = TextEditingController();

  void showAnswerDialog(String question) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 5.0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(10, 10),
                  )
                ]),
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
        elevation: 5,
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
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                shrinkWrap: true,
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
          ),
          BottomAppBar(
            elevation: 5,
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
                    size: 23.0,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(42),
                          topRight: Radius.circular(42),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: SizedBox(
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'New Question',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Question',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 5),
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                            ),
                                            width: 350,
                                            child: TextField(
                                              controller: newQuestionController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Answer',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                spreadRadius: 3,
                                                blurRadius: 5,
                                                offset: const Offset(0, 5),
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                          width: 350,
                                          child: TextField(
                                            controller: newAnswerController,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          questionAnswers[newQuestionController
                                              .text] = newAnswerController.text;

                                          newQuestionController.clear();
                                          newAnswerController.clear();
                                          var knowAnswer =
                                              questionAnswers.values.first;
                                          print(knowAnswer);
                                          while (questionAnswers.length <
                                              (widget.selectedPeople * 3)) {
                                            questionAnswers[
                                                    '${questionAnswers.length + 1}'] =
                                                'Try Again';
                                          }
                                          goPage(SecretCardScreen(
                                              selectedPeople:
                                                  widget.selectedPeople,
                                              questionAnswers: questionAnswers,
                                              knowAnswer: knowAnswer));
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                          'Submit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.add, // 사용자 정의 아이콘으로 변경 가능
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
                    size: 23.0,
                  ),
                ),
                // You can add more buttons or customize the design here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
