import 'package:get/get.dart';
import 'package:textspeech/models/dino_model.dart';
import 'package:textspeech/repository/dino_repository.dart';

class DinoController extends GetxController {
  RxList<DinoModel> dinoModel = <DinoModel>[].obs;
  final Rx<DinoModel?> selectedDino = Rx<DinoModel?>(null);
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
      final animals = await dinoRepo.fetchDinoContent();
      dinoModel.assignAll(animals); // Use assignAll to update RxList

      if (dinoModel.isNotEmpty) {
        selectedDino.value = dinoModel[0];
      }
    } catch (e) {
      dinoModel.assignAll([]); // Use assignAll to update RxList
    } finally {
      isLoadingDino.value = false;
    }
  }
}
