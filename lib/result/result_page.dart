import 'package:DevQuiz/challenge/widgets/next_button/nextbutton_widget.dart';
import 'package:DevQuiz/core/app_images.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ResultPageWidget extends StatelessWidget {
  final String title;
  final int length;
  final int result;

  const ResultPageWidget(
      {Key? key,
      required this.title,
      required this.length,
      required this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.trophy),
            SizedBox(height: 40),
            Text(
              'Parabéns!',
              style: AppTextStyles.heading40,
            ),
            SizedBox(
              height: 16,
            ),
            Text.rich(
              TextSpan(
                  text: "Você concluiu",
                  style: AppTextStyles.body,
                  children: [
                    TextSpan(text: "\n$title", style: AppTextStyles.bodyBold),
                    TextSpan(
                      text: "\ncom $result de $length acertos.",
                      style: AppTextStyles.body,
                    )
                  ]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 75),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 68),
                  child: NextButtonWidget.purple(
                      label: 'Compartilhar',
                      onTap: () {
                        Share.share(
                            'Compartilhar meu resultado: quiz $title finalizado! Obtive ${(result / length) * 100}% de aproveitamento!');
                      }),
                )),
              ],
            ),
            SizedBox(height: 20),
            NextButtonWidget.transparent(
                label: 'Voltar ao início',
                onTap: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
