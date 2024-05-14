import 'package:get/get.dart';
import 'package:textspeech/repository/letter_repo.dart';
import 'package:textspeech/models/letter_model.dart';

class LetterController extends GetxController {
  RxList<LetterModel> letterModel = <LetterModel>[].obs;
  final letterRepo = Get.put(LetterRepository());
  final isLoadingLetter = RxBool(false);

  @override
  void onInit() {
    fetchLetterCategory();
    super.onInit();
  }

  Future<void> fetchLetterCategory() async {
    try {
      isLoadingLetter.value = true;
      final letter = await letterRepo.fetchLetterContent();
      letterModel.assignAll(letter);
    } catch (e) {
      letterModel.assignAll([]);
    } finally {
      isLoadingLetter.value = false;
    }
  }
}
