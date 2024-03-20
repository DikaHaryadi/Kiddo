import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Duration _duration = const Duration();
  Duration _position = const Duration();

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

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      player.play(path);
      isPlaying = true;
    }
    setState(() {});
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
                Get.back();
              });
            },
            icon: const Icon(Icons.arrow_back_ios)
                .animate(delay: const Duration(milliseconds: 250))
                .slideX(begin: -2, end: 0)),
        // title: Text(
        //   'Detail Animals',
        //   style: GoogleFonts.montserratAlternates(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.black,
        //   ),
        // )
        //     .animate(delay: const Duration(milliseconds: 250))
        //     .fadeIn(duration: const Duration(milliseconds: 500)),
        // centerTitle: true,
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
                    child: Text(
                      widget.name,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20,
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
                        Text(
                          widget.kategori,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.aBeeZee(
                            height: 1.3,
                            fontSize: 16,
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
                        Text(
                          '|',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.aBeeZee(
                            height: 1.3,
                            fontSize: 16,
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
                        Text(
                          widget.jenisMakanan,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.aBeeZee(
                            height: 1.3,
                            fontSize: 16,
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
                    child: Text(
                      widget.deskripsi,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.aBeeZee(
                        height: 1.3,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
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
                  ),
                  Slider(
                    value: _position.inSeconds.toDouble(),
                    onChanged: (double value) async {
                      await player.seek(Duration(seconds: value.toInt()));
                      setState(() {});
                    },
                    min: 0,
                    max: _duration.inSeconds.toDouble(),
                    inactiveColor: Colors.grey,
                    activeColor: Colors.red,
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
                              width: 50,
                              height: 50,
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
