import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:textspeech/firebase/loading_status.dart';
import 'package:textspeech/firebase/references.dart';
import 'package:textspeech/quiz/question_model.dart';

class QuestionController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionModel questionModel;
  final allQuestions = <Questions>[];
  // next or previous question
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  // last question
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;
  // current question
  Rxn<Questions> currentQuestion = Rxn<Questions>();

  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionModel;
    print('Ini question controller ${_questionPaper.title}');
    loadData(_questionPaper);
    super.onReady();
  }

  void loadData(QuestionModel questionPaper) async {
    questionModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection('questions')
              .get();

      final questions = questionQuery.docs
          .map((snapShot) => Questions.fromSnapshot(snapShot))
          .toList();

      questionPaper.questions = questions;

      for (Questions _question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection('questions')
                .doc(_question.id)
                .collection('answers')
                .get();

        final answers = answersQuery.docs
            .map((answer) => Answers.fromSnapShot(answer))
            .toList();

        _question.answers = answers;
        if (questionPaper.questions != null &&
            questionPaper.questions!.isNotEmpty) {
          allQuestions.assignAll(questionPaper.questions!);
          currentQuestion.value = questionPaper.questions![0];
          print(questionPaper.questions![0].question);
          loadingStatus.value = LoadingStatus.completed;
        } else {
          loadingStatus.value = LoadingStatus.error;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // selected answere
  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list']);
  }

  // nextQuestion func
  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  // prevQuestion func
  void prevQuestion() {
    if (questionIndex.value <= 0) return;
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }
}
