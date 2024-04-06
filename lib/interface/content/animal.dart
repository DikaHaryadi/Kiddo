import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:textspeech/interface/detail%20content/detail_animal.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/curved_edges.dart';
import 'package:textspeech/util/responsive.dart';
import 'package:unicons/unicons.dart';

class AnimalContent extends StatefulWidget {
  const AnimalContent({
    super.key,
  });

  @override
  State<AnimalContent> createState() => _AnimalContentState();
}

class _AnimalContentState extends State<AnimalContent> {
  bool isPlaying = false;
  int selectedIndex = 0;

  late final AudioPlayer player;
  late AssetSource path;

  Duration _duration = const Duration();
  Duration position = const Duration();

  @override
  void initState() {
    super.initState();
    initPlayer(animalsList[selectedIndex]['voice']!);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future initPlayer(String audio) async {
    player = AudioPlayer();
    path = AssetSource(audio);

    player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    player.onPositionChanged.listen((Duration p) {
      setState(() => position = p);
    });

    player.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        position = _duration;
      });
    });
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      path = AssetSource(animalsList[selectedIndex]['voice']!);
      player.play(path);
      isPlaying = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String name = animalsList[selectedIndex]['name']!;
    String deskripsi = animalsList[selectedIndex]['deskripsi']!;
    String kategori = animalsList[selectedIndex]['kategori']!;
    String jenisMakanan = animalsList[selectedIndex]['jenis_makan']!;

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFfcf4f1),
      appBar: isMobile(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: const Color(0xFFfcf4f1),
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
                        begin: -2,
                        end: 0,
                        duration: const Duration(milliseconds: 300)),
              ),
              title: AutoSizeText(
                'Animals',
                maxFontSize: 20,
                minFontSize: 18,
                style: GoogleFonts.montserratAlternates(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
                  .animate(delay: const Duration(milliseconds: 250))
                  .fadeIn(duration: const Duration(milliseconds: 800)),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 18 / 9,
                  child: AnimationConfiguration.staggeredGrid(
                    position: 0,
                    delay: const Duration(milliseconds: 250),
                    duration: const Duration(milliseconds: 900),
                    columnCount: 1,
                    child: FadeInAnimation(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/banner_animals.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                AutoSizeText(
                  'Categories',
                  maxFontSize: 20,
                  minFontSize: 18,
                  style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ).animate(delay: const Duration(milliseconds: 250)).slideX(
                    begin: -2.5,
                    end: 0,
                    duration: const Duration(milliseconds: 550)),
                AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: animalsList.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: const Duration(milliseconds: 250),
                        duration: const Duration(milliseconds: 800),
                        child: SlideAnimation(
                          verticalOffset: 100.0,
                          child: FadeInAnimation(
                            child: SizedBox(
                              width: double.infinity,
                              height: 100,
                              child: Row(
                                children: [
                                  OpenContainer(
                                    closedElevation: 0,
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    transitionType:
                                        ContainerTransitionType.fade,
                                    closedShape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    closedBuilder: (context, action) {
                                      return Image.asset(
                                        animalsList[index]['imagePath']!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    openBuilder: (context, action) =>
                                        DetailAnimals(
                                      imgAnimal: animalsList[index]
                                          ['imagePath']!,
                                      name: animalsList[index]['name']!,
                                      deskripsi: animalsList[index]
                                          ['deskripsi']!,
                                      audio: animalsList[index]['voice']!,
                                      kategori: animalsList[index]['kategori']!,
                                      jenisMakanan: animalsList[index]
                                          ['jenis_makan']!,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: const Color(0xFFfcf4f1),
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            animalsList[index]['name']!,
                                            maxFontSize: 14,
                                            minFontSize: 12,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orangeAccent,
                                            ),
                                          ),
                                          AutoSizeText.rich(
                                            maxFontSize: 14,
                                            minFontSize: 12,
                                            TextSpan(
                                                text:
                                                    '${animalsList[index]['kategori']} | ${animalsList[index]['jenis_makan']}'),
                                            style: GoogleFonts.robotoSlab(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orangeAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Future.delayed(
                                          const Duration(milliseconds: 250),
                                          () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailAnimals(
                                                imgAnimal: animalsList[index]
                                                    ['imagePath']!,
                                                name: animalsList[index]
                                                    ['name']!,
                                                deskripsi: animalsList[index]
                                                    ['deskripsi']!,
                                                audio: animalsList[index]
                                                    ['voice']!,
                                                kategori: animalsList[index]
                                                    ['kategori']!,
                                                jenisMakanan: animalsList[index]
                                                    ['jenis_makan']!,
                                              ),
                                            ));
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kGreen,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.white,
                                                  strokeAlign: 1,
                                                  width: 2))),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: kDark,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
                          child: Scrollbar(
                            scrollbarOrientation: ScrollbarOrientation.left,
                            thickness: 5,
                            child: Container(
                              color: Colors.red,
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: animalsList.length,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      delay: const Duration(milliseconds: 250),
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                        verticalOffset: 44.0,
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedIndex = index;
                                              });
                                            },
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15.0,
                                                        horizontal: 15.0),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      child: Image.asset(
                                                        animalsList[index]
                                                            ['imagePath']!,
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15.0),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          AutoSizeText(
                                                            animalsList[index]
                                                                ['name']!,
                                                            maxFontSize: 25,
                                                            minFontSize: 22,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          AutoSizeText(
                                                            '${animalsList[index]['kategori']!}  |  ${animalsList[index]['jenis_makan']!}',
                                                            minFontSize: 16,
                                                            maxFontSize: 20,
                                                            style: GoogleFonts
                                                                .robotoSlab(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
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
                                      child: IconButton(
                                          onPressed: () {
                                            Get.offNamed('/');
                                          },
                                          // ignore: prefer_const_constructors
                                          icon: Icon(
                                            Icons.arrow_back_ios_new,
                                            color: Colors.black,
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: AutoSizeText(
                                        'Today',
                                        minFontSize: 22,
                                        maxFontSize: 25,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AutoSizeText(
                                DateFormat('EEEE, MMM d')
                                    .format(DateTime.now()),
                                maxFontSize: 30,
                                minFontSize: 25,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold, color: kDark),
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
                            .animate(delay: const Duration(milliseconds: 250))
                            .slideY(
                                begin: 2.5,
                                end: 0,
                                duration: const Duration(milliseconds: 700)),
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
                            top: height * 0.35,
                            left: 30,
                            child: Text(name,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))
                                .animate(
                                    delay: const Duration(milliseconds: 250))
                                .fadeIn(
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOutBack,
                                    delay: const Duration(milliseconds: 100)),
                          ),
                          Positioned(
                            top: height * 0.4,
                            left: 30.0,
                            child: Text(
                              '$kategori | $jenisMakanan',
                              style: GoogleFonts.montserrat(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFa35e3e)),
                            )
                                .animate(
                                    delay: const Duration(milliseconds: 250))
                                .fadeIn(
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOutBack,
                                    delay: const Duration(milliseconds: 100)),
                          ),
                          Positioned(
                            right: 60,
                            top: 200,
                            bottom: 150,
                            child: GestureDetector(
                              onTap: playPause,
                              child: Container(
                                width: 85,
                                height: 85,
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
                            top: height * 0.6,
                            bottom: 10,
                            right: 20,
                            left: 20,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: AutoSizeText(
                                deskripsi,
                                maxFontSize: 25,
                                minFontSize: 22,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            )
                                .animate(
                                  delay: const Duration(milliseconds: 250),
                                )
                                .slideY(
                                  begin: 3,
                                  end: 0,
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOutBack,
                                  delay: const Duration(milliseconds: 100),
                                ),
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
