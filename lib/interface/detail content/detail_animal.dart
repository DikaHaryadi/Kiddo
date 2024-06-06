import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/animal_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/util/etc/animal_info.dart';
import 'package:textspeech/util/etc/curved_edges.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:textspeech/util/etc/to_title_case.dart';

import '../../models/animal_model.dart';

class DetailAnimals extends StatefulWidget {
  final AnimalModel model;
  const DetailAnimals({
    super.key,
    required this.model,
  });

  @override
  State<DetailAnimals> createState() => _DetailAnimalsState();
}

class _DetailAnimalsState extends State<DetailAnimals> {
  final ttsController = Get.put(TtsController());
  bool isPlaying = false;
  late final AudioPlayer player;
  late final UrlSource path;

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

  Future<void> initPlayer() async {
    player = AudioPlayer();
    path = UrlSource(widget.model.audio);

    player.onDurationChanged.listen((Duration d) {
      if (mounted) {
        setState(() => _duration = d);
      }
    });

    player.onPositionChanged.listen((Duration p) {
      if (mounted) {
        setState(() => _position = p);
      }
    });

    player.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          isPlaying = false;
          _position = _duration;
        });
      }
    });

    // Initialize duration when the page first opens
    final initialDuration = await getAudioDuration();
    if (mounted) {
      setState(() {
        _duration = initialDuration;
      });
    }
  }

  Future<Duration> getAudioDuration() async {
    await player.setSource(path);
    final duration = await player.getDuration();
    if (duration != null) {
      return duration;
    } else {
      return const Duration();
    }
  }

  Future<Duration> getAudioPosition() async {
    return _position;
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      ttsController.flutterTts.stop();
      player.play(path);
      isPlaying = true;
    }
    setState(() {});
  }

  void stopAudio() {
    player.stop();
    isPlaying = false;
    setState(() {});
  }

  static Route<dynamic> _routeBuilder(
    BuildContext context,
    AnimalModel animalModel,
  ) {
    return MaterialPageRoute(
      builder: (_) {
        return DetailAnimals(
          model: animalModel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnimalController());
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
                      image: NetworkImage(widget.model.imageContent),
                      fit: BoxFit.fill),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: AutoSizeText(
                      toTitleCase(widget.model.titleAnimal),
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
                          toTitleCase(widget.model.kategori),
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
                          toTitleCase(widget.model.jenisMakanan),
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
                            ttsController.flutterTts.stop();
                          } else {
                            ttsController.textToSpeech(
                                widget.model.deskripsiAnimal, "en-US");
                          }
                        },
                        child: AutoSizeText(
                          toTitleCase(widget.model.deskripsiAnimal),
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
                                Iconsax.repeat,
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
                              Iconsax.backward,
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
                                isPlaying ? Iconsax.pause : Iconsax.play,
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
                              Iconsax.forward,
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
                                      builder: (_, scrollController) {
                                        return Obx(() => CustomScrollView(
                                              controller: scrollController,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              slivers: [
                                                SliverPersistentHeader(
                                                  delegate: AnimalInfoAppBar(
                                                      controller
                                                          .animalModels.length),
                                                  pinned: true,
                                                ),
                                                AnimationLimiter(
                                                  child: SliverList(
                                                      delegate:
                                                          SliverChildBuilderDelegate(
                                                              (_, index) =>
                                                                  AnimationConfiguration
                                                                      .staggeredList(
                                                                    position:
                                                                        index,
                                                                    duration: const Duration(
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
                                                                              stopAudio();
                                                                              setState(() {
                                                                                currentIndex = index;
                                                                              });

                                                                              Navigator.pushReplacement(
                                                                                context,
                                                                                _routeBuilder(context, controller.animalModels[index]),
                                                                              );
                                                                            }
                                                                          },
                                                                          leading:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0),
                                                                            child:
                                                                                Image.network(
                                                                              controller.animalModels[index].imageContent,
                                                                              width: 50,
                                                                              height: 50,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                          title: Text(
                                                                              controller.animalModels[index].titleAnimal,
                                                                              textAlign: TextAlign.left,
                                                                              style: GoogleFonts.aBeeZee(height: 1.3, fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
                                                                          subtitle:
                                                                              Row(
                                                                            children: [
                                                                              Text(controller.animalModels[index].kategori, textAlign: TextAlign.left, style: GoogleFonts.aBeeZee(height: 1.3, fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
                                                                              const SizedBox(width: 5.0),
                                                                              Text(
                                                                                '|',
                                                                                textAlign: TextAlign.left,
                                                                                style: GoogleFonts.aBeeZee(
                                                                                  height: 1.3,
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 5.0),
                                                                              Text(
                                                                                controller.animalModels[index].jenisMakanan,
                                                                                textAlign: TextAlign.left,
                                                                                style: GoogleFonts.aBeeZee(
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
                                                                  controller
                                                                      .animalModels
                                                                      .length)),
                                                )
                                              ],
                                            ));
                                      },
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Iconsax.firstline,
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
