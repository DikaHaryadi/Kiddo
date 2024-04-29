import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:textspeech/firebase/references.dart';
import 'package:textspeech/quiz/question_model.dart';
import 'package:textspeech/services/firebase_storage_service.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionModel>[].obs;
  @override
  void onReady() {
    getAllpapers();
    super.onReady();
  }

  Future<void> getAllpapers() async {
    QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
    final paperList =
        data.docs.map((paper) => QuestionModel.fromSnapshot(paper)).toList();
    allPapers.assignAll(paperList);
    try {
      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl!;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print(e);
    }
  }
}
