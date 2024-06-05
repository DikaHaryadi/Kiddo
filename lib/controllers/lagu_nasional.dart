import 'package:get/get.dart';
import 'package:textspeech/models/lagu_nasional_model.dart';
import 'package:textspeech/repository/lagu_nasional_repo.dart';

class LaguNasionalController extends GetxController {
  RxList<LaguNasionalModel> laguNasionalModel = <LaguNasionalModel>[].obs;
  final Rx<LaguNasionalModel?> selectedAnimal = Rx<LaguNasionalModel?>(null);
  final laguNasionalRepo = Get.put(LaguNasionalRepository());
  final isLoadingAnimal = RxBool(false);

  @override
  void onInit() {
    fetchAnimalCategory();
    super.onInit();
  }

  Future<void> fetchAnimalCategory() async {
    try {
      isLoadingAnimal.value = true;
      final laguNasional = await laguNasionalRepo.fetchLaguNasionalContent();
      laguNasionalModel
          .assignAll(laguNasional); // Use assignAll to update RxList

      if (laguNasionalModel.isNotEmpty) {
        selectedAnimal.value = laguNasionalModel[0];
      }
    } catch (e) {
      laguNasionalModel.assignAll([]); // Use assignAll to update RxList
    } finally {
      isLoadingAnimal.value = false;
    }
  }
}
