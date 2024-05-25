import 'package:textspeech/controllers/question_controller.dart';

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
}
