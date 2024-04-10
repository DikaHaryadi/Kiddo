class QuestionModel {
  String id;
  String title;
  String imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;

  QuestionModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.timeSeconds,
    this.questions,
  });

  QuestionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['Description'] as String,
        timeSeconds = json['time_seconds'],
        questions = (json['questions'] as List)
            .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList();
}

class Questions {
  String id;
  String question;
  List<Answers> answers;
  String correctAnswer;

  Questions({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });
  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answers = (json['answers'] as List)
            .map((answer) => Answers.fromJson(answer))
            .toList(),
        correctAnswer = json['correct_answer'];
}

class Answers {
  String? identifier;
  String? answer;

  Answers({
    this.identifier,
    this.answer,
  });

  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['answer'];
}
