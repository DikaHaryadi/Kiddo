import 'package:get/get.dart';
import 'package:textspeech/models/dino_model.dart';
import 'package:textspeech/repository/dino_repository.dart';

class DinoController extends GetxController {
  RxList<DinoModel> dinoModel = <DinoModel>[].obs;
  final Rx<DinoModel?> selectedDino = Rx<DinoModel?>(null);
  final dinoRepo = Get.put(DinoRepository());
  final isLoadingDino = RxBool(false);

  // New collapse state and its getter
  final RxBool collapse = RxBool(false);

  @override
  void onInit() {
    fetchDinoCategory();
    super.onInit();
  }

  Future<void> fetchDinoCategory() async {
    try {
      isLoadingDino.value = true;
      final animals = await dinoRepo.fetchDinoContent();
      dinoModel.assignAll(animals);

      if (dinoModel.isNotEmpty) {
        selectedDino.value = dinoModel[0];
      }
    } catch (e) {
      dinoModel.assignAll([]);
    } finally {
      isLoadingDino.value = false;
    }
  }

  // Method to toggle collapse state
  void toggleCollapse() {
    collapse.value = !collapse.value;
  }
}
