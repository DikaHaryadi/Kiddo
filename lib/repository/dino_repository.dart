import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:textspeech/models/dino_model.dart';

class DinoRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<DinoModel>> fetchDinoContent() async {
    try {
      final querySnapshot = await _db.collection('Dinosaurus').get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => DinoModel.fromSnapshot(doc))
            .toList();
      } else {
        return [];
      }
    } catch (err) {
      print('Error fetching Dino content: $err');
      return [];
    }
  }
}
