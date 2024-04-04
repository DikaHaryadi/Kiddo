import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/puzzle/controller.dart';
import 'package:textspeech/util/puzzle/darg.dart';
import 'package:textspeech/util/puzzle/drop.dart';
import 'package:textspeech/util/puzzle/fly_in_animation.dart';
import 'package:textspeech/util/puzzle/progress_bar.dart';

class PuzzleGame extends GetView<Controller> {
  PuzzleGame({super.key});
  final List<String> _words = allWords.toList();

  late String _word = ''; // Inisialisasi _word dan _dropWord
  late String _dropWord = '';

  void _generateWord() {
    if (_words.isNotEmpty) {
      final r = Random().nextInt(_words.length);
      final word = _words[r];
      _words.removeAt(r);

      final shuffledChars = word.characters.toList()..shuffle();
      _word = shuffledChars.join();

      controller.setUp(total: _word.length);
      controller.requestWord(request: false);
    }
  }

  void _animationCompleted() {
    Future.delayed(const Duration(milliseconds: 200), () {
      controller.updateLetterDropped(dropped: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      builder: (controller) {
        bool generate = controller.generateWord.value;
        if (generate && _words.isNotEmpty) {
          _generateWord();
        }

        return SafeArea(
          child: Stack(
            children: [
              Container(
                color: Colors.lightBlue,
              ),
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(18, 2, 2, 2),
                                  child: FittedBox(
                                    child: Text(
                                      'Spelling Bee',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Obx(() {
                                    bool dropped =
                                        controller.letterDropped.value;
                                    return FlyInAnimation(
                                      removeScale: true,
                                      animate: dropped,
                                      animationCompleted: _animationCompleted,
                                      child:
                                          Image.asset('assets/images/Bee.png'),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _dropWord.characters
                          .map(
                            (e) => FlyInAnimation(
                              animate: true,
                              child: Drop(
                                letter: e,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: FlyInAnimation(
                      animate: true,
                      child: Image.asset('assets/images/$_dropWord.png'),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _word.characters
                          .map(
                            (e) => FlyInAnimation(
                              animate: true,
                              child: Drag(
                                letter: e,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Expanded(flex: 1, child: ProgressBar()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
