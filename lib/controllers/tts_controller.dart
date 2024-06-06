import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TtsController extends GetxController {
  static TtsController get instance => Get.find();
  final flutterTts = FlutterTts();

  Future<void> textToSpeech(String text, String lang) async {
    try {
      await flutterTts.setLanguage(lang);
      await flutterTts.setVolume(1);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    } catch (e) {
      print("Error during text to speech: $e");
      // Handle error, show message, or do any necessary action
    }
  }
}
