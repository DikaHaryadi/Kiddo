import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:textspeech/quiz/question_paper_controller.dart';
import 'package:textspeech/quiz/result_screen.dart';
import 'package:textspeech/firebase/loading_status.dart';
import 'package:textspeech/firebase/references.dart';
import 'package:textspeech/quiz/question_model.dart';
import 'package:textspeech/util/widgets/dialog_widget.dart';

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
  // timer
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionModel;
    print('...onReady...');
    loadData(_questionPaper);
    super.onReady();
  }

  void loadData(QuestionModel questionPaper) async {
    questionModel = questionPaper; // Ensure questionModel is set
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
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds);
      print('...startTimer...');
      print(questionPaper.questions![0].question);
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  // selected answer
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

  // start timer
  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      remainSeconds--; // Decrement remainSeconds first
      if (remainSeconds <= 0) {
        // Then check if remainSeconds is less than or equal to 0
        timer.cancel();
        Get.dialog(
          Dialogs.timesUpDialogue(onTap: tryAgain),
          barrierDismissible: false,
        );
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      }
    });
  }

  // Reset all selected answers
  void resetSelectedAnswers() {
    for (var question in allQuestions) {
      question.selectedAnswer = null;
    }
  }

  // complete test and check the all question was selected and not selected
  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return '$answered out of ${allQuestions.length} answered';
  }

  // jump into question not answered
  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (isGoBack) {
      Get.back();
    }
  }

  // when quiz completed
  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultQuizScreen.routeName);
  }

  // try again
  void tryAgain() {
    // Reset selected answers
    resetSelectedAnswers();
    _timer?.cancel();

    // Close the dialog
    Get.back();

    // Handle navigation or reloading questions
    if (Get.arguments != null && Get.arguments is QuestionModel) {
      final _questionPaper = Get.arguments as QuestionModel;
      loadData(_questionPaper);
    } else {
      // Handle the case where Get.arguments is null or not of expected type
      print('Error: Invalid or null QuestionModel argument');
    }
  }

  // navigate to Home after finished the test
  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil('/home', (route) => false);
  }
}
