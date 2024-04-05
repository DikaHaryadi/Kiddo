import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/curved_edges.dart';
import 'package:unicons/unicons.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFfcf4f1),
      backgroundColor: const Color(0xFFfab800),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFfcf4f1),
        leading: IconButton(
            onPressed: () => Get.offNamed('/'),
            icon: const Icon(Icons.arrow_back_ios)
                .animate(delay: const Duration(milliseconds: 250))
                .slideX(begin: -2, end: 0)),
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
                          color: kDark),
                    ).animate(delay: const Duration(milliseconds: 250)).slideX(
                        begin: -2,
                        end: 0,
                        duration: const Duration(milliseconds: 700)),
                  )),
            ),
          ),
          Expanded(
              child: AnimationLimiter(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 800),
                  child: SlideAnimation(
                    verticalOffset: 100.0,
                    child: FadeInAnimation(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              minRadius: 15,
                              maxRadius: 25,
                              child: Text(
                                '1',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                    color: kDark),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Summation 1 digit',
                                    style: GoogleFonts.roboto(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '10 | Easy',
                                    style: GoogleFonts.roboto(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  UniconsLine.clock_two,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                Text(
                                  '30s',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 15.0),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ))
          // const Center(
          //   child: Text(
          //     "Quizz App",
          //     style: TextStyle(
          //       color: kDark,
          //       fontSize: 48,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: Center(
          //     child: RawMaterialButton(
          //       onPressed: () {
          //         Get.offAllNamed('/quiz-screen');
          //       },
          //       shape: const StadiumBorder(),
          //       fillColor: kSoftblue,
          //       child: const Padding(
          //         padding:
          //             EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          //         child: Text(
          //           "Start the Quizz",
          //           style: TextStyle(
          //             color: kDark,
          //             fontSize: 26.0,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
