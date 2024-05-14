import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyModel {
  final String id;
  String subjectFamily;
  String subtitle;
  String imageContent;
  String deskripsiFamily;

  FamilyModel({
    required this.id,
    required this.subjectFamily,
    required this.subtitle,
    required this.imageContent,
    required this.deskripsiFamily,
  });

  // static func to create an empty user model
  static FamilyModel empty() => FamilyModel(
        id: '',
        subjectFamily: '',
        subtitle: '',
        imageContent: '',
        deskripsiFamily: '',
      );

  // Convert model to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'SubjectFamily': subjectFamily,
      'Subtitle': subtitle,
      'ImageContent': imageContent,
      'DeskripsiFamily': deskripsiFamily,
    };
  }

  // Factory method to create a FamilyModel from a Firebase document snapshot
  factory FamilyModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return FamilyModel(
        id: document.id,
        subjectFamily: data?['SubjectFamily'] ?? '',
        subtitle: data?['Subtitle'] ?? '',
        imageContent: data?['ImageContent'] ?? '',
        deskripsiFamily: data?['DeskripsiFamily'] ?? '',
      );
    } else {
      return FamilyModel.empty();
    }
  }
}
