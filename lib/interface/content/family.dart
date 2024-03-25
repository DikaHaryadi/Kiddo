import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:textspeech/interface/detail%20content/detail_family.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/curved_edges.dart';
import 'package:textspeech/util/responsive.dart';
import 'package:unicons/unicons.dart';

class FamilyContent extends StatelessWidget {
  const FamilyContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();

    void textToSpeech(String text) async {
      await flutterTts.setLanguage("id-ID");
      await flutterTts.setVolume(1);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    }

    return Scaffold(
      appBar: isMobile(context)
          ? AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 250), () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  });
                },
                icon: const Icon(Icons.arrow_back_ios)
                    .animate(delay: const Duration(milliseconds: 250))
                    .slideX(
                        begin: 2,
                        end: 0,
                        duration: const Duration(milliseconds: 300)),
              ),
              title: Text(
                'widget.name',
                style: GoogleFonts.montserratAlternates(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ).animate(delay: const Duration(milliseconds: 250)).slideX(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 400)),
              centerTitle: true,
            )
          : null,
      body: ListView(
        padding: isMobile(context)
            ? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)
            : EdgeInsets.zero,
        children: [
          if (isMobile(context))
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 18 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xFF65d1ff),
                        image: const DecorationImage(
                            image: AssetImage('assets/family/0.png'))),
                  ),
                )
                    .animate(delay: const Duration(milliseconds: 250))
                    .fadeIn(duration: const Duration(milliseconds: 900)),
                const SizedBox(height: 25.0),
                Text(
                  'Text',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ).animate(delay: const Duration(milliseconds: 250)).slideX(
                    begin: 2.5,
                    end: 0,
                    duration: const Duration(milliseconds: 550)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: familyList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        children: [
                          OpenContainer(
                            openColor: Colors.pink,
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            transitionType: ContainerTransitionType.fade,
                            closedShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            closedBuilder: (context, action) {
                              return Image.asset(
                                familyList[index]['imagePath']!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              );
                            },
                            openBuilder: (context, action) => DetailFamily(
                              imgFamily: familyList[index]['imagePath']!,
                              name: familyList[index]['name']!,
                              deskripsi: familyList[index]['deskripsi']!,
                              subtitle: familyList[index]['subtitle']!,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    familyList[index]['name']!,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                  Text(
                                    familyList[index]['subtitle']!,
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 250),
                                  () {
                                Get.to(
                                  () => DetailFamily(
                                    imgFamily: familyList[index]['imagePath']!,
                                    name: familyList[index]['name']!,
                                    deskripsi: familyList[index]['deskripsi']!,
                                    subtitle: familyList[index]['subtitle']!,
                                  ),
                                );
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  border: const Border.fromBorderSide(
                                      BorderSide(
                                          color: Colors.orange,
                                          strokeAlign: 1,
                                          width: 1))),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.orange,
                              ),
                            ),
                          )
                        ],
                      ),
                    ).animate(delay: const Duration(milliseconds: 250)).slideY(
                        begin: 2.5,
                        end: 0,
                        duration: const Duration(milliseconds: 700));
                  },
                ),
              ],
            ),
          if (isDesktop(context))
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.red,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: familyList.length,
                              itemBuilder: (context, index) {
                                // return ListTile(
                                //   contentPadding: const EdgeInsets.symmetric(
                                //       vertical: 15.0, horizontal: 15.0),
                                //   leading: OpenContainer(
                                //     openColor: Colors.pink,
                                //     transitionDuration:
                                //         const Duration(milliseconds: 500),
                                //     transitionType:
                                //         ContainerTransitionType.fade,
                                //     closedShape: const RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(10.0)),
                                //     ),
                                //     closedBuilder: (context, action) {
                                //       return Image.asset(
                                //         familyList[index]['imagePath']!,
                                //         width: 60,
                                //         height: 60,
                                //         fit: BoxFit.cover,
                                //       );
                                //     },
                                //     openBuilder: (context, action) =>
                                //         DetailFamily(
                                //       imgFamily: familyList[index]
                                //           ['imagePath']!,
                                //       name: familyList[index]['name']!,
                                //       deskripsi: familyList[index]
                                //           ['deskripsi']!,
                                //       subtitle: familyList[index]['subtitle']!,
                                //     ),
                                //   ),
                                //   title: Expanded(
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Text(
                                //           familyList[index]['name']!,
                                //           style: GoogleFonts.montserrat(
                                //             fontSize: 15,
                                //             fontWeight: FontWeight.bold,
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //         Text(
                                //           familyList[index]['subtitle']!,
                                //           style: GoogleFonts.robotoSlab(
                                //             fontSize: 15,
                                //             fontWeight: FontWeight.bold,
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // )
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 15.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: Image.asset(
                                          familyList[index]['imagePath']!,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              familyList[index]['name']!,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              familyList[index]['subtitle']!,
                                              style: GoogleFonts.robotoSlab(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                      .animate(
                                          delay:
                                              const Duration(milliseconds: 250))
                                      .slideY(
                                          begin: 2.5,
                                          end: 0,
                                          duration: const Duration(
                                              milliseconds: 700)),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 300,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: const IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.arrow_back_ios_new,
                                            color: Colors.black,
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: Text(
                                        'Today',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                DateFormat('EEEE, MMM d', 'id')
                                    .format(DateTime.now()),
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Expanded(
                                child: Image.asset(
                                  'assets/images/Logo_color1.png',
                                  width: 210,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          ClipPath(
                            clipper: FamilyCurvedEdges(),
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height,
                              color: const Color(0xFFfab800),
                            ),
                          ),
                          Positioned(
                            top: 400,
                            left: 30,
                            child: Text('widget.name',
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))
                                .animate(
                                    delay: const Duration(milliseconds: 250))
                                .slideX(
                                    begin: -2,
                                    end: 0,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOutBack,
                                    delay: const Duration(milliseconds: 100)),
                          ),
                          Positioned(
                            top: 450,
                            left: 30,
                            child: Text(
                              'widget.subtitle',
                              style: GoogleFonts.montserrat(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFa35e3e)),
                            )
                                .animate(
                                    delay: const Duration(milliseconds: 250))
                                .slideX(
                                    begin: -2,
                                    end: 0,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOutBack,
                                    delay: const Duration(milliseconds: 100)),
                          ),
                          Positioned(
                            right: 60,
                            top: 200,
                            bottom: 150,
                            child: GestureDetector(
                              onTap: () {
                                // textToSpeech(widget.subtitle);
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFa35e3e),
                                ),
                                child: const Center(
                                  child: Icon(
                                    UniconsLine.play,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              )
                                  .animate(
                                      delay: const Duration(milliseconds: 250))
                                  .slideX(
                                      begin: 2,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.fastEaseInToSlowEaseOut,
                                      delay: const Duration(milliseconds: 100)),
                            ),
                          ),
                          Positioned(
                            bottom: 100,
                            right: 20,
                            left: 20,
                            child: Text(
                              ' widget.deskripsi',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.aBeeZee(
                                height: 1.4,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            )
                                .animate(
                                    delay: const Duration(milliseconds: 250))
                                .slideY(
                                    begin: 3,
                                    end: 0,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOutBack,
                                    delay: const Duration(milliseconds: 100)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
