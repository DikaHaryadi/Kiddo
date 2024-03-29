import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/curved_edges.dart';
import 'package:textspeech/util/family_info.dart';
import 'package:unicons/unicons.dart';

class DetailFamily extends StatefulWidget {
  final String imgFamily;
  final String name;
  final String deskripsi;
  final String subtitle;
  const DetailFamily(
      {super.key,
      required this.imgFamily,
      required this.name,
      required this.deskripsi,
      required this.subtitle});

  @override
  State<DetailFamily> createState() => _DetailFamilyState();
}

class _DetailFamilyState extends State<DetailFamily> {
  late int currentIndex = -1;
  FlutterTts flutterTts = FlutterTts();

  void textToSpeech(String text) async {
    await flutterTts.setLanguage("id-ID");
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  static Route<dynamic> _routeBuilder(
      BuildContext context, List<Map<String, String>> familyList, int index) {
    return MaterialPageRoute(
      builder: (_) {
        return DetailFamily(
          imgFamily: familyList[index]['imagePath']!,
          name: familyList[index]['name']!,
          deskripsi: familyList[index]['deskripsi']!,
          subtitle: familyList[index]['subtitle']!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFfab800),
          leading: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      enableDrag: true,
                      useSafeArea: true,
                      clipBehavior: Clip.hardEdge,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          initialChildSize: 0.5,
                          snap: true,
                          snapSizes: const [0.5, 1.0],
                          builder: (context, scrollController) {
                            return CustomScrollView(
                              controller: scrollController,
                              physics: const ClampingScrollPhysics(),
                              slivers: [
                                SliverPersistentHeader(
                                  delegate: FamilyInfoAppBar(familyList.length),
                                  pinned: true,
                                ),
                                SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (_, index) => ListTile(
                                              onTap: () {
                                                if (index != currentIndex) {
                                                  setState(() {
                                                    currentIndex = index;
                                                  });
                                                  Navigator.pushReplacement(
                                                    context,
                                                    _routeBuilder(context,
                                                        familyList, index),
                                                  );
                                                }
                                              },
                                              leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                child: Image.asset(
                                                  familyList[index]
                                                      ['imagePath']!,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              title: Text(
                                                  familyList[index]['name']!,
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.aBeeZee(
                                                      height: 1.3,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black)),
                                              subtitle: Text(
                                                  familyList[index]
                                                      ['subtitle']!,
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.aBeeZee(
                                                      height: 1.3,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black)),
                                            ),
                                        childCount: familyList.length))
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    UniconsLine.list_ul,
                    color: Colors.white,
                    size: 30,
                  ))
              .animate(delay: const Duration(milliseconds: 250))
              .fadeIn(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic),
        ),
        body: Stack(
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
              top: 270,
              bottom: 150,
              left: 30,
              child: Text(
                widget.subtitle,
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFa35e3e)),
              ).animate(delay: const Duration(milliseconds: 250)).slideX(
                  begin: -2,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOutBack,
                  delay: const Duration(milliseconds: 100)),
            ),
            Positioned(
              right: 40,
              top: 180,
              bottom: 150,
              child: GestureDetector(
                onTap: () {
                  textToSpeech(widget.subtitle);
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFa35e3e),
                  ),
                  child: const Icon(
                    UniconsLine.play,
                    color: Colors.white,
                  ),
                ).animate(delay: const Duration(milliseconds: 250)).slideX(
                    begin: 2,
                    end: 0,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    delay: const Duration(milliseconds: 100)),
              ),
            ),
            Positioned(
              top: 240,
              bottom: 150,
              left: 30,
              child: Text(widget.name,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                  .animate(delay: const Duration(milliseconds: 250))
                  .slideX(
                      begin: -2,
                      end: 0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOutBack,
                      delay: const Duration(milliseconds: 100)),
            ),
            Positioned(
              top: 480,
              bottom: 100,
              right: 20,
              left: 20,
              child: Text(
                widget.deskripsi,
                textAlign: TextAlign.left,
                style: GoogleFonts.aBeeZee(
                  height: 1.4,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ).animate(delay: const Duration(milliseconds: 250)).slideY(
                  begin: 3,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOutBack,
                  delay: const Duration(milliseconds: 100)),
            )
          ],
        ));
  }
}
