import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';
import 'package:textspeech/firebase/references.dart';
import 'package:textspeech/quiz/question_model.dart';
import 'package:textspeech/quiz/question_screen.dart';
import 'package:textspeech/services/firebase_storage_service.dart';
import 'package:textspeech/util/widgets/dialog_widget.dart';

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
      Get.dialog(Dialogs.catchUpDialogue(
          tryAgain: getAllpapers,
          navigateBack: () => Get.toNamed('/home'),
          title: 'Peringatan',
          subtitle: 'Ada yang salah saat memuat data',
          titletextStyle:
              GoogleFonts.aBeeZee(fontSize: 25, fontWeight: FontWeight.bold)));
    } finally {
      isLoadingLetter.value = false;
    }
  }

  void navigateToQuestions(
      {required QuestionModel paper, bool tryAgain = false}) {
    final user = AuthenticationRepository.instance.authUser;
    if (user != null) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(QuestionScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
    } else {
      Get.dialog(Dialogs.questionStartDialogue(
        onTap: () {
          Get.back();
        },
      ), barrierDismissible: false);
    }
  }
}
