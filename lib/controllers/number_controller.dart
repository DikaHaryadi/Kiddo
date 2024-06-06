import 'package:get/get.dart';
import 'package:textspeech/models/number_model.dart';
import 'package:textspeech/repository/number_repository.dart';

class NumberController extends GetxController {
  RxList<NumberModel> numberModels =
      <NumberModel>[].obs; // Use RxList instead of Rx
  final Rx<NumberModel?> selectedNumber = Rx<NumberModel?>(null);
  final animalRepo = Get.put(NumberRepository());
  final isLoadingNumber = RxBool(false);

  @override
  void onInit() {
    fetchAnimalCategory();
    super.onInit();
  }

  Future<void> fetchAnimalCategory() async {
    try {
      isLoadingNumber.value = true;
      final numbers = await animalRepo.fetchNumberContent();
      numberModels.assignAll(numbers); // Use assignAll to update RxList

      if (numberModels.isNotEmpty) {
        selectedNumber.value = numberModels[0];
      }
    } catch (e) {
      numberModels.assignAll([]); // Use assignAll to update RxList
    } finally {
      isLoadingNumber.value = false;
    }
  }
}
