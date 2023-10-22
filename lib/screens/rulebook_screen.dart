import 'package:flutter/material.dart';

class RuleBook extends StatelessWidget {
  const RuleBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rule Book',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          const Positioned(
            top: 20,
            left: 20,
            child: Text(
              'How...',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 120,
            left: 20,
            child: Row(
              children: [
                Text(
                  'Secret Card',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  '는 아주 단순합니다',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 170,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: const Text(
                '1. 함께 플레이를 할 사람 수를 선택합니다. ',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: const Text(
                '2. 질문자는 질문을 고르고 질문에 답을 할 사람을 고릅니다. ',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Positioned(
            top: 230,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: const Text(
                '3. 지목당한 사람은 질문에 대한 답을 같이 플레이를 하는 사람들 중에 한명의 이름을 적습니다.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: const Text(
                '4. 플레이어들은 돌아가면서 답이 적혀있는 카드를 뒤집습니다.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: const Text(
                '4. 플레이어들은 돌아가면서 답이 적혀있는 카드를 뒤집습니다.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Positioned(
            top: 330,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: const Text(
                '5. 모두에게는 2번의 기회가 있지만, 2번을 모두 소모할 시 게임은 끝이 납니다.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Positioned(
            top: 380,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: const Text(
                '6. 단, 너무나 비밀이 궁금하다면 Hidden Card 버튼을 통해 모두가 동의한 벌칙을 받고 비밀을 알 수 있습니다.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
