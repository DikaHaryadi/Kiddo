import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/models/kidsong_model.dart';

class KidSongRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<KidSongModel>> fetchKidSongContent() async {
    try {
      final documentSnapshot = await _db.collection('KidSong').get();
      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs
            .map((doc) => KidSongModel.fromSnapshot(doc))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Get.snackbar(
        'Oh Snap!',
        e.toString(),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      );
    }
  }
}
