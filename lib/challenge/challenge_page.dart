import 'package:DevQuiz/challenge/challenge_controller.dart';
import 'package:DevQuiz/challenge/widgets/next_button/nextbutton_widget.dart';
import 'package:DevQuiz/challenge/widgets/question_indicator/question_indicator.dart';
import 'package:DevQuiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:DevQuiz/result/result_page.dart';
import 'package:DevQuiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class ChallengePageWidget extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  ChallengePageWidget({
    Key? key,
    required this.questions,
    required this.title,
  }) : super(key: key);

  @override
  _ChallengePageWidgetState createState() => _ChallengePageWidgetState();
}

class _ChallengePageWidgetState extends State<ChallengePageWidget> {
  final controller = ChallengeController();
  final pageController = PageController(); //nativo

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });

    super.initState();
  }

  void nextPage() {
    if (controller.currentPage < widget.questions.length)
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
  }

  void onSelected(bool value) {
    if (value) {
      controller.rightAnswers++;
    }
    nextPage();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(112),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
            ValueListenableBuilder<int>(
              valueListenable: controller.currentPageNotifier,
              builder: (context, value, _) => QuestionIndicatorWidget(
                currentPage: value,
                length: widget.questions.length,
              ),
            ),
          ],
        )),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map(
              (e) => QuizWidget(
                question: e,
                onSelected: onSelected,
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifier,
            builder: (context, value, _) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (value < widget.questions.length)
                    Expanded(
                        child: NextButtonWidget.white(
                      label: "Pular",
                      onTap: nextPage,
                    )),
                  if (value == widget.questions.length)
                    Expanded(
                        child: NextButtonWidget.green(
                      label: "Confirmar",
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPageWidget(
                                title: widget.title,
                                length: widget.questions.length,
                                result: controller.rightAnswers,
                              ),
                            ));
                      },
                    )),
                ]),
          ),
        ),
      ),
    );
  }
}
