import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalModel {
  final String id;
  String titleAnimal;
  String imageContent;
  String deskripsiAnimal;
  String deskripsiEn;
  String kategori;
  String jenisMakanan;
  String audio;

  AnimalModel({
    required this.id,
    required this.titleAnimal,
    required this.imageContent,
    required this.deskripsiAnimal,
    required this.deskripsiEn,
    required this.kategori,
    required this.jenisMakanan,
    required this.audio,
  });

  // static func to create an empty animal model
  static AnimalModel empty() => AnimalModel(
        id: '',
        titleAnimal: '',
        deskripsiAnimal: '',
        imageContent: '',
        deskripsiEn: '',
        kategori: '',
        jenisMakanan: '',
        audio: '',
      );

  // Convert model to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Title': titleAnimal,
      'Deskripsi': deskripsiAnimal,
      'Deskripsi_En': deskripsiEn,
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
        imageContent: data?['ImageContent'] ?? '',
        deskripsiAnimal: data?['Deskripsi'] ?? '',
        deskripsiEn: data?['Deskripsi_En'] ?? '',
        kategori: data?['Kategori'] ?? '',
        jenisMakanan: data?['JenisMakanan'] ?? '',
        audio: data?['Audio'] ?? '',
      );
    } else {
      return AnimalModel.empty();
    }
  }
}
