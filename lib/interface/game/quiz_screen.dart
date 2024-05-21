import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/quiz/question_paper_controller.dart';
import 'package:textspeech/quiz/quiz_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionPaperController());
    // DataUploader dataUploader = Get.put(DataUploader());

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return QuestionCard(model: controller.allPapers[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20);
            },
            itemCount: controller.allPapers.length,
          ),
        ),
      ),
    );
  }
}
