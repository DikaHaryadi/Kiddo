import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/dino_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/models/dino_model.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class DinoTabletScreen extends StatefulWidget {
  final DinoController controller;
  final DinoModel model;

  const DinoTabletScreen(
      {Key? key, required this.controller, required this.model})
      : super(key: key);

  @override
  State<DinoTabletScreen> createState() => _DinoTabletScreenState();
}

class _DinoTabletScreenState extends State<DinoTabletScreen> {
  late bool isPlayingTitleVoice;
  late bool isPlayingDeskripsiVoice;
  late bool isPlayingSong;

  late final AudioPlayer player;
  late UrlSource pathTitleVoice;
  late UrlSource pathDeskripsiVoice;
  late UrlSource pathSong;

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
      // Stop any other playing audio before starting the new one
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
      // Stop any other playing audio before starting the new one
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
      // Stop any other playing audio before starting the new one
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
  void didUpdateWidget(covariant DinoTabletScreen oldWidget) {
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

    return GestureDetector(
      onTap: () {
        if (widget.controller.collapse.value) {
          widget.controller.toggleCollapse();
        }
      },
      child: Stack(
        children: [
          // CachedNetworkImage with conditional positioning
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.model.imageContent,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/Logo_color1.png'),
            ),
          ),
          Positioned(
            top: 24.0,
            left: 24.0,
            right: 24.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => IconButton(
                    onPressed: () => widget.controller.toggleCollapse(),
                    icon: Icon(
                      !widget.controller.collapse.value
                          ? Iconsax.eye
                          : Iconsax.eye_slash,
                      color: kWhite,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                InkWell(
                  onTap: playPauseSong,
                  child: Icon(
                    isPlayingSong ? Iconsax.pause : Iconsax.musicnote,
                    color: kWhite,
                    size: 40,
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
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.offNamed('/home'),
                  icon: const Icon(
                    Iconsax.back_square,
                    color: kWhite,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          // Expanded content when collapsed
          Obx(() {
            if (!widget.controller.collapse.value) {
              return Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 16,
                    bottom: Get.height / 3.5,
                    width: Get.width / 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        border: Border.all(color: kBlack.withOpacity(0.13)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.white.withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Scrollbar(
                        scrollbarOrientation: ScrollbarOrientation.left,
                        thickness: 5,
                        child: ListView.builder(
                          itemCount: widget.controller.dinoModel.length,
                          itemBuilder: (context, index) {
                            final dino = widget.controller.dinoModel[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              delay: const Duration(milliseconds: 250),
                              duration: const Duration(milliseconds: 1000),
                              child: SlideAnimation(
                                verticalOffset: 44.0,
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      stopAudio();
                                      widget.controller.selectedDino.value =
                                          dino;
                                    },
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 20.0,
                                      ),
                                      leading: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: dino.imageContent,
                                          fit: BoxFit.cover,
                                          width: 60,
                                          height: 60,
                                          placeholder: (context, url) =>
                                              Container(
                                            alignment: Alignment.center,
                                            child:
                                                const CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  'assets/images/Logo_color1.png'),
                                        ),
                                      ),
                                      title: Text(
                                        dino.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.apply(color: kBlack),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    left: 24.0,
                    right: 24.0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.13)),
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(child: Container()),
                              const SizedBox(width: 64.0),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  widget.model.title,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.apply(color: kWhite),
                                ),
                              ),
                              Expanded(child: Container()),
                              IconButton(
                                onPressed: playPauseTitleVoice,
                                icon: Icon(
                                  isPlayingTitleVoice
                                      ? Iconsax.pause
                                      : Iconsax.play_circle,
                                  color: kWhite,
                                  size: 40,
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
                          Text(
                            widget.model.deskripsi,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.apply(color: kWhite),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Default view or expanded content
              return Positioned(
                top: 24.0,
                left: 24.0,
                right: 24.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => IconButton(
                        onPressed: () => widget.controller.toggleCollapse(),
                        icon: Icon(
                          !widget.controller.collapse.value
                              ? Iconsax.eye
                              : Iconsax.eye_slash,
                          color: kWhite,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: playPauseSong,
                      child: Icon(
                        isPlayingSong ? Iconsax.pause : Iconsax.musicnote,
                        color: kWhite,
                        size: 40,
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
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.offNamed('/home'),
                      icon: const Icon(
                        Iconsax.back_square,
                        color: kWhite,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
