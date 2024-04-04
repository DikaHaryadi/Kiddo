import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/puzzle/darg.dart';
import 'package:textspeech/util/puzzle/drop.dart';
import 'package:textspeech/util/puzzle/fly_in_animation.dart';
import 'package:textspeech/util/puzzle/progress_bar.dart';

import '../util/puzzle/controller.dart';

// class WordGamePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Controller controller = Get.put(Controller());
//     WordGamePage() {
//     // Inisialisasi nilai _word dan _dropWord saat pertama kali
//     _generateWord();
//   }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fly In Animation Example'),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Container(
//               color: Colors.lightBlue,
//             ),
//             Obx(() {
//               final dropped = controller.letterDropped.value;
//               final generateWord = controller.generateWord.value;
//               final word = controller.word;
//               final dropWord = controller.dropWord;

//               if (generateWord && controller.words.isNotEmpty) {
//                 _generateWord(); // Panggil metode generateWord
//               }

//               return Column(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: SizedBox(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.amber,
//                             borderRadius: BorderRadius.circular(60),
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(18, 2, 2, 2),
//                                   child: FittedBox(
//                                     child: Text(
//                                       'Spelling Bee',
//                                       style:
//                                           Theme.of(context).textTheme.headline1,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: FlyInAnimation(
//                                     removeScale: true,
//                                     animate: dropped,
//                                     animationCompleted:
//                                         _animationCompleted(), // Perhatikan perubahan ini
//                                     child: Image.asset('assets/images/Bee.png'),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: dropWord.characters
//                           .map((e) => FlyInAnimation(
//                                 animate: true,
//                                 child: Drop(
//                                   letter: e,
//                                 ),
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: FlyInAnimation(
//                       animate: true,
//                       child: Image.asset('assets/images/$dropWord.png'),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: word.characters
//                           .map((e) => FlyInAnimation(
//                                 animate: true,
//                                 child: Drag(
//                                   letter: e,
//                                 ),
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: ProgressBar(),
//                   ),
//                 ],
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   _animationCompleted() {
//     // Perhatikan bahwa Anda tidak perlu Future.delayed disini
//     // Karena menggunakan GetX, Anda bisa langsung memanggil metode pada Controller
//     Get.find<Controller>().updateLetterDropped(dropped: false);
//   }

//   void _generateWord() {
//     final r = Random().nextInt(controller.words.length);
//     controller.word = controller.words[r];
//     controller.dropWord = controller.word;
//     controller.words.removeAt(r);
//     final s = controller.word.characters.toList()..shuffle();
//     controller.word = s.join();
//     controller.setUp(total: controller.word.length);
//     controller.requestWord(request: false);
//   }
// }

class WordGamePage extends StatelessWidget {
  final Controller controller = Get.put(Controller());

  WordGamePage() {
    // Inisialisasi nilai _word dan _dropWord saat pertama kali
    _generateWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fly In Animation Example'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.lightBlue,
            ),
            Obx(() {
              final dropped = controller.letterDropped.value;
              final generateWord = controller.generateWord.value;
              final word = controller.word;
              final dropWord = controller.dropWord;

              if (generateWord && controller.words.isNotEmpty) {
                _generateWord(); // Panggil metode generateWord
              }

              return Column(
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
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: FlyInAnimation(
                                    removeScale: true,
                                    animate: dropped,
                                    animationCompleted:
                                        _animationCompleted(), // Perhatikan perubahan ini
                                    child: Image.asset('assets/images/Bee.png'),
                                  ),
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
                      children: dropWord.characters
                          .map((e) => FlyInAnimation(
                                animate: true,
                                child: Drop(
                                  letter: e,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: FlyInAnimation(
                      animate: true,
                      child: Image.asset('assets/images/$dropWord.png'),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: word.characters
                          .map((e) => FlyInAnimation(
                                animate: true,
                                child: Drag(
                                  letter: e,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ProgressBar(),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  _animationCompleted() {
    // Perhatikan bahwa Anda tidak perlu Future.delayed disini
    // Karena menggunakan GetX, Anda bisa langsung memanggil metode pada Controller
    Get.find<Controller>().updateLetterDropped(dropped: false);
  }

  void _generateWord() {
    final r = Random().nextInt(controller.words.length);
    controller.word = controller.words[r];
    controller.dropWord = controller.word;
    controller.words.removeAt(r);
    final s = controller.word.characters.toList()..shuffle();
    controller.word = s.join();
    controller.setUp(total: controller.word.length);
    controller.requestWord(request: false);
  }
}
