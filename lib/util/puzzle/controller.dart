import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/puzzle/message_box.dart';

class Controller extends GetxController {
  final player = AudioPlayer();
  var totalLetters = 0.obs;
  var lettersAnswered = 0.obs;
  var wordsAnswered = 0.obs;
  var generateWord = true.obs;
  var sessionCompleted = false.obs;
  var letterDropped = false.obs;
  var percentCompleted = 0.0.obs;

  late String word;
  late String dropWord; // Tambahkan properti dropWord
  late List<String> words;

  setUp({required int total}) {
    lettersAnswered.value = 0;
    totalLetters.value = total;
  }

  // Metode lainnya tetap sama

  incrementLetters({required BuildContext context}) {
    lettersAnswered++;
    updateLetterDropped(dropped: true);
    if (lettersAnswered.value == totalLetters.value) {
      player.play(AssetSource('voices/Correct_2.mp3'));
      wordsAnswered++;
      percentCompleted.value = wordsAnswered.value / allWords.length;
      if (wordsAnswered.value == allWords.length) {
        sessionCompleted.value = true;
      }
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => MessageBox(
          sessionCompleted: sessionCompleted.value,
        ),
      );
    } else {
      player.play(AssetSource('voices/Correct_1.mp3'));
    }
  }

  requestWord({required bool request}) {
    generateWord.value = request;
  }

  updateLetterDropped({required bool dropped}) {
    letterDropped.value = dropped;
  }

  reset() {
    sessionCompleted.value = false;
    wordsAnswered.value = 0;
    generateWord.value = true;
    percentCompleted.value = 0;
  }
}
