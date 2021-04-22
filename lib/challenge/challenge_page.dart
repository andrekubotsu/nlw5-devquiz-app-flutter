import 'package:DevQuiz/challenge/widgets/question_indicator/question_indicator.dart';
import 'package:DevQuiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:flutter/material.dart';

class ChallengePageWidget extends StatefulWidget {
  @override
  _ChallengePageWidgetState createState() => _ChallengePageWidgetState();
}

class _ChallengePageWidgetState extends State<ChallengePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SafeArea(child: QuestionIndicatorWidget()),
      ),
      body: QuizWidget(title: "O que o flutter faz em sua totalidade?"),
    );
  }
}
