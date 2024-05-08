import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/firebase/loading_status.dart';
import 'package:textspeech/quiz/data_uploader.dart';
import 'package:textspeech/quiz/question_paper_controller.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionPaperController());
    DataUploader dataUploader = Get.put(DataUploader());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final paper = controller.allPapers[index];
                  return ClipRRect(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CachedNetworkImage(
                        imageUrl: paper.imageUrl,
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/Logo_color1.png'),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemCount: controller.allPapers.length,
              ),
            ),
            Obx(() => Text(
                dataUploader.loadingStatus.value == LoadingStatus.completed
                    ? 'uploaded completed'
                    : 'uploaded'))
          ],
        ),
      ),
    );
  }
}
