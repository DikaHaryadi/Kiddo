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

const List sampleData1 = [
  {
    "id": 1,
    "question": "Berapa hasil dari 2 ditambah 3?",
    "options": ["4", "5", "6", "7"],
    "answer_index": 1
  },
  {
    "id": 2,
    "question": "Hitunglah 4 ditambah 6!",
    "options": ["8", "9", "10", "11"],
    "answer_index": 2
  },
  {
    "id": 3,
    "question": "Jumlahkan 5 dengan 7!",
    "options": ["10", "11", "12", "13"],
    "answer_index": 2
  },
  {
    "id": 4,
    "question": "Tambahkan 3 dengan 9!",
    "options": ["10", "11", "12", "13"],
    "answer_index": 2
  },
  {
    "id": 5,
    "question": "Berapa hasil dari 6 tambah 4?",
    "options": ["9", "10", "11", "12"],
    "answer_index": 1
  },
  {
    "id": 6,
    "question": "Tambahkan 7 dengan 8!",
    "options": ["13", "14", "15", "16"],
    "answer_index": 2
  },
  {
    "id": 7,
    "question": "Hitunglah 8 ditambah 9!",
    "options": ["16", "17", "18", "19"],
    "answer_index": 1
  },
  {
    "id": 8,
    "question": "6 + 5",
    "options": ['11', '12', '13', '14'],
    "answer_index": 0,
  },
  {
    "id": 9,
    "question": "4 + 8",
    "options": ['12', '13', '14', '15'],
    "answer_index": 0,
  },
  {
    "id": 10,
    "question": "9 + 2",
    "options": ['11', '12', '13', '14'],
    "answer_index": 0,
  },
  {
    "id": 11,
    "question": "10 + 3",
    "options": ['13', '14', '15', '16'],
    "answer_index": 0,
  },
  {
    "id": 12,
    "question": "11 + 5",
    "options": ['16', '17', '18', '19'],
    "answer_index": 0,
  }
];

const List sampleData2 = [
  {
    "id": 1,
    "question": "Berapa hasil dari 1 ditambah 2?",
    "options": ["2", "3", "4", "5"],
    "answer_index": 1
  },
  {
    "id": 2,
    "question": "Hitunglah 3 ditambah 4!",
    "options": ["6", "7", "8", "9"],
    "answer_index": 1
  },
  {
    "id": 3,
    "question": "Jumlahkan 5 dengan 6!",
    "options": ["10", "11", "12", "13"],
    "answer_index": 1
  },
  {
    "id": 4,
    "question": "Tambahkan 7 dengan 8!",
    "options": ["14", "15", "16", "17"],
    "answer_index": 0
  },
  {
    "id": 5,
    "question": "Berapa hasil dari 9 tambah 10?",
    "options": ["18", "19", "20", "21"],
    "answer_index": 1
  },
  {
    "id": 6,
    "question": "Tambahkan 11 dengan 12!",
    "options": ["23", "24", "25", "26"],
    "answer_index": 0
  },
  {
    "id": 7,
    "question": "Hitunglah 13 ditambah 14!",
    "options": ["26", "27", "28", "29"],
    "answer_index": 1
  },
  {
    "id": 8,
    "question": "15 + 16",
    "options": ['30', '31', '32', '33'],
    "answer_index": 1,
  },
  {
    "id": 9,
    "question": "17 + 18",
    "options": ['35', '36', '37', '38'],
    "answer_index": 0,
  },
  {
    "id": 10,
    "question": "19 + 20",
    "options": ['41', '40', '39', '42'],
    "answer_index": 2,
  },
  {
    "id": 11,
    "question": "21 + 22",
    "options": ['43', '44', '45', '46'],
    "answer_index": 0,
  },
  {
    "id": 12,
    "question": "23 + 24",
    "options": ['46', '49', '48', '47'],
    "answer_index": 3,
  }
];

const List sampleData3 = [
  {
    "id": 1,
    "question": "Berapa hasil dari 3 ditambah 5?",
    "options": ["7", "8", "9", "10"],
    "answer_index": 0
  },
  {
    "id": 2,
    "question": "Jumlahkan 2 dengan 4!",
    "options": ["6", "7", "5", "8"],
    "answer_index": 0
  },
  {
    "id": 3,
    "question": "Hitunglah 6 ditambah 7!",
    "options": ["12", "13", "14", "15"],
    "answer_index": 1
  },
  {
    "id": 4,
    "question": "Tambahkan 1 dengan 9!",
    "options": ["10", "11", "12", "13"],
    "answer_index": 0
  },
  {
    "id": 5,
    "question": "Berapa hasil dari 4 tambah 3?",
    "options": ["6", "7", "8", "9"],
    "answer_index": 1
  },
  {
    "id": 6,
    "question": "Tambahkan 5 dengan 6!",
    "options": ["10", "11", "12", "13"],
    "answer_index": 2
  },
  {
    "id": 7,
    "question": "Hitunglah 7 ditambah 8!",
    "options": ["15", "16", "17", "18"],
    "answer_index": 1
  },
  {
    "id": 8,
    "question": "7 + 5",
    "options": ['12', '13', '14', '15'],
    "answer_index": 3,
  },
  {
    "id": 9,
    "question": "8 + 4",
    "options": ['12', '13', '14', '15'],
    "answer_index": 2,
  },
  {
    "id": 10,
    "question": "3 + 9",
    "options": ['11', '12', '13', '14'],
    "answer_index": 1,
  }
];

