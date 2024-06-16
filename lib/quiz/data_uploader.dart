import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:textspeech/firebase/loading_status.dart';
import 'package:textspeech/firebase/references.dart';
import 'package:textspeech/quiz/question_model.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;
  void uploadData() async {
    loadingStatus.value = LoadingStatus.loading;

    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await rootBundle.loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // load json file and print path
    final papersInAssets = manifestMap.keys
        .where(
            (path) => path.startsWith("assets/json") && path.contains(".json"))
        .toList();
    List<QuestionModel> questionModel = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionModel.add(QuestionModel.fromJson(jsonDecode(stringPaperContent)));
    }
    var batch = fireStore.batch();

    for (var paper in questionModel) {
      batch.set(questionPaperRF.doc(paper.id), {
        'title': paper.title,
        'image_url': paper.imageUrl,
        'description': paper.description,
        'time_seconds': paper.timeSeconds,
        'questions_count': paper.questions == null ? 0 : paper.questions!.length
      });

      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id, questionId: questions.id);
        batch.set(questionPath, {
          'question': questions.question,
          'correct_answer': questions.correctAnswer
        });

        for (var answer in questions.answers) {
          batch.set(questionPath.collection('answers').doc(answer.identifier),
              {'identifier': answer.identifier, 'answer': answer.answer});
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
