import 'package:cloud_firestore/cloud_firestore.dart';

class LaguNasionalModel {
  final String id;
  String audio;
  String deskripsi;
  String image;
  String pencipta;
  String subtitle;
  String title;

  LaguNasionalModel({
    required this.id,
    required this.audio,
    required this.deskripsi,
    required this.image,
    required this.pencipta,
    required this.subtitle,
    required this.title,
  });

  // static func to create an empty lagu nasional model
  static LaguNasionalModel empty() => LaguNasionalModel(
        id: '',
        audio: '',
        deskripsi: '',
        image: '',
        pencipta: '',
        subtitle: '',
        title: '',
      );

  // Convert model to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Audio': audio,
      'Deskripsi': deskripsi,
      'Image': pencipta,
      'Pencipta': subtitle,
      'Subtitle': title,
      'Title': title
    };
  }

  // Factory method to create a LaguNasionalModel from a Firebase document snapshot
  factory LaguNasionalModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return LaguNasionalModel(
        id: document.id,
        audio: data?['Audio'] ?? '',
        deskripsi: data?['Deskripsi'] ?? '',
        image: data?['Image'] ?? '',
        pencipta: data?['Pencipta'] ?? '',
        subtitle: data?['Subtitle'] ?? '',
        title: data?['Title'] ?? '',
      );
    } else {
      return LaguNasionalModel.empty();
    }
  }
}
