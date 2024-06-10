import 'package:get/get.dart';
import 'package:textspeech/models/kidsong_model.dart';
import 'package:textspeech/repository/kid_song_repo.dart';

class KidSongController extends GetxController {
  RxList<KidSongModel> kidSongModel = <KidSongModel>[].obs;
  final Rx<KidSongModel?> selectedKidSong = Rx<KidSongModel?>(null);
  final kidSongRepo = Get.put(KidSongRepository());
  final isLoadingAnimal = RxBool(false);

  @override
  void onInit() {
    fetchAnimalCategory();
    super.onInit();
  }

  Future<void> fetchAnimalCategory() async {
    try {
      isLoadingAnimal.value = true;
      final kidSong = await kidSongRepo.fetchKidSongContent();
      kidSongModel.assignAll(kidSong); // Use assignAll to update RxList

      if (kidSongModel.isNotEmpty) {
        selectedKidSong.value = kidSongModel[0];
      }
    } catch (e) {
      kidSongModel.assignAll([]); // Use assignAll to update RxList
    } finally {
      isLoadingAnimal.value = false;
    }
  }
}
