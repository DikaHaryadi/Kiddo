import 'package:get/get.dart';
import 'package:textspeech/models/family_model.dart';
import 'package:textspeech/repository/family_repository.dart';

class FamilyController extends GetxController {
  RxList<FamilyModel> familyModel = <FamilyModel>[].obs;
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
    } catch (e) {
      familyModel.assignAll([]);
    } finally {
      isLoadingFamily.value = false;
    }
  }
}
