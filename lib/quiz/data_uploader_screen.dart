import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/firebase/loading_status.dart';
import 'package:textspeech/quiz/data_uploader.dart';

// ignore: must_be_immutable
class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({super.key});
  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Obx(() => Text(
              controller.loadingStatus.value == LoadingStatus.completed
                  ? 'uploaded completed'
                  : 'uploaded'))),
    );
  }
}
