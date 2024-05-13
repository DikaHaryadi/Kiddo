import 'package:get/get.dart';
import 'package:textspeech/controllers/animal_repo.dart';
import 'package:textspeech/models/animal_model.dart';

class AnimalController extends GetxController {
  RxList<AnimalModel> animalModels =
      <AnimalModel>[].obs; // Use RxList instead of Rx
  final animalRepo = Get.put(AnimalRepository());
  final isLoadingAnimal = RxBool(false);

  @override
  void onInit() {
    fetchAnimalCategory();
    super.onInit();
  }

  Future<void> fetchAnimalCategory() async {
    try {
      isLoadingAnimal.value = true;
      final animals = await animalRepo.fetchAnimalContent();
      animalModels.assignAll(animals); // Use assignAll to update RxList
    } catch (e) {
      animalModels.assignAll([]); // Use assignAll to update RxList
    } finally {
      isLoadingAnimal.value = false;
    }
  }
}