const List sampleData4 = [
  {
    "id": 1,
    "question": "Berapa hasil dari 5 ditambah 7?",
    "options": ["10", "11", "12", "13"],
    "answer_index": 2
  },
  {
    "id": 2,
    "question": "Jumlahkan 4 dengan 3!",
    "options": ["6", "7", "5", "8"],
    "answer_index": 1
  },
  {
    "id": 3,
    "question": "Hitunglah 8 tambah 6!",
    "options": ["12", "14", "15", "16"],
    "answer_index": 2
  },
  {
    "id": 4,
    "question": "Tambahkan 2 dengan 9!",
    "options": ["11", "12", "13", "14"],
    "answer_index": 0
  },
  {
    "id": 5,
    "question": "Berapa hasil dari 3 tambah 4?",
    "options": ["6", "7", "8", "9"],
    "answer_index": 1
  },
  {
    "id": 6,
    "question": "Tambahkan 1 dengan 8!",
    "options": ["8", "9", "10", "11"],
    "answer_index": 1
  },
  {
    "id": 7,
    "question": "Hitunglah 5 ditambah 5!",
    "options": ["9", "15", "11", "10"],
    "answer_index": 3
  },
  {
    "id": 8,
    "question": "10 + 4",
    "options": ['12', '13', '15', '11'],
    "answer_index": 2,
  },
  {
    "id": 9,
    "question": "13 + 2",
    "options": ['14', '15', '16', '17'],
    "answer_index": 1,
  },
  {
    "id": 10,
    "question": "5 + 10",
    "options": ['15', '16', '14', '13'],
    "answer_index": 0,
  },
  {
    "id": 11,
    "question": "11 + 3",
    "options": ['15', '12', '13', '14'],
    "answer_index": 3,
  },
  {
    "id": 12,
    "question": "14 + 8",
    "options": ['21', '20', '22', '23'],
    "answer_index": 2,
  },
  {
    "id": 13,
    "question": "9 + 6",
    "options": ['15', '14', '13', '16'],
    "answer_index": 0,
  },
  {
    "id": 14,
    "question": "7 + 4",
    "options": ['11', '10', '12', '13'],
    "answer_index": 0,
  },
  {
    "id": 15,
    "question": "12 + 6",
    "options": ['19', '16', '17', '18'],
    "answer_index": 3,
  },
];

const List sampleData5 = [
  {
    "id": 1,
    "question": "11 + 6",
    "options": ['17', '16', '15', '18'],
    "answer_index": 0,
  },
  {
    "id": 2,
    "question": "8 + 9",
    "options": ['15', '16', '17', '18'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "16 + 8",
    "options": ['26', '23', '25', '24'],
    "answer_index": 3,
  },
  {
    "id": 4,
    "question": "7 + 12",
    "options": ['18', '19', '20', '17'],
    "answer_index": 1,
  },
  {
    "id": 5,
    "question": "10 + 5",
    "options": ['19', '14', '13', '15'],
    "answer_index": 3,
  },
  {
    "id": 6,
    "question": "5 + 8",
    "options": ['11', '12', '13', '14'],
    "answer_index": 2,
  },
  {
    "id": 7,
    "question": "7 + 9",
    "options": ['12', '16', '14', '17'],
    "answer_index": 1,
  },
  {
    "id": 8,
    "question": "11 + 3",
    "options": ['10', '12', '14', '15'],
    "answer_index": 2,
  },
  {
    "id": 9,
    "question": "8 + 4",
    "options": ['12', '11', '10', '13'],
    "answer_index": 0,
  },
  {
    "id": 10,
    "question": "14 + 3",
    "options": ['17', '15', '16', '18'],
    "answer_index": 0,
  },
  {
    "id": 11,
    "question": "13 + 9",
    "options": ['22', '21', '20', '23'],
    "answer_index": 1,
  },
  {
    "id": 12,
    "question": "6 + 7",
    "options": ['14', '12', '11', '13'],
    "answer_index": 3,
  },
  {
    "id": 13,
    "question": "9 + 10",
    "options": ['19', '18', '17', '20'],
    "answer_index": 0,
  },
  {
    "id": 14,
    "question": "15 + 5",
    "options": ['20', '19', '18', '21'],
    "answer_index": 0,
  },
  {
    "id": 15,
    "question": "9 + 3",
    "options": ['12', '11', '10', '13'],
    "answer_index": 1,
  },
  {
    "id": 16,
    "question": "14 + 7",
    "options": ['19', '20', '21', '22'],
    "answer_index": 2,
  },
  {
    "id": 17,
    "question": "11 + 4",
    "options": ['16', '14', '13', '15'],
    "answer_index": 3,
  },
  {
    "id": 18,
    "question": "12 + 8",
    "options": ['20', '19', '18', '21'],
    "answer_index": 0,
  },
  {
    "id": 19,
    "question": "7 + 10",
    "options": ['15', '16', '17', '18'],
    "answer_index": 2,
  },
  {
    "id": 20,
    "question": "13 + 6",
    "options": ['19', '18', '17', '20'],
    "answer_index": 0,
  },
];
