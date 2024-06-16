import 'package:cloud_firestore/cloud_firestore.dart';

class DinoModel {
  final String id;
  final String title;
  final String jenisMakanan;
  final String imageContent;
  final String deskripsi;
  final String deskripsiEn;
  final String titleVoice;
  final String deskripsiVoice;
  final String song;

  DinoModel({
    required this.id,
    required this.title,
    required this.jenisMakanan,
    required this.imageContent,
    required this.deskripsi,
    required this.deskripsiEn,
    required this.titleVoice,
    required this.deskripsiVoice,
    required this.song,
  });

  // Factory method to create an empty DinoModel
  factory DinoModel.empty() => DinoModel(
      id: '',
      title: '',
      jenisMakanan: '',
      imageContent: '',
      deskripsi: '',
      deskripsiEn: '',
      titleVoice: '',
      deskripsiVoice: '',
      song: '');

  // Convert DinoModel to JSON structure for storing data in Firestore
  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Jenis_Makanan': jenisMakanan,
      'ImageContent': imageContent,
      'Deskripsi': deskripsi,
      'Deskripsi_En': deskripsiEn,
      'Title_Voice': titleVoice,
      'Deskripsi_Voice': deskripsiVoice,
      'Song': song
    };
  }

  // Factory method to create DinoModel from a Firestore document snapshot
  factory DinoModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return DinoModel(
          id: document.id,
          title: data['Title'] ?? '',
          jenisMakanan: data['Jenis_Makanan'] ?? '',
          imageContent: data['ImageContent'] ?? '',
          deskripsi: data['Deskripsi'] ?? '',
          deskripsiEn: data['Deskripsi_En'] ?? '',
          titleVoice: data['Title_Voice'] ?? '',
          deskripsiVoice: data['Deskripsi_Voice'] ?? '',
          song: data['Song'] ?? '');
    } else {
      return DinoModel.empty();
    }
  }
}
