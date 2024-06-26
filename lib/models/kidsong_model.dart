import 'package:cloud_firestore/cloud_firestore.dart';

class KidSongModel {
  final String id;
  String titleKidSong;
  String audio;
  String penyanyi;

  KidSongModel(
      {required this.id,
      required this.titleKidSong,
      required this.audio,
      required this.penyanyi});

  // static func empty kidsong model
  static KidSongModel empty() =>
      KidSongModel(id: '', titleKidSong: '', audio: '', penyanyi: '');

  // convert model to json structure
  Map<String, dynamic> toJson() {
    return {'Title': titleKidSong, 'Audio': audio, 'Penyanyi': penyanyi};
  }

  // create a KidSongModel from firebase document
  factory KidSongModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return KidSongModel(
        id: document.id,
        titleKidSong: data?['Title'] ?? '',
        audio: data?['Audio'] ?? '',
        penyanyi: data?['Penyanyi'] ?? '',
      );
    } else {
      return KidSongModel.empty();
    }
  }
}
