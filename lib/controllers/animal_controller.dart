import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:textspeech/repository/animal_repo.dart';
import 'package:textspeech/models/animal_model.dart';

class AnimalController extends GetxController {
  RxList<AnimalModel> animalModels = <AnimalModel>[].obs;
  final Rx<AnimalModel?> selectedAnimal = Rx<AnimalModel?>(null);
  final animalRepo = Get.put(AnimalRepository());
  final storage = GetStorage();
  final isLoadingAnimal = RxBool(false);
  final RxString _deskripsiLang = ''.obs;
  String get deskripsiLang => _deskripsiLang.value;
  final int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  @override
  void onInit() {
    loadDeskripsiFromStorage();
    fetchAnimalCategory();
    super.onInit();
  }

  Future<void> fetchAnimalCategory() async {
    try {
      isLoadingAnimal.value = true;
      final animals = await animalRepo.fetchAnimalContent();
      animalModels.assignAll(animals); // Use assignAll to update RxList

      if (animalModels.isNotEmpty) {
        selectedAnimal.value = animalModels[0];
      }
    } catch (e) {
      animalModels.assignAll([]); // Use assignAll to update RxList
    } finally {
      isLoadingAnimal.value = false;
    }
  }

  void setActiveLanguage(String languageCode) async {
    await storage.write('language_animal', languageCode);
    saveLanguageDeskripsi(selectedIndex); // Update deskripsi
    update();
  }

  void saveLanguageDeskripsi(int index) {
    if (storage.read('language_animal') == 'id') {
      _deskripsiLang.value = animalModels[index].deskripsiAnimal;
    } else {
      _deskripsiLang.value = animalModels[index].deskripsiEn;
    }

    saveDeskripsiToStorage(_deskripsiLang.value);
    update();
  }

  void saveDeskripsiToStorage(String deskripsiLang) async {
    await storage.write('deskripsi_animal', deskripsiLang);
  }

  void loadDeskripsiFromStorage() {
    _deskripsiLang.value = storage.read('deskripsi_animal') ?? '';
  }

  void saveLanguage(String language) async {
    await storage.write('language_animal', language);
  }
}
