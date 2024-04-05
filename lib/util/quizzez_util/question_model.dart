class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sampleData = [
  {
    "id": 1,
    "question": "1 + 1",
    "options": ['1', '3', '5', '2'],
    "answer_index": 3,
  },
  {
    "id": 2,
    "question": "4 + 2",
    "options": ['3', '6', '8', '9'],
    "answer_index": 1,
  },
  {
    "id": 3,
    "question": "2 + 5",
    "options": ['7', '8', '6', '9'],
    "answer_index": 0,
  },
  {
    "id": 4,
    "question": "1 + 4",
    "options": ['3', '5', '6', '7'],
    "answer_index": 1,
  },
];
