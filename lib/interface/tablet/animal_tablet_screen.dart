import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:textspeech/controllers/animal_controller.dart';
import 'package:textspeech/models/animal_model.dart';
import 'package:textspeech/util/etc/app_colors.dart';

import '../../util/etc/curved_edges.dart';
import '../../util/etc/to_title_case.dart';

class AnimalTabletScreen extends StatefulWidget {
  final AnimalModel model;
  final AnimalController controller;
  const AnimalTabletScreen(
      {super.key, required this.model, required this.controller});

  @override
  State<AnimalTabletScreen> createState() => _AnimalTabletScreenState();
}

class _AnimalTabletScreenState extends State<AnimalTabletScreen> {
  late bool isPlaying;

  late final AudioPlayer player;
  late UrlSource path;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    path = UrlSource(widget.model.audio);
    isPlaying = false;
    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playPause() async {
    if (isPlaying && player.state == PlayerState.playing) {
      await player.pause();
    } else {
      await player.play(path);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void didUpdateWidget(covariant AnimalTabletScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update path when widget.model changes
    if (widget.model != oldWidget.model) {
      path = UrlSource(widget.model.audio);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: widget.controller.animalModels.length,
                            itemBuilder: (context, index) {
                              final animal =
                                  widget.controller.animalModels[index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 250),
                                duration: const Duration(milliseconds: 1000),
                                child: SlideAnimation(
                                  verticalOffset: 44.0,
                                  child: FadeInAnimation(
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.controller.selectedAnimal.value =
                                            animal;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 15.0,
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: animal.imageContent,
                                                fit: BoxFit.cover,
                                                width: 60,
                                                height: 60,
                                                placeholder: (context, url) =>
                                                    Container(
                                                  alignment: Alignment.center,
                                                  child:
                                                      const CircularProgressIndicator(),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/images/Logo_color1.png'),
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
                                                  AutoSizeText(
                                                    toTitleCase(
                                                        animal.titleAnimal),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.apply(color: kWhite),
                                                  ),
                                                  AutoSizeText(
                                                    toTitleCase(
                                                        '${animal.kategori}  |  ${animal.jenisMakanan}'),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.apply(color: kWhite),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                  ),
                  Container(
                    height: 300,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
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
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Get.offNamed('/home');
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0),
                                child: AutoSizeText(
                                  'Today',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AutoSizeText(
                          DateFormat('EEEE, MMM d').format(DateTime.now()),
                          maxFontSize: 30,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/images/Logo_color1.png',
                            width: 210,
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: const Duration(milliseconds: 250)).slideY(
                        begin: 2.5,
                        end: 0,
                        duration: const Duration(milliseconds: 700),
                      ),
                ],
              )),
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
                    top: Get.height * 0.35,
                    left: 30,
                    child: Text(
                      toTitleCase(widget.model.titleAnimal),
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.apply(color: kWhite),
                    ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOutBack,
                          delay: const Duration(milliseconds: 100),
                        ),
                  ),
                  Positioned(
                    top: Get.height * 0.4,
                    left: 30.0,
                    child: Text(
                      toTitleCase(
                          '${widget.model.kategori} | ${widget.model.jenisMakanan}'),
                      style: Theme.of(context).textTheme.headlineLarge?.apply(
                            color: const Color(0xFFa35e3e),
                          ),
                    ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOutBack,
                          delay: const Duration(milliseconds: 100),
                        ),
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
                        child: Center(
                          child: Icon(
                            isPlaying ? Iconsax.pause : Iconsax.play_circle,
                            color: kWhite,
                            size: 50,
                          ),
                        ),
                      )
                          .animate(delay: const Duration(milliseconds: 250))
                          .slideX(
                            begin: 2,
                            end: 0,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.fastEaseInToSlowEaseOut,
                            delay: const Duration(milliseconds: 100),
                          ),
                    ),
                  ),
                  Positioned(
                    top: Get.height * 0.6,
                    bottom: 10,
                    right: 20,
                    left: 20,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: AutoSizeText(widget.model.deskripsiAnimal,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyMedium),
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
