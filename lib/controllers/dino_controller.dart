import 'package:get/get.dart';
import 'package:textspeech/models/dino_model.dart';
import 'package:textspeech/repository/dino_repository.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DinoController extends GetxController {
  RxList<DinoModel> dinoModel = <DinoModel>[].obs;
  final dinoRepo = Get.put(DinoRepository());
  final isLoadingDino = RxBool(false);

  @override
  void onInit() {
    fetchDinoCategory();
    super.onInit();
  }

  Future<void> fetchDinoCategory() async {
    try {
      isLoadingDino.value = true;
      final dino = await dinoRepo.fetchDinoContent();
      if (dino.isEmpty) {
        Get.snackbar(
          'No Data',
          'No dinosaur data found',
          isDismissible: true,
          shouldIconPulse: true,
          colorText: Colors.white,
          backgroundColor: Colors.orange.shade600,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(20),
          icon: const Icon(
            Iconsax.info_circle,
            color: Colors.white,
          ),
        );
      }
      dinoModel.assignAll(dino);
    } catch (e) {
      Get.snackbar(
        'Oh Snap!',
        'Error fetching dinosaur data: $e',
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
    } finally {
      isLoadingDino.value = false;
    }
  }
}
