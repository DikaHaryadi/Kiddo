import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/animal_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:audioplayers/audioplayers.dart';

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
  bool isShaking = false;
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

  void _handleTap() {
    setState(() {
      isShaking = true;
    });

    ttsController.textToSpeech(widget.model.titleAnimal, 'en-US');

    // Menghentikan animasi shake setelah beberapa waktu
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isShaking = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'assets/images/indonesia.png',
      'assets/images/english.png',
    ];

    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/animal_bg.png'),
                fit: BoxFit.fitHeight)),
        child: ListView(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 56.0),
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    border: Border.all(
                        color: kWhite, width: 2, style: BorderStyle.solid),
                  ),
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      border: Border.all(
                          color: kWhite, width: 2, style: BorderStyle.solid),
                    ),
                    child: Center(
                        child: TextButton(
                      onPressed: _handleTap,
                      child: Text(
                        widget.model.titleAnimal,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    )),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 56.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                            top: 35.0, left: 16.0, right: 16.0, bottom: 5.0),
                        margin: const EdgeInsets.only(right: 56.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.13)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.7),
                              Colors.white.withOpacity(0.5),
                            ],
                          ),
                        ),
                        child: GetBuilder<AnimalController>(
                          builder: (controller) {
                            String deskripsi = controller.deskripsiLang;
                            if (controller.storage.read('language_animal') ==
                                'id') {
                              deskripsi = widget.model.deskripsiAnimal;
                            } else {
                              deskripsi = widget.model.deskripsiEn;
                            }
                            return Text(
                              deskripsi,
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.apply(color: kBlack),
                            );
                          },
                        )),
                    Positioned(
                      right: -55.0,
                      top: -30.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        margin: const EdgeInsets.only(right: 56.0),
                        height: 60,
                        decoration: BoxDecoration(
                          color: kSoftblue,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30.0),
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.3),
                                offset: const Offset(-2, 0),
                                blurStyle: BlurStyle.normal,
                                blurRadius: 1),
                            BoxShadow(
                                color: Colors.black.withOpacity(.3),
                                offset: const Offset(0, -2),
                                blurStyle: BlurStyle.normal,
                                blurRadius: 1),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: GetBuilder<AnimalController>(
                                    builder: (controller) {
                                      return DropdownButton<String>(
                                        isExpanded: true,
                                        value: controller.storage
                                                    .read('language_animal') ==
                                                'id'
                                            ? items[0]
                                            : items[1],
                                        onChanged: (String? value) {
                                          int index = items.indexOf(value!);
                                          controller.setActiveLanguage(
                                              index == 0 ? 'id' : 'en');
                                          controller
                                              .saveLanguageDeskripsi(index);
                                        },
                                        icon: const Icon(Icons.arrow_drop_down),
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return items
                                              .map<Widget>((String item) {
                                            return Image.asset(
                                              item,
                                              width: 24,
                                              height: 24,
                                            );
                                          }).toList();
                                        },
                                        items: items
                                            .map<DropdownMenuItem<String>>(
                                                (String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Image.asset(
                                              item,
                                              width: 24,
                                              height: 24,
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  )),
                              Text(
                                'Description',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.apply(color: kWhite),
                              ),
                              const SizedBox(width: 8.0),
                              InkWell(
                                  onTap: () => ttsController.textToSpeech(
                                      widget.model.deskripsiAnimal, 'en-US'),
                                  child: const Icon(
                                    Iconsax.play_circle,
                                    color: kWhite,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 56.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      width: Get.width / 1.5,
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 45.0, right: 16.0, bottom: 16.0),
                      margin: const EdgeInsets.only(left: 56.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.13)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.7),
                            Colors.white.withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText.rich(
                            maxFontSize: 14,
                            minFontSize: 12,
                            TextSpan(
                                text:
                                    '${widget.model.jenisMakanan} | ${widget.model.kategori}'),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: kBlack),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: kBlack)),
                            child: IconButton(
                                onPressed: playPause,
                                icon: isPlaying
                                    ? const Icon(Iconsax.pause)
                                    : Image.asset('assets/icon/volume.png',
                                        width: 25, height: 25, color: kBlack)),
                          ),
                        ],
                      )),
                  Positioned(
                      left: -45.0,
                      top: -35.0,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(left: 56.0),
                          height: 70,
                          decoration: BoxDecoration(
                              color: kSoftblue,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: kBlack.withOpacity(.3),
                                    offset: const Offset(2, 0),
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 1),
                                BoxShadow(
                                    color: kBlack.withOpacity(.3),
                                    offset: const Offset(0, 2),
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 1),
                              ]),
                          child: GestureDetector(
                            onTap: _handleTap,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        widget.model.imageContent,
                                      ),
                                      fit: BoxFit.fitWidth)),
                            ).animate().shake(duration: 1000.ms),
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension FormatString on Duration {
  String format() => toString().substring(2, 7);
}
