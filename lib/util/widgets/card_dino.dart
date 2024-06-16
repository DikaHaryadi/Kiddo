import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/dino_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/models/dino_model.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class CardDinoContent extends StatefulWidget {
  final DinoController controller;
  final DinoModel model;

  const CardDinoContent({
    Key? key,
    required this.controller,
    required this.model,
  }) : super(key: key);

  @override
  State<CardDinoContent> createState() => _CardDinoContentState();
}

class _CardDinoContentState extends State<CardDinoContent> {
  late bool isPlayingTitleVoice;
  late bool isPlayingDeskripsiVoice;
  late bool isPlayingSong;

  late final AudioPlayer player;
  late UrlSource pathTitleVoice;
  late UrlSource pathDeskripsiVoice;
  late UrlSource pathSong;

  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Get.height / 3;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    pathTitleVoice = UrlSource(widget.model.titleVoice);
    pathDeskripsiVoice = UrlSource(widget.model.deskripsiVoice);
    pathSong = UrlSource(widget.model.song);
    isPlayingTitleVoice = false;
    isPlayingDeskripsiVoice = false;
    isPlayingSong = false;

    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        setState(() {
          isPlayingTitleVoice = false;
          isPlayingDeskripsiVoice = false;
          isPlayingSong = false;
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playPauseTitleVoice() async {
    if (isPlayingTitleVoice && player.state == PlayerState.playing) {
      await player.pause();
    } else {
      if (isPlayingDeskripsiVoice || isPlayingSong) {
        await player.stop();
        isPlayingDeskripsiVoice = false;
        isPlayingSong = false;
      }
      await player.play(pathTitleVoice);
    }
    setState(() {
      isPlayingTitleVoice = !isPlayingTitleVoice;
    });
  }

  void playPauseDeskripsiVoice() async {
    if (isPlayingDeskripsiVoice && player.state == PlayerState.playing) {
      await player.pause();
    } else {
      if (isPlayingTitleVoice || isPlayingSong) {
        await player.stop();
        isPlayingTitleVoice = false;
        isPlayingSong = false;
      }
      await player.play(pathDeskripsiVoice);
    }
    setState(() {
      isPlayingDeskripsiVoice = !isPlayingDeskripsiVoice;
    });
  }

  void playPauseSong() async {
    if (isPlayingSong && player.state == PlayerState.playing) {
      await player.pause();
    } else {
      if (isPlayingTitleVoice || isPlayingDeskripsiVoice) {
        await player.stop();
        isPlayingTitleVoice = false;
        isPlayingDeskripsiVoice = false;
      }
      await player.play(pathSong);
    }
    setState(() {
      isPlayingSong = !isPlayingSong;
    });
  }

  void stopAudio() {
    player.stop();
    isPlayingTitleVoice = false;
    isPlayingDeskripsiVoice = false;
    isPlayingSong = false;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant CardDinoContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update pathTitleVoice when widget.model changes
    if (widget.model != oldWidget.model) {
      pathTitleVoice = UrlSource(widget.model.titleVoice);
      pathDeskripsiVoice = UrlSource(widget.model.deskripsiVoice);
      pathSong = UrlSource(widget.model.song);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ttsController = Get.put(TtsController());

    final List<String> items = [
      'assets/images/indonesia.png',
      'assets/images/english.png',
    ];

    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: widget.model.imageContent,
            fit: BoxFit.fill,
            placeholder: (context, url) => Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/Logo_color1.png'),
          ),
        ),
        Positioned(
          top: 14.0,
          left: 14.0,
          right: 14.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  width: 50,
                  height: 40,
                  child: GetBuilder<DinoController>(
                    builder: (controller) {
                      return DropdownButton<String>(
                        isExpanded: true,
                        value:
                            widget.controller.storage.read('language') == 'id'
                                ? items[0]
                                : items[1],
                        onChanged: (String? value) {
                          int index = items.indexOf(value!);
                          widget.controller
                              .setActiveLanguage(index == 0 ? 'id' : 'en');
                          widget.controller.saveLanguageDeskripsi(index);
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                        selectedItemBuilder: (BuildContext context) {
                          return items.map<Widget>((String item) {
                            return Image.asset(
                              item,
                              width: 24,
                              height: 24,
                            );
                          }).toList();
                        },
                        items:
                            items.map<DropdownMenuItem<String>>((String item) {
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
              Expanded(child: Container()),
              InkWell(
                onTap: () => widget.controller.toggleCollapse(),
                child: Icon(
                  !widget.controller.collapse.value
                      ? Iconsax.eye
                      : Iconsax.eye_slash,
                  color: kWhite,
                  size: 30,
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: playPauseSong,
                child: Icon(
                  isPlayingSong ? Iconsax.pause : Iconsax.musicnote,
                  color: kWhite,
                  size: 30,
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: playPauseDeskripsiVoice,
                child: Icon(
                  isPlayingDeskripsiVoice ? Iconsax.pause : Iconsax.play_circle,
                  color: kWhite,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (!widget.controller.collapse.value) {
            return Positioned(
              bottom: 20.0,
              left: 24.0,
              right: 24.0,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white.withOpacity(0.13)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          kBlack.withOpacity(0.5),
                          kBlack.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 8.0,
                        children: List.generate(
                            widget.controller.dinoModel.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              stopAudio();
                              widget.controller.selectedDino.value =
                                  widget.controller.dinoModel[index];
                              widget.controller.saveLanguageDeskripsi(index);
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: widget.controller.selectedDino
                                                  .value ==
                                              widget.controller.dinoModel[index]
                                          ? kWhite
                                          : Colors.transparent)),
                              child: CachedNetworkImage(
                                imageUrl: widget
                                    .controller.dinoModel[index].imageContent,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        'assets/images/Logo_color1.png'),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white.withOpacity(0.13)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          kBlack.withOpacity(0.5),
                          kBlack.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(child: Container()),
                            const SizedBox(width: 32.0),
                            Text(
                              widget.model.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.apply(color: kWhite),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: playPauseTitleVoice,
                              child: Icon(
                                isPlayingTitleVoice
                                    ? Iconsax.pause
                                    : Iconsax.play_circle,
                                color: kWhite,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        InkWell(
                          onTap: () => ttsController.textToSpeech(
                              widget.model.jenisMakanan, "en-US"),
                          child: Text(
                            widget.model.jenisMakanan,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.apply(color: kWhite),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Obx(() {
                          String deskripsi = widget.controller.deskripsiLang;
                          if (widget.controller.storage.read('language') ==
                              'id') {
                            deskripsi = widget.model.deskripsi;
                          } else {
                            deskripsi = widget.model.deskripsiEn;
                          }
                          return InkWell(
                            onTap: () {
                              setState(() {
                                hiddenText = !hiddenText;
                              });
                            },
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text: (hiddenText
                                    ? ('${deskripsi.substring(0, textHeight.toInt())}...')
                                    : deskripsi),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.apply(color: kWhite),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: hiddenText ? ' See More...' : '',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          hiddenText = !hiddenText;
                                        });
                                      },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Positioned(
              top: 14.0,
              left: 14.0,
              right: 14.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 50,
                      height: 40,
                      child: GetBuilder<DinoController>(
                        builder: (controller) {
                          return DropdownButton<String>(
                            isExpanded: true,
                            value: widget.controller.storage.read('language') ==
                                    'id'
                                ? items[0]
                                : items[1],
                            onChanged: (String? value) {
                              int index = items.indexOf(value!);
                              widget.controller
                                  .setActiveLanguage(index == 0 ? 'id' : 'en');
                              widget.controller.saveLanguageDeskripsi(index);
                            },
                            icon: const Icon(Icons.arrow_drop_down),
                            selectedItemBuilder: (BuildContext context) {
                              return items.map<Widget>((String item) {
                                return Image.asset(
                                  item,
                                  width: 24,
                                  height: 24,
                                );
                              }).toList();
                            },
                            items: items
                                .map<DropdownMenuItem<String>>((String item) {
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
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () => widget.controller.toggleCollapse(),
                    child: Icon(
                      !widget.controller.collapse.value
                          ? Iconsax.eye
                          : Iconsax.eye_slash,
                      color: kWhite,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: playPauseSong,
                    child: Icon(
                      isPlayingSong ? Iconsax.pause : Iconsax.musicnote,
                      color: kWhite,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: playPauseDeskripsiVoice,
                    child: Icon(
                      isPlayingDeskripsiVoice
                          ? Iconsax.pause
                          : Iconsax.play_circle,
                      color: kWhite,
                      size: 30,
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ],
    );
  }
}
