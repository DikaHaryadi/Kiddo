import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:textspeech/auth/controller/user/user_controller.dart';
import 'package:textspeech/controllers/banner_ads_controller.dart';
import 'package:textspeech/controllers/kidsong_controller.dart';
import 'package:textspeech/controllers/native_ads_controller.dart';
import 'package:textspeech/interface/detail%20content/detail_kid_song.dart';
import 'package:textspeech/interface/user/edit_profile.dart';
import 'package:textspeech/models/kidsong_model.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/to_title_case.dart';
import 'package:textspeech/util/shimmer/shimmer.dart';

class KidSongTabletScreen extends StatefulWidget {
  const KidSongTabletScreen({super.key, required this.model});

  final KidSongModel model;

  @override
  State<KidSongTabletScreen> createState() => _KidSongTabletScreenState();
}

class _KidSongTabletScreenState extends State<KidSongTabletScreen> {
  final NativeAdsController nativeAdsController =
      Get.put(NativeAdsController());
  final userController = Get.put(UserController());
  final controller = Get.put(KidSongController());
  final bannerAdsController = Get.put(BannerAdsController());

  bool isPlaying = false;
  late final AudioPlayer player;
  late final UrlSource path;

  Duration _duration = const Duration();
  Duration _position = const Duration();
  late int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    initPlayer();
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
    return duration ?? const Duration();
  }

  Future<Duration> getAudioPosition() async {
    return _position;
  }

  void playPause() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play(path);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
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
        return Scaffold(
          body: KidSongTabletScreen(
            model: animalModel,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: kPrimaryBackground,
      child: Row(
        children: [
          _buildSongListPanel(),
          _buildAudioControlPanel(),
        ],
      ),
    );
  }

  Widget _buildSongListPanel() {
    return Expanded(
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
                    itemCount: controller.kidSongModel.length,
                    itemBuilder: (context, index) {
                      final kidSong = controller.kidSongModel[index];
                      return _buildSongListItem(kidSong, index);
                    },
                  ),
                ),
              ),
            ),
          ),
          _buildProfileSection(),
        ],
      ),
    );
  }

  Widget _buildSongListItem(KidSongModel kidSong, int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 250),
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 44.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () {
              if (index != currentIndex) {
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: ListTile(
                title: Text(
                  toTitleCase(kidSong.titleKidSong),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                subtitle: Text(
                  kidSong.penyanyi,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20.0,
            left: 0,
            right: 0,
            child: ListTile(
              leading: Container(
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
              title: AutoSizeText(
                'Today',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              DateFormat('EEEE, MMM d').format(DateTime.now()),
              maxFontSize: 30,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Obx(() {
                  final networkImage = userController.user.value.profilePicture;
                  final image = networkImage.isNotEmpty
                      ? networkImage
                      : 'assets/images/cat.png';
                  return CircularImage(
                    overlayColor: kBlack,
                    image: image,
                    widht: 60,
                    height: 60,
                    isNetworkImage: networkImage.isNotEmpty,
                  ).animate(delay: const Duration(milliseconds: 250)).slideX(
                      begin: -4,
                      end: 0,
                      curve: Curves.bounceIn,
                      duration: const Duration(milliseconds: 400));
                }),
                const SizedBox(width: 8),
                Obx(
                  () => userController.profileLoading.value
                      ? const DShimmerEffect(width: 100, height: 20)
                      : Text(
                          userController.user.value.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                          .animate(delay: const Duration(milliseconds: 250))
                          .slideX(
                              begin: 4,
                              end: 0,
                              curve: Curves.bounceIn,
                              duration: const Duration(milliseconds: 400)),
                )
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: const Duration(milliseconds: 250)).slideY(
        begin: 2.5, end: 0, duration: const Duration(milliseconds: 700));
  }

  Widget _buildAudioControlPanel() {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildAdSection(),
            _buildAudioControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdSection() {
    return Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final rotate = Tween(begin: pi, end: 0.0).animate(animation);
          return RotationYTransition(rotation: rotate, child: child);
        },
        child: nativeAdsController.isNativeAdLoaded.value &&
                nativeAdsController.nativeAd != null
            ? SafeArea(
                child: Container(
                key: const ValueKey(1),
                width: MediaQuery.of(Get.context!).size.width * .6,
                height: MediaQuery.of(Get.context!).size.height * .35,
                margin: const EdgeInsets.only(top: 56),
                child: Stack(
                  children: [
                    AdWidget(ad: nativeAdsController.nativeAd!),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: nativeAdsController.closeNativeAd,
                      ),
                    ),
                  ],
                ),
              ))
            : SafeArea(
                child: Container(
                  key: const ValueKey(2),
                  width: MediaQuery.of(Get.context!).size.width * .6,
                  height: MediaQuery.of(Get.context!).size.height * .35,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 56),
                  decoration: BoxDecoration(
                    color: kGrey.withOpacity(.15),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: const BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(
                          color: Color.fromARGB(255, 176, 173, 168))),
                      image: DecorationImage(
                        image: AssetImage('assets/banner_musik.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildAudioControls() {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: AutoSizeText(
                toTitleCase(widget.model.titleKidSong),
                style: Theme.of(context).textTheme.headlineMedium,
              ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                  duration: const Duration(milliseconds: 900),
                  delay: const Duration(milliseconds: 100)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: AutoSizeText(
                toTitleCase(widget.model.penyanyi),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.normal),
              ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                  duration: const Duration(milliseconds: 900),
                  delay: const Duration(milliseconds: 100)),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  trackHeight: 10,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 5)),
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
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  delay: const Duration(milliseconds: 100)),
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
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                delay: const Duration(milliseconds: 100)),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClayContainer(
                    emboss: true,
                    borderRadius: 50,
                    width: 80,
                    height: 80,
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
                        size: 45,
                      ),
                    ),
                  ),
                  ClayContainer(
                    emboss: true,
                    borderRadius: 50,
                    width: 80,
                    height: 80,
                    child: IconButton(
                      onPressed: playPause,
                      icon: Icon(
                        isPlaying ? Iconsax.pause : Iconsax.play,
                        color: kWhite,
                        size: 45,
                      ),
                    ),
                  ),
                  ClayContainer(
                    emboss: true,
                    borderRadius: 50,
                    width: 80,
                    height: 80,
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
                        size: 45,
                      ),
                    ),
                  ),
                ],
              ).animate(delay: const Duration(milliseconds: 250)).slideY(
                  begin: 2,
                  end: 0,
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  delay: const Duration(milliseconds: 100)),
            ),
            bannerAdsController.getAdWidget()
          ],
        ),
      ),
    );
  }
}
