import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/quiz/data_uploader.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({super.key});
  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('uploaded')),
    );
  }
}
