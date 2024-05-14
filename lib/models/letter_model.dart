import 'package:cloud_firestore/cloud_firestore.dart';

class LetterModel {
  String imagePath;
  String name;
  String subImage;

  LetterModel(
      {required this.imagePath, required this.name, required this.subImage});

  // static func to create an empty letter model
  static LetterModel empty() =>
      LetterModel(imagePath: '', name: '', subImage: '');

  // convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'ImagePath': imagePath,
      'Name': name,
      'SubImage': subImage,
    };
  }

  // factory method to create LetterModel from a firebase document snapshot
  factory LetterModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return LetterModel(
          imagePath: data?['ImagePath'],
          name: data?['Name'],
          subImage: data?['SubImage']);
    } else {
      return LetterModel.empty();
    }
  }
}
