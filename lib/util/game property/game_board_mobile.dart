import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get_storage/get_storage.dart';
import 'package:info_popup/info_popup.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';
import 'package:textspeech/controllers/anchor_ads_controller.dart';
import 'package:textspeech/firebase/references.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/constants.dart';
import 'package:textspeech/util/etc/responsive.dart';
import 'package:textspeech/util/game%20property/game.dart';
import 'package:textspeech/util/game%20property/game_confetti.dart';
import 'package:textspeech/util/game%20property/restart_game.dart';
import 'package:textspeech/util/widgets/memory_card.dart';

import '../../auth/controller/user/user_controller.dart';
import '../../interface/user/edit_profile.dart';
import '../shimmer/shimmer.dart';

class GameBoardMobile extends StatefulWidget {
  const GameBoardMobile({
    required this.gameLevel,
    super.key,
  });

  final int gameLevel;

  @override
  State<GameBoardMobile> createState() => _GameBoardMobileState();
}

class _GameBoardMobileState extends State<GameBoardMobile> {
  final controller = Get.put(UserController());
  final anchorAdsController = Get.put(AnchorAdsController());
  late Timer timer;
  late Game game;
  late Duration duration;
  int bestTime = 0;
  bool showConfetti = false;
  bool clapSoundPlayed = false;
  late AudioPlayer audioPlayer;
  late final AssetSource path;
  bool isMusicPlaying = true;
  double _volume = 1.0;

  // show reward ads
  RewardedAd? _rewardedAd;

  int _numRewardedLoadAttempts = 0;

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5224354917'
            : 'ca-app-pub-3940256099942544/1712485313',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        _createRewardedAd();
        saveGameStatus(
          duration.toString().split('.').first.padLeft(8, "0"),
        );
        Get.offNamed('/memo-game'); // Navigasi ke /home
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  @override
  void initState() {
    super.initState();
    game = Game(widget.gameLevel);
    duration = const Duration();
    startTimer();
    getBestTime();
    checkGameStatus();
    audioPlayer = AudioPlayer();
    playBackgroundMusic();
    _createRewardedAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkGameStatus();
  }

  void saveGameStatus(String bestTime) async {
    var date = DateTime.now(); //timeStamp = 1630506255982
//  var d12 = DateFormat('MM/dd/yyyy, HH:mm:ss a').format(date); // 12/31/2021, 10:10:10 PM

    var dt2 = (date.toUtc().millisecondsSinceEpoch ~/ 1000).toInt();

    /// Converts back the base [DateTime] value to [int].
    print(dt2);
    print('loaded save best score');
    var batch = fireStore.batch();
    String level = '';
    final memoUser = fireStore.collection('Users');
    User? user = AuthenticationRepository.instance.authUser;
    setState(() {
      level = widget.gameLevel == 4
          ? 'Easy'
          : widget.gameLevel == 6
              ? 'Medium'
              : 'Hard';
    });
    if (user == null) return;
    batch
        .set(memoUser.doc(user.email).collection('memory_game').doc(user.uid), {
      'id': dt2,
      'Tingkat Kesulitan': level, //disini
      'score': bestTime
    });
    print('berhasil ke save memory game ke firebase');
    batch.commit();

    // final box = GetStorage(); // Perubahan di sini
    // await box.write('isGameFinished', isGameFinished.toString());
  }

  void checkGameStatus() async {
    final box = GetStorage(); // Perubahan di sini
    bool isGameFinished = box.read('isGameFinished') == 'true';

    setState(() {
      showConfetti = isGameFinished;
    });

    if (!isGameFinished) {
      setState(() {
        showConfetti = false;
      });
    } else {
      setState(() {
        showConfetti = true;
      });
    }
  }

  void playBackgroundMusic() async {
    audioPlayer = AudioPlayer();
    path = AssetSource('voices/music_memo_game.mp3');

    await audioPlayer.play(path);
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    isMusicPlaying = true;
  }

  void setVolume(double value) {
    _volume = value;
    audioPlayer.setVolume(value);
    if (value != 0.0) {
      isMusicPlaying = true;
    } else {
      isMusicPlaying = false;
    }
    setState(() {});
  }

  void toggleMute() {
    isMusicPlaying = !isMusicPlaying;
    if (isMusicPlaying) {
      audioPlayer.setVolume(_volume);
    } else {
      audioPlayer.setVolume(0.0);
    }
    setState(() {});
  }

  int calculateVolumePercentage(double volume) {
    int percentage = (volume * 100).round();
    return percentage;
  }

