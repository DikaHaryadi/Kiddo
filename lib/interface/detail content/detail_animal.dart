import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/util/animal_info.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/curved_edges.dart';
import 'package:unicons/unicons.dart';
import 'package:audioplayers/audioplayers.dart';

class DetailAnimals extends StatefulWidget {
  final String imgAnimal;
  final String name;
  final String kategori;
  final String jenisMakanan;
  final String deskripsi;
  final String audio;
  const DetailAnimals(
      {super.key,
      required this.imgAnimal,
      required this.name,
      required this.deskripsi,
      required this.audio,
      required this.kategori,
      required this.jenisMakanan});

  @override
  State<DetailAnimals> createState() => _DetailAnimalsState();
}

class _DetailAnimalsState extends State<DetailAnimals> {
  bool isPlaying = false;
  late final AudioPlayer player;
  late final AssetSource path;
  FlutterTts flutterTts = FlutterTts();

  Duration _duration = const Duration();
  Duration _position = const Duration();
  late int currentIndex = -1;

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future initPlayer() async {
    player = AudioPlayer();
    path = AssetSource(widget.audio);

    player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    player.onPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });

    player.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        _position = _duration;
      });
    });
  }

  void textToSpeech(String text) async {
    await flutterTts.setLanguage('id-ID');
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      flutterTts.stop();
      player.play(path);
      isPlaying = true;
    }
    setState(() {});
  }

  static Route<dynamic> _routeBuilder(
      BuildContext context, List<Map<String, String>> animalsList, int index) {
    return MaterialPageRoute(
      builder: (_) {
        return DetailAnimals(
          imgAnimal: animalsList[index]['imagePath']!,
          name: animalsList[index]['name']!,
          deskripsi: animalsList[index]['deskripsi']!,
          audio: animalsList[index]['voice']!,
          kategori: animalsList[index]['kategori']!,
          jenisMakanan: animalsList[index]['jenis_makan']!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfab800),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 250), () {
                Get.offAllNamed('/animals-content');
              });
            },
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
              height: MediaQuery.of(context).size.height / 3,
              color: const Color(0xFFfffffc),
              child: Center(
                  child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  border: const Border.fromBorderSide(
                      BorderSide(color: Color.fromARGB(255, 176, 173, 168))),
                  image: DecorationImage(
                      image: AssetImage(widget.imgAnimal), fit: BoxFit.fill),
                  shape: BoxShape.circle,
                ),
              ).animate(delay: const Duration(milliseconds: 250)).slideY(
                      begin: 2,
                      end: 0,
                      duration: const Duration(milliseconds: 700))),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              // color: Colors.amber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: AutoSizeText(
                      widget.name,
                      maxFontSize: 22,
                      minFontSize: 20,
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ).animate(delay: const Duration(milliseconds: 250)).slideY(
                        begin: 2,
                        end: 0,
                        duration: const Duration(
                          milliseconds: 900,
                        ),
                        curve: Curves.easeOut,
                        delay: const Duration(
                          milliseconds: 100,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        AutoSizeText(
                          widget.kategori,
                          maxFontSize: 16,
                          minFontSize: 14,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.aBeeZee(
                            height: 1.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        )
                            .animate(delay: const Duration(milliseconds: 250))
                            .slideY(
                                begin: 2,
                                end: 0,
                                duration: const Duration(
                                  milliseconds: 900,
                                ),
                                curve: Curves.easeOut,
                                delay: const Duration(
                                  milliseconds: 100,
                                )),
                        const SizedBox(width: 5.0),
                        AutoSizeText(
                          ' | ',
                          maxFontSize: 16,
                          minFontSize: 14,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.aBeeZee(
                            height: 1.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        )
                            .animate(delay: const Duration(milliseconds: 250))
                            .slideY(
                                begin: 2,
                                end: 0,
                                duration: const Duration(
                                  milliseconds: 900,
                                ),
                                curve: Curves.easeOut,
                                delay: const Duration(
                                  milliseconds: 100,
                                )),
                        const SizedBox(width: 5.0),
                        AutoSizeText(
                          widget.jenisMakanan,
                          maxFontSize: 16,
                          minFontSize: 14,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.aBeeZee(
                            height: 1.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        )
                            .animate(delay: const Duration(milliseconds: 250))
                            .slideY(
                                begin: 2,
                                end: 0,
                                duration: const Duration(
                                  milliseconds: 900,
                                ),
                                curve: Curves.easeOut,
                                delay: const Duration(
                                  milliseconds: 100,
                                )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: InkWell(
                        onTap: () {
                          if (isPlaying == true) {
                            flutterTts.stop();
                          } else {
                            textToSpeech(widget.deskripsi);
                          }
                        },
                        child: AutoSizeText(
                          widget.deskripsi,
                          maxFontSize: 16,
                          minFontSize: 12,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.aBeeZee(
                            height: 1.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ).animate(delay: const Duration(milliseconds: 250)).slideX(
                      begin: -2,
                      end: 0,
                      duration: const Duration(
                        milliseconds: 900,
                      ),
                      curve: Curves.easeOut,
                      delay: const Duration(
                        milliseconds: 100,
                      )),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 0)),
                    child: Slider(
                      value: _position.inSeconds.toDouble(),
                      onChanged: (double value) async {
                        await player.seek(Duration(seconds: value.toInt()));
                        setState(() {});
                      },
                      min: 0,
                      max: _duration.inSeconds.toDouble(),
                      // inactiveColor: Colors.grey,
                      activeColor: Colors.green,
                    ).animate(delay: const Duration(milliseconds: 250)).slideY(
                        begin: 2,
                        end: 0,
                        duration: const Duration(
                          milliseconds: 900,
                        ),
                        curve: Curves.easeOut,
                        delay: const Duration(
                          milliseconds: 100,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _position.format(),
                        style: GoogleFonts.aBeeZee(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        _duration.format(),
                        style: GoogleFonts.aBeeZee(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ).animate(delay: const Duration(milliseconds: 250)).slideY(
                      begin: 2,
                      end: 0,
                      duration: const Duration(
                        milliseconds: 900,
                      ),
                      curve: Curves.easeOut,
                      delay: const Duration(
                        milliseconds: 100,
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: playPause,
                              icon: const Icon(
                                UniconsLine.repeat,
                                color: Colors.white,
                                size: 30,
                              )),
                          IconButton(
                            onPressed: _duration.inSeconds >= 10
                                ? () {
                                    if (_position.inSeconds >= 10) {
                                      player.seek(Duration(
                                          seconds: _position.inSeconds - 10));
                                    } else {
                                      player.seek(const Duration(seconds: 0));
                                    }
                                    setState(() {});
                                  }
                                : null,
                            icon: Icon(
                              UniconsLine.angle_double_left,
                              color: _duration.inSeconds >= 10
                                  ? Colors.white
                                  : Colors.grey,
                              size: 40,
                            ),
                          ),
                          GestureDetector(
                            onTap: playPause,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.fromBorderSide(BorderSide(
                                      color: isPlaying
                                          ? const Color(0xFFfffceb)
                                          : Colors.grey,
                                      width: 2,
                                      strokeAlign: 1))),
                              child: Icon(
                                isPlaying
                                    ? UniconsLine.pause
                                    : UniconsLine.play,
                                color: isPlaying ? Colors.green : Colors.grey,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _duration.inSeconds >= 10
                                ? () {
                                    if (_position.inSeconds <
                                        _duration.inSeconds - 10) {
                                      player.seek(Duration(
                                          seconds: _position.inSeconds + 10));
                                    } else {
                                      player.seek(_duration);
                                    }
                                    setState(() {});
                                  }
                                : null,
                            icon: Icon(
                              UniconsLine.angle_double_right,
                              color: _duration.inSeconds >= 10
                                  ? Colors.white
                                  : Colors.grey,
                              size: 40,
                            ),
                          ),
                          IconButton(
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
                                          physics:
                                              const ClampingScrollPhysics(),
                                          slivers: [
                                            SliverPersistentHeader(
                                              delegate: AnimalInfoAppBar(
                                                  animalsList.length),
                                              pinned: true,
                                            ),
                                            AnimationLimiter(
                                              child: SliverList(
                                                  delegate:
                                                      SliverChildBuilderDelegate(
                                                          (_, index) =>
                                                              AnimationConfiguration
                                                                  .staggeredList(
                                                                position: index,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            800),
                                                                child:
                                                                    SlideAnimation(
                                                                  verticalOffset:
                                                                      100.0,
                                                                  child:
                                                                      FadeInAnimation(
                                                                    child:
                                                                        ListTile(
                                                                      onTap:
                                                                          () {
                                                                        if (index !=
                                                                            currentIndex) {
                                                                          // Set currentIndex to the clicked index
                                                                          setState(
                                                                              () {
                                                                            currentIndex =
                                                                                index;
                                                                            print('ini currentIndex ketika di klik : ${currentIndex.toString()}');
                                                                          });
                                                                          Navigator
                                                                              .pushReplacement(
                                                                            context,
                                                                            _routeBuilder(
                                                                                context,
                                                                                animalsList,
                                                                                index),
                                                                          );
                                                                        }
                                                                      },
                                                                      leading:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.0),
                                                                        child: Image
                                                                            .asset(
                                                                          animalsList[index]
                                                                              [
                                                                              'imagePath']!,
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      title: Text(
                                                                          animalsList[index]
                                                                              [
                                                                              'name']!,
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style: GoogleFonts.aBeeZee(
                                                                              height: 1.3,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.black)),
                                                                      subtitle:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                              animalsList[index]['kategori']!,
                                                                              textAlign: TextAlign.left,
                                                                              style: GoogleFonts.aBeeZee(height: 1.3, fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
                                                                          const SizedBox(
                                                                              width: 5.0),
                                                                          Text(
                                                                            '|',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                GoogleFonts.aBeeZee(
                                                                              height: 1.3,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 5.0),
                                                                          Text(
                                                                            animalsList[index]['jenis_makan']!,
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                GoogleFonts.aBeeZee(
                                                                              height: 1.3,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          childCount:
                                                              animalsList
                                                                  .length)),
                                            )
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
                                size: 35,
                              ))
                        ],
                      )
                          .animate(delay: const Duration(milliseconds: 250))
                          .slideY(
                              begin: 2,
                              end: 0,
                              duration: const Duration(
                                milliseconds: 900,
                              ),
                              curve: Curves.easeOut,
                              delay: const Duration(
                                milliseconds: 100,
                              )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension FormatString on Duration {
  String format() => toString().substring(2, 7);
}
