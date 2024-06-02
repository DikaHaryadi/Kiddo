import 'package:cloud_firestore/cloud_firestore.dart';

class KidSongModel {
  final String id;
  String titleKidSong;
  String imageContent;
  String audio;

  KidSongModel(
      {required this.id,
      required this.titleKidSong,
      required this.imageContent,
      required this.audio});

  // static func empty kidsong model
  static KidSongModel empty() => KidSongModel(
        id: '',
        titleKidSong: '',
        imageContent: '',
        audio: '',
      );

  // convert model to json structure
  Map<String, dynamic> toJson() {
    return {
      'Title': titleKidSong,
      'ImageContent': imageContent,
      'Audio': audio,
    };
  }

  // create a KidSongModel from firebase document
  factory KidSongModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return KidSongModel(
        id: document.id,
        titleKidSong: data?['Title'] ?? '',
        imageContent: data?['ImageContent'] ?? '',
        audio: data?['Audio'] ?? '',
      );
    } else {
      return KidSongModel.empty();
    }
  }
}
