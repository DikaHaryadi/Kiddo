import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:textspeech/models/dino_model.dart';
import 'package:textspeech/repository/dino_repository.dart';

class DinoController extends GetxController {
  RxList<DinoModel> dinoModel = <DinoModel>[].obs;
  final Rx<DinoModel?> selectedDino = Rx<DinoModel?>(null);
  final dinoRepo = Get.put(DinoRepository());
  final storage = GetStorage();
  final RxString _deskripsiLang = ''.obs;
  final isLoadingDino = RxBool(false);

  String get deskripsiLang => _deskripsiLang.value;
  int get selectedIndex => _selectedIndex;
  final int _selectedIndex = 0;

  final RxBool collapse = RxBool(false);

  @override
  void onInit() {
    loadDeskripsiFromStorage();
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
        saveLanguageDeskripsi(0); // Set default deskripsi
      }
    } catch (e) {
      dinoModel.assignAll([]);
    } finally {
      isLoadingDino.value = false;
    }
  }

  void setActiveLanguage(String languageCode) async {
    await storage.write('language', languageCode);
    saveLanguageDeskripsi(selectedIndex); // Update deskripsi
    update();
  }

  void saveLanguageDeskripsi(int index) {
    if (storage.read('language') == 'id') {
      _deskripsiLang.value = dinoModel[index].deskripsi;
    } else {
      _deskripsiLang.value = dinoModel[index].deskripsiEn;
    }

    saveDeskripsiToStorage(_deskripsiLang.value);
    update();
  }

  void saveDeskripsiToStorage(String deskripsiLang) async {
    await storage.write('deskripsi', deskripsiLang);
  }

  void loadDeskripsiFromStorage() {
    _deskripsiLang.value = storage.read('deskripsi') ?? '';
  }

  void saveLanguage(String language) async {
    await storage.write('language', language);
  }

  void toggleCollapse() {
    collapse.value = !collapse.value;
  }
}