  void getBestTime() async {
    final box = GetStorage(); // Perubahan di sini
    if (box.read('${widget.gameLevel.toString()}BestTime') != null) {
      bestTime = box.read('${widget.gameLevel.toString()}BestTime');
    }
    setState(() {});
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        final seconds = duration.inSeconds + 1;
        duration = Duration(seconds: seconds);
      });

      if (game.isGameOver) {
        timer.cancel();
        final box = GetStorage(); // Mengambil instance GetStorage langsung
        if (box.read('${widget.gameLevel.toString()}BestTime') == null ||
            box.read('${widget.gameLevel.toString()}BestTime') >
                duration.inSeconds) {
          box.write(
              '${widget.gameLevel.toString()}BestTime', duration.inSeconds);
          setState(() {
            showConfetti = true;
            bestTime = duration.inSeconds;
          });
        }
        audioPlayer.stop();
        playCorrectSound(() {
          if (!clapSoundPlayed) {
            playClapSound();
            print('playing clap sound here');
            clapSoundPlayed = true;
          }
        });
        _showGameOverDialog();
      }
    });
  }

  void playCorrectSound(Function() onCompletion) async {
    if (audioPlayer.state == PlayerState.playing) {
      await audioPlayer.stop();
    }

    final path = AssetSource('voices/Correct_2.mp3');
    await audioPlayer.play(path);
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    audioPlayer.onPlayerComplete.listen((_) {
      onCompletion();
    });
  }

  void playClapSound() async {
    if (audioPlayer.state == PlayerState.playing) {
      await audioPlayer.stop();
    }

    final path = AssetSource('voices/clap.mp3');
    print('ini path clap sound' + path.toString());
    await audioPlayer.play(path);
    audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  pauseTimer() {
    timer.cancel();
  }

  void _resetGame() {
    game.resetGame();
    setState(() {
      timer.cancel();
      duration = const Duration();
      startTimer();
      showConfetti = false;
    });
  }

  @override
  void dispose() {
    game.dispose();
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return Scaffold(
      appBar: isMobile(context)
          ? AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              toolbarHeight: 45,
              elevation: 0,
              shadowColor: const Color(0xFF3F4045),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  pauseTimer();
                  return await showDialog(
                    context: Get.overlayContext!,
                    barrierDismissible: false,
                    builder: (context) {
                      return Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .45,
                          width: MediaQuery.of(context).size.width / 1.5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              border: const Border.fromBorderSide(
                                  BorderSide(color: kWhite)),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Text(
                                  'Exit from the game?',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.offAllNamed('/home');
                                      },
                                      child: Text(
                                        'Exit',
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        startTimer();
                                        Get.back(result: false);
                                      },
                                      child: Text(
                                        'Continue',
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              title: Text(duration.toString().split('.').first.padLeft(8, "0"),
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.w600, fontSize: 16)),
              centerTitle: true,
            )
          : null,
      body: isMobile(context)
          ? memoGameBody(aspectRatio)
          : PopScope(
              canPop: false,
              child: Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/games/bg_board_memo.png'),
                          fit: BoxFit.fill)),
                  child: tabletMemoGameBody(aspectRatio))),
    );
  }

  Stack memoGameBody(double aspectRatio) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 20.0),
                  decoration: const BoxDecoration(
                      color: Color(0xFF3675f7),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0))),
                  child: Row(
                    children: [
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : 'assets/images/cat.png';
                        return CircularImage(
                          image: image,
                          widht: 40,
                          height: 40,
                          isNetworkImage: networkImage.isNotEmpty,
                        );
                      }),
                      const SizedBox(width: 5.0),
                      Obx(() => controller.profileLoading.value
                          ? const DShimmerEffect(width: 100, height: 20)
                          : AutoSizeText(
                              controller.user.value.username,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  decoration: const BoxDecoration(
                      color: Color(0xFF3675f7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0))),
                  child: Row(
                    children: [
                      RestartGame(
                        isGameOver: game.isGameOver,
                        pauseGame: () => pauseTimer(),
                        restartGame: () => _resetGame(),
                        continueGame: () => startTimer(),
                        color: Colors.amberAccent[700]!,
                      ),
                      const SizedBox(width: 8.0),
                      InfoPopupWidget(
                        customContent: () {
                          return Container(
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: toggleMute,
                                      icon: Icon(isMusicPlaying
                                          ? Iconsax.volume_mute
                                          : Iconsax.volume_cross)),
                                  Slider(
                                    value: isMusicPlaying ? _volume : 0.0,
                                    min: 0.0,
                                    max: 1.0,
                                    onChanged: (newValue) {
                                      setVolume(newValue);
                                    },
                                    onChangeEnd: (newValue) {
                                      setVolume(newValue);
                                    },
                                  ),
                                  Text(
                                    '${calculateVolumePercentage(isMusicPlaying ? _volume : 0.0)}%',
                                  ),
                                ],
                              ));
                        },
                        arrowTheme: const InfoPopupArrowTheme(
                          color: kWhite,
                          arrowDirection: ArrowDirection.up,
                        ),
                        dismissTriggerBehavior:
                            PopupDismissTriggerBehavior.onTapArea,
                        areaBackgroundColor: Colors.transparent,
                        indicatorOffset: Offset.zero,
                        contentOffset: Offset.zero,
                        onControllerCreated: (controller) {
                          print('Info Popup Controller Created');
                        },
                        onAreaPressed: (InfoPopupController controller) {
                          print('Area Pressed');
                          controller.dismissInfoPopup();
                        },
                        infoPopupDismissed: () {
                          print('Info Popup Dismissed');
                        },
                        onLayoutMounted: (Size size) {
                          print('Info Popup Layout Mounted');
                        },
                        child: CircleAvatar(
                          minRadius: 15,
                          maxRadius: 20,
                          backgroundColor: const Color(0xFF8dbffa),
                          child: Icon(isMusicPlaying
                              ? Iconsax.volume_mute
                              : Iconsax.volume_cross),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 50.0),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: game.gridSize,
                childAspectRatio: aspectRatio * 2,
                children: List.generate(game.cards.length, (index) {
                  return MemoryCard(
                    index: index,
                    card: game.cards[index],
                    onCardPressed: game.onCardPressed,
                  );
                }),
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 2.5,
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black.withOpacity(.4),
                    ),
                  ),
                  child: anchorAdsController.getAdWidget()),
            ),
          ],
        ),
        showConfetti ? const GameConfetti() : const SizedBox(),
      ],
    );
  }

  Stack tabletMemoGameBody(double aspectRatio) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0))),
                  child: Row(
                    children: [
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : 'assets/images/cat.png';
                        return CircularImage(
                          image: image,
                          widht: 40,
                          height: 40,
                          isNetworkImage: networkImage.isNotEmpty,
                        );
                      }),
                      const SizedBox(width: 5.0),
                      Obx(() => controller.profileLoading.value
                          ? const DShimmerEffect(width: 100, height: 20)
                          : AutoSizeText(
                              controller.user.value.username,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                      const SizedBox(width: 8.0),
                      const Text('|'),
                      const SizedBox(width: 8.0),
                      Text(duration.toString().split('.').first.padLeft(8, "0"),
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
                  decoration: const BoxDecoration(
                      color: Color(0xFF3675f7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0))),
                  child: Row(
                    children: [
                      RestartGame(
                        isGameOver: game.isGameOver,
                        pauseGame: () => pauseTimer(),
                        restartGame: () => _resetGame(),
                        continueGame: () => startTimer(),
                        color: Colors.amberAccent[700]!,
                      ),
                      const SizedBox(width: 8.0),
                      InfoPopupWidget(
                        customContent: () {
                          return Container(
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: toggleMute,
                                      icon: Icon(isMusicPlaying
                                          ? Iconsax.volume_mute
                                          : Iconsax.volume_cross)),
                                  Slider(
                                    value: isMusicPlaying ? _volume : 0.0,
                                    min: 0.0,
                                    max: 1.0,
                                    onChanged: (newValue) {
                                      setVolume(newValue);
                                    },
                                    onChangeEnd: (newValue) {
                                      setVolume(newValue);
                                    },
                                  ),
                                  Text(
                                    '${calculateVolumePercentage(isMusicPlaying ? _volume : 0.0)}%',
                                  ),
                                ],
                              ));
                        },
                        arrowTheme: const InfoPopupArrowTheme(
                          color: kWhite,
                          arrowDirection: ArrowDirection.up,
                        ),
                        dismissTriggerBehavior:
                            PopupDismissTriggerBehavior.onTapArea,
                        areaBackgroundColor: Colors.transparent,
                        indicatorOffset: Offset.zero,
                        contentOffset: Offset.zero,
                        onControllerCreated: (controller) {
                          print('Info Popup Controller Created');
                        },
                        onAreaPressed: (InfoPopupController controller) {
                          print('Area Pressed');
                          controller.dismissInfoPopup();
                        },
                        infoPopupDismissed: () {
                          print('Info Popup Dismissed');
                        },
                        onLayoutMounted: (Size size) {
                          print('Info Popup Layout Mounted');
                        },
                        child: CircleAvatar(
                          minRadius: 15,
                          maxRadius: 20,
                          backgroundColor: const Color(0xFF8dbffa),
                          child: Icon(isMusicPlaying
                              ? Iconsax.volume_mute
                              : Iconsax.volume_cross),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 50.0),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: game.gridSize,
                childAspectRatio: aspectRatio * 2,
                children: List.generate(game.cards.length, (index) {
                  return MemoryCard(
                    index: index,
                    card: game.cards[index],
                    onCardPressed: game.onCardPressed,
                  );
                }),
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 2.5,
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black.withOpacity(.4),
                    ),
                  ),
                  child: anchorAdsController.getAdWidget()),
            ),
          ],
        ),
        showConfetti ? const GameConfetti() : const SizedBox(),
      ],
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Game Over',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: const Text('Congratulations! You have completed the game.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _showRewardedAd(); // Menampilkan iklan
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
