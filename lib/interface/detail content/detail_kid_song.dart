import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/kidsong_controller.dart';
import 'package:textspeech/controllers/native_ads_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/models/kidsong_model.dart';
import 'package:textspeech/util/etc/animal_info.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:textspeech/util/etc/to_title_case.dart';

class DetailKidSong extends StatefulWidget {
  final KidSongModel model;
  const DetailKidSong({
    super.key,
    required this.model,
  });

  @override
  State<DetailKidSong> createState() => _DetailKidSongState();
}

class _DetailKidSongState extends State<DetailKidSong> {
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
    KidSongModel animalModel,
  ) {
    return MaterialPageRoute(
      builder: (_) {
        return DetailKidSong(
          model: animalModel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KidSongController());
    final NativeAdsController nativeAdsController =
        Get.put(NativeAdsController());

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 250), () {
                Get.offAllNamed('/kid-song');
              });
            },
            icon: const Icon(Icons.arrow_back_ios)
                .animate(delay: const Duration(milliseconds: 250))
                .slideX(begin: -2, end: 0)),
      ),
      body: Column(
        children: [
          Obx(
            () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                  return RotationYTransition(rotation: rotate, child: child);
                },
                child: nativeAdsController.isAdLoaded.value
                    ? Container(
                        // key: const ValueKey(2),
                        decoration: BoxDecoration(
                            color: kGrey.withOpacity(.15),
                            borderRadius: BorderRadius.circular(30.0)),
                        width: MediaQuery.of(Get.context!).size.width * .8,
                        height: MediaQuery.of(Get.context!).size.height * .4,
                        child: Stack(
                          children: [
                            AdWidget(ad: nativeAdsController.nativeAd!),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white),
                                onPressed: () {
                                  nativeAdsController.closeAd();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(Get.context!).size.width * .8,
                        height: MediaQuery.of(Get.context!).size.height * .4,
                        // key: const ValueKey(1),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kGrey.withOpacity(.15),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            border: const Border.fromBorderSide(BorderSide(
                                color: Color.fromARGB(255, 176, 173, 168))),
                            image: DecorationImage(
                                image: NetworkImage(widget.model.imageContent),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle,
                          ),
                        ))),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: AutoSizeText(
                      toTitleCase(widget.model.titleKidSong),
                      maxFontSize: 22,
                      minFontSize: 20,
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        color: kBlack,
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
                            color: kBlack, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        _duration.format(),
                        style: GoogleFonts.aBeeZee(
                            color: kBlack, fontWeight: FontWeight.w400),
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
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: playPause,
                            icon: const Icon(
                              Iconsax.repeat,
                              color: kGrey,
                              size: 30,
                            )),
                        ClayContainer(
                          emboss: true,
                          borderRadius: 50,
                          width: 60,
                          height: 60,
                          child: IconButton(
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
                              Iconsax.backward_10_seconds,
                              color: _duration.inSeconds >= 10
                                  ? Colors.white
                                  : Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),
                        ClayContainer(
                          emboss: true,
                          borderRadius: 50,
                          width: 60,
                          height: 60,
                          child: IconButton(
                            onPressed: playPause,
                            icon: Icon(
                              isPlaying ? Iconsax.pause : Iconsax.play,
                              color: kWhite,
                              size: 30,
                            ),
                            // color: kGrey,
                          ),
                        ),
                        ClayContainer(
                          emboss: true,
                          borderRadius: 50,
                          width: 60,
                          height: 60,
                          child: IconButton(
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
                              Iconsax.forward_10_seconds,
                              color: _duration.inSeconds >= 10
                                  ? Colors.white
                                  : Colors.grey,
                              size: 30,
                            ),
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
                                                        .kidSongModel.length),
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
                                                                              _routeBuilder(context, controller.kidSongModel[index]),
                                                                            );
                                                                          }
                                                                        },
                                                                        leading:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0),
                                                                          child:
                                                                              Image.network(
                                                                            controller.kidSongModel[index].imageContent,
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        title: Text(
                                                                            controller.kidSongModel[index].titleKidSong,
                                                                            textAlign: TextAlign.left,
                                                                            style: GoogleFonts.aBeeZee(height: 1.3, fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
                                                                        subtitle:
                                                                            Row(
                                                                          children: [
                                                                            Text('kategori song disini',
                                                                                textAlign: TextAlign.left,
                                                                                style: GoogleFonts.aBeeZee(height: 1.3, fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
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
                                                                              'ntahlah apa ini',
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
                                                                    .kidSongModel
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
                              color: kGrey,
                              size: 35,
                            ))
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _contentView() {
  //   return Container(
  //     width: MediaQuery.of(Get.context!).size.width * .8,
  //     height: MediaQuery.of(Get.context!).size.height * .4,
  //     key: const ValueKey(1),
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //         color: kGrey.withOpacity(.15),
  //         borderRadius: BorderRadius.circular(30.0)),
  //     child: Container(
  //       width: 160,
  //       height: 160,
  //       decoration: BoxDecoration(
  //         border: const Border.fromBorderSide(
  //             BorderSide(color: Color.fromARGB(255, 176, 173, 168))),
  //         image: DecorationImage(
  //             image: NetworkImage(widget.model.imageContent), fit: BoxFit.fill),
  //         shape: BoxShape.circle,
  //       ),
  //     ).animate(delay: const Duration(milliseconds: 250)).slideY(
  //         begin: 2, end: 0, duration: const Duration(milliseconds: 700)),
  //   );
  // }

  //  Widget _showAds() {
  //   return Container(
  //     key: ValueKey(2),
  //     color: Colors.red,
  //     width: 300,
  //     height: 250,
  //     child: Stack(
  //       children: [
  //         AdWidget(ad: nativeAdsController.nativeAd!),
  //         Positioned(
  //           top: 5,
  //           right: 5,
  //           child: IconButton(
  //             icon: Icon(Icons.close, color: Colors.white),
  //             onPressed: () {
  //               nativeAdsController.closeAd();
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class RotationYTransition extends AnimatedWidget {
  const RotationYTransition({
    Key? key,
    required Animation<double> rotation,
    required this.child,
  }) : super(key: key, listenable: rotation);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> rotation = listenable as Animation<double>;
    return Transform(
      transform: Matrix4.rotationY(rotation.value),
      alignment: Alignment.center,
      child: child,
    );
  }
}

extension FormatString on Duration {
  String format() => toString().substring(2, 7);
}
