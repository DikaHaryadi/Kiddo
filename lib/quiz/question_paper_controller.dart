import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:textspeech/firebase/references.dart';
import 'package:textspeech/quiz/question_model.dart';
import 'package:textspeech/services/firebase_storage_service.dart';

class QuestionPaperController extends GetxController {
  final allPapers = <QuestionModel>[].obs;
  final isLoadingLetter = RxBool(false);

  @override
  void onReady() {
    getAllpapers();
    super.onReady();
  }

  Future<void> getAllpapers() async {
    try {
      isLoadingLetter.value = true;
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList =
          data.docs.map((paper) => QuestionModel.fromSnapshot(paper)).toList();

      for (var paper in paperList) {
        final imgUrl = await Get.find<FirebaseStorageService>()
            .getImage('question_paper_images', paper.imageUrl);
        paper.imageUrl = imgUrl!;
      }

      allPapers.assignAll(paperList);
    } catch (e) {
      print('question_paper_controller error :' + e.toString());
    } finally {
      isLoadingLetter.value = false;
    }
  }
}
