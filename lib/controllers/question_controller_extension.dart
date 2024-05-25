import 'package:firebase_auth/firebase_auth.dart';
import 'package:textspeech/controllers/question_controller.dart';

import '../auth/controller/auth_controller.dart';
import '../firebase/references.dart';

extension QuestionsControllerExtension on QuestionController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get corrextAnsweredQuestion {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        (questionModel.timeSeconds - remainSeconds) /
        questionModel.timeSeconds *
        100;
    return points.toStringAsFixed(0);
  }

  // save point quiz test
  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    final userRF = fireStore.collection('Users');
    User? _user = AuthenticationRepository.instance.authUser;
    if (_user == null) return;
    batch.set(
        userRF.doc(_user.email).collection('quizz_test').doc(questionModel.id),
        {
          'points': points,
          'correct_answer': '$correctQuestionCount/${allQuestions.length}',
          'question_id': questionModel.id,
          'time': questionModel.timeSeconds - remainSeconds
        });
    batch.commit();
    navigateToHome();
  }
}
