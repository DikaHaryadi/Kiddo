import 'package:get/get.dart';
import 'package:textspeech/models/family_model.dart';
import 'package:textspeech/repository/family_repository.dart';

class FamilyController extends GetxController {
  RxList<FamilyModel> familyModel = <FamilyModel>[].obs;
  final Rx<FamilyModel?> selectedFamily = Rx<FamilyModel?>(null);
  final familyRepo = Get.put(FamilyRepository());
  final isLoadingFamily = RxBool(false);

  @override
  void onInit() {
    fetchFamilyCategory();
    super.onInit();
  }

  Future<void> fetchFamilyCategory() async {
    try {
      isLoadingFamily.value = true;
      final family = await familyRepo.fetchFamilyContent();
      familyModel.assignAll(family);

      // Set the default selected family to the first item if the list is not empty
      if (familyModel.isNotEmpty) {
        selectedFamily.value = familyModel[0];
      }
    } catch (e) {
      familyModel.assignAll([]);
    } finally {
      isLoadingFamily.value = false;
    }
  }
}
