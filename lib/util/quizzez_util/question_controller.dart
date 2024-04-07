import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/quizzez_util/question_model.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  late int _totalQuestions;

  int _currentQuestionNumber = 0;
  RxInt get currentQuestionNumber => _currentQuestionNumber.obs;
  List<Question> get currentQuestionSet =>
      _questionSets[_questionNumber.value - 1];

  final List<List<Question>> _questionSets = [
    sampleData1
        .map((question) => Question(
              id: question['id'] as int,
              question: question['question'] as String,
              options: (question['options'] as List).cast<String>(),
              answer: question['answer_index'] as int,
            ))
        .toList(),
    sampleData2
        .map((question) => Question(
              id: question['id'] as int,
              question: question['question'] as String,
              options: (question['options'] as List).cast<String>(),
              answer: question['answer_index'] as int,
            ))
        .toList(),
    sampleData3
        .map((question) => Question(
              id: question['id'] as int,
              question: question['question'] as String,
              options: (question['options'] as List).cast<String>(),
              answer: question['answer_index'] as int,
            ))
        .toList(),
    sampleData4
        .map((question) => Question(
              id: question['id'] as int,
              question: question['question'] as String,
              options: (question['options'] as List).cast<String>(),
              answer: question['answer_index'] as int,
            ))
        .toList(),
    sampleData5
        .map((question) => Question(
              id: question['id'] as int,
              question: question['question'] as String,
              options: (question['options'] as List).cast<String>(),
              answer: question['answer_index'] as int,
            ))
        .toList(),
    // Tambahkan sampleData2, sampleData3, dst. sesuai kebutuhan
  ];

  List<List<Question>> get questionSets => _questionSets;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late int _correctAns;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  void init(int totalQuestions) {
    _totalQuestions = totalQuestions;
  }

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    _animationController.stop();
    update();

    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    int nextQuestionNumber = _questionNumber.value + 1;
    print('asdad1');
    if (nextQuestionNumber <= _totalQuestions) {
      print('asdad2');
      _isAnswered = false;
      print('asdad3');
      updateTheQnNum(nextQuestionNumber);
      print('asdad4');
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
      print('asdad5');
      _animationController.reset();
      print('asdad6');
      _animationController.forward().catchError((error) {
        print('Error in animation forward: $error');
      });
    } else {
      print('asdad10');
      Get.toNamed('/score');
      print('asdad11');
    }
  }

  void updateTheQnNum(int questionNumber) {
    _currentQuestionNumber = questionNumber;
    update();
  }
}
