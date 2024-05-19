import 'package:cloud_firestore/cloud_firestore.dart';

class NumberModel {
  String imagePath;
  String name;
  String subImage;
  String speech;

  NumberModel(
      {required this.imagePath,
      required this.name,
      required this.subImage,
      required this.speech});

  // static func to create an empty number model
  static NumberModel empty() =>
      NumberModel(imagePath: '', name: '', subImage: '', speech: '');

  // convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'ImagePath': imagePath,
      'Name': name,
      'SubImage': subImage,
    };
  }

  // facotry method to create NumberModel from a firebase document snapshot
  factory NumberModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return NumberModel(
          imagePath: data?['ImagePath'],
          name: data?['Name'],
          subImage: data?['SubImage'],
          speech: data?['speech']);
    } else {
      return NumberModel.empty();
    }
  }
}
