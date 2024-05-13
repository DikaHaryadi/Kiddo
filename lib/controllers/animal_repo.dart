import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:textspeech/models/animal_model.dart';

import '../util/exceptions/firebase_exceptions.dart';
import '../util/exceptions/format_exceptions.dart';
import '../util/exceptions/platform_exceptions.dart';

class AnimalRepository extends GetxController {
  static AnimalRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<AnimalModel>> fetchAnimalContent() async {
    try {
      final documentSnapshot = await _db.collection('Animals').get();
      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs
            .map((doc) => AnimalModel.fromSnapshot(doc))
            .toList();
      } else {
        return [];
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
