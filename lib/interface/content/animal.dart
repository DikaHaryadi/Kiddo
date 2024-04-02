import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      print('ini path nya : $path');
      isPlaying = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String name = animalsList[selectedIndex]['name']!;
    String deskripsi = animalsList[selectedIndex]['deskripsi']!;
    // String audio = animalsList[selectedIndex]['voice']!;
    String kategori = animalsList[selectedIndex]['kategori']!;
    String jenisMakanan = animalsList[selectedIndex]['jenis_makan']!;

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
                'Animals',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 18 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xFF65d1ff),
                        image: const DecorationImage(
                            image: AssetImage('assets/animals.png'),
                            fit: BoxFit.fitHeight)),
                  ),
                ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 900)),
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
                  itemCount: animalsList.length,
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
                                animalsList[index]['imagePath']!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              );
                            },
                            openBuilder: (context, action) => DetailAnimals(
                              imgAnimal: animalsList[index]['imagePath']!,
                              name: animalsList[index]['name']!,
                              deskripsi: animalsList[index]['deskripsi']!,
                              audio: animalsList[index]['voice']!,
                              kategori: animalsList[index]['kategori']!,
                              jenisMakanan: animalsList[index]['jenis_makan']!,
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
                                    animalsList[index]['name']!,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text:
                                          '${animalsList[index]['kategori']} | ',
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '${animalsList[index]['jenis_makan']}',
                                          style: GoogleFonts.robotoSlab(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orangeAccent,
                                          ),
                                        )
                                      ],
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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailAnimals(
                                        imgAnimal: animalsList[index]
                                            ['imagePath']!,
                                        name: animalsList[index]['name']!,
                                        deskripsi: animalsList[index]
                                            ['deskripsi']!,
                                        audio: animalsList[index]['voice']!,
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
                          child: Scrollbar(
                            scrollbarOrientation: ScrollbarOrientation.left,
                            thickness: 5,
                            child: Container(
                              color: Colors.red,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: animalsList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 15.0),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10.0)),
                                            child: Image.asset(
                                              animalsList[index]['imagePath']!,
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
                                                  animalsList[index]['name']!,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  '${animalsList[index]['kategori']!}  |  ${animalsList[index]['jenis_makan']!}',
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
                                              delay: const Duration(
                                                  milliseconds: 250))
                                          .slideY(
                                              begin: 2.5,
                                              end: 0,
                                              duration: const Duration(
                                                  milliseconds: 700)),
                                    ),
                                  );
                                },
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
                                DateFormat('EEEE, MMM d')
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
                            top: 400,
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
                            top: 460,
                            left: 30,
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
                            bottom: 100,
                            right: 20,
                            left: 20,
                            child: Text(
                              deskripsi,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.aBeeZee(
                                height: 1.4,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
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
