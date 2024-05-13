import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalModel {
  final String id;
  String titleAnimal;
  String deskripsiAnimal;
  String imageContent;
  String kategori;
  String jenisMakanan;
  String audio;

  AnimalModel({
    required this.id,
    required this.titleAnimal,
    required this.deskripsiAnimal,
    required this.imageContent,
    required this.kategori,
    required this.jenisMakanan,
    required this.audio,
  });

  // static func to create an empty user model
  static AnimalModel empty() => AnimalModel(
        id: '',
        titleAnimal: '',
        deskripsiAnimal: '',
        imageContent: '',
        kategori: '',
        jenisMakanan: '',
        audio: '',
      );

  // Convert model to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Title': titleAnimal,
      'Deskripsi': deskripsiAnimal,
      'ImageContent': imageContent,
      'Kategori': kategori,
      'JenisMakanan': jenisMakanan,
      'Audio': audio,
    };
  }

  // Factory method to create a AnimalModel from a Firebase document snapshot
  factory AnimalModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return AnimalModel(
        id: document.id,
        titleAnimal: data?['Title'] ?? '',
        deskripsiAnimal: data?['Deskripsi'] ?? '',
        imageContent: data?['ImageContent'] ?? '',
        kategori: data?['Kategori'] ?? '',
        jenisMakanan: data?['JenisMakanan'] ?? '',
        audio: data?['Audio'] ?? '',
      );
    } else {
      return AnimalModel.empty();
    }
  }
}
