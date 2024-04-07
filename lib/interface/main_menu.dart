import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/curved_edges.dart';
import 'package:textspeech/util/quizzez_util/question_model.dart';
import 'package:unicons/unicons.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfab800),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFfcf4f1),
        leading: IconButton(
          onPressed: () => Get.offNamed('/'),
          icon: const Icon(Icons.arrow_back_ios)
              .animate(delay: const Duration(milliseconds: 250))
              .slideX(begin: -2, end: 0),
        ),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: TCustomCurvedEdges(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              color: const Color(0xFFfcf4f1),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Summation',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: kDark,
                    ),
                  ).animate(delay: const Duration(milliseconds: 250)).slideX(
                        begin: -2,
                        end: 0,
                        duration: const Duration(milliseconds: 700),
                      ),
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: 5, // Ubah jumlah kategori sesuai kebutuhan Anda
                itemBuilder: (context, index) {
                  return _buildCategoryItem(context, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    int itemNumber = index + 1;

    List<Question> questionSet;
    switch (index) {
      case 0:
        questionSet = sampleData1
            .map((data) => Question(
                  id: data['id'],
                  question: data['question'],
                  options: List<String>.from(data['options']),
                  answer: data['answer_index'],
                ))
            .toList();
        break;
      case 1:
        questionSet = sampleData2
            .map((data) => Question(
                  id: data['id'],
                  question: data['question'],
                  options: List<String>.from(data['options']),
                  answer: data['answer_index'],
                ))
            .toList();
        break;
      // Tambahkan kasus lainnya sesuai kebutuhan
      case 2:
        questionSet = sampleData3
            .map((data) => Question(
                  id: data['id'],
                  question: data['question'],
                  options: List<String>.from(data['options']),
                  answer: data['answer_index'],
                ))
            .toList();
        break;
      case 3:
        questionSet = sampleData4
            .map((data) => Question(
                  id: data['id'],
                  question: data['question'],
                  options: List<String>.from(data['options']),
                  answer: data['answer_index'],
                ))
            .toList();
        break;
      case 4:
        questionSet = sampleData5
            .map((data) => Question(
                  id: data['id'],
                  question: data['question'],
                  options: List<String>.from(data['options']),
                  answer: data['answer_index'],
                ))
            .toList();
        break;
      default:
        questionSet = [];
        break;
    }

    int totalQuestions = questionSet.length;

    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 800),
      child: SlideAnimation(
        verticalOffset: 100.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () {
              // Navigate to the quiz screen while providing the category index as an argument
              Get.offAllNamed('/quiz-screen', arguments: questionSet);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    minRadius: 15,
                    maxRadius: 25,
                    child: Text(
                      '$itemNumber',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: kDark,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Summation 1 digit',
                          maxLines: 15,
                          maxFontSize: 18,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AutoSizeText(
                          'Total Questions: $totalQuestions | Easy',
                          maxLines: 15,
                          maxFontSize: 18,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        UniconsLine.clock_two,
                        size: 35,
                        color: Colors.white,
                      ),
                      AutoSizeText(
                        '30s',
                        maxLines: 15,
                        maxFontSize: 18,
                        style: GoogleFonts.roboto(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
