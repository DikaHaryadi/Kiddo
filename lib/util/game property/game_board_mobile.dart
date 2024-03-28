import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/game%20property/game.dart';
import 'package:textspeech/util/game%20property/game_confetti.dart';
import 'package:textspeech/util/game%20property/restart_game.dart';
import 'package:textspeech/util/widgets/memory_card.dart';
import 'package:unicons/unicons.dart';

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
  late Timer timer;
  late Game game;
  late Duration duration;
  int bestTime = 0;
  bool showConfetti = false;
  final RxInt backPressCount = 0.obs;
  final int maxBackPressCount = 2;
  late AudioPlayer audioPlayer;
  late final AssetSource path;
  bool isMusicPlaying = true;
  double _volume = 1.0;

  // banner ads
  // late BannerAd _bannerAd;
  // bool _isLoaded = false;

  /// Loads a banner ad.
  // inilizeBannerAd() async {
  //   _bannerAd = BannerAd(
  //       size: AdSize.banner,
  //       adUnitId: 'ca-app-pub-3940256099942544/9214589741',
  //       listener: BannerAdListener(
  //         onAdLoaded: (ad) {
  //           setState(() {
  //             _isLoaded = true;
  //           });
  //         },
  //         onAdFailedToLoad: (ad, error) {
  //           ad.dispose();
  //           _isLoaded = false;
  //           print(error);
  //         },
  //       ),
  //       request: const AdRequest());
  //   _bannerAd.load();
  // }

  // void _closeBanner() {
  //   setState(() {
  //     _isLoaded = false;
  //   });
  // }

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
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
        Get.offNamed('/'); // Navigate back to '/'
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
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
    // inilizeBannerAd();
    _createRewardedAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkGameStatus();
  }

  void saveGameStatus(bool isGameFinished) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isGameFinished', isGameFinished);
  }

  void checkGameStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isGameFinished = prefs.getBool('isGameFinished') ?? false;

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
    SharedPreferences gameSP = await SharedPreferences.getInstance();
    if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') != null) {
      bestTime = gameSP.getInt('${widget.gameLevel.toString()}BestTime')!;
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
        print('Break Time');
        timer.cancel();
        SharedPreferences.getInstance().then((gameSP) {
          if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') == null ||
              gameSP.getInt('${widget.gameLevel.toString()}BestTime')! >
                  duration.inSeconds) {
            gameSP.setInt(
                '${widget.gameLevel.toString()}BestTime', duration.inSeconds);
            setState(() {
              showConfetti = true;
              bestTime = duration.inSeconds;
              print('conffeti nya disini');
            });
            print('ini sharedPreferencesnya');
          }
        });
        print('stop audio bg music');
        audioPlayer.stop();

        playClapSound();
        print('mulai putar clap sound');

        _showGameOverDialog();
      }
    });
  }

  void playClapSound() async {
    if (audioPlayer.state == PlayerState.playing) {
      await audioPlayer.stop();
    }

    final path = AssetSource('voices/clap.mp3');
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

    saveGameStatus(false);
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    // _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   child: !_isLoaded
      //       ? Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             IconButton(
      //                 onPressed: toggleMute,
      //                 icon: isMusicPlaying
      //                     ? const Icon(UniconsLine.volume)
      //                     : const Icon(UniconsLine.volume_mute)),
      //             Slider(
      //               value: isMusicPlaying ? _volume : 0.0,
      //               min: 0.0,
      //               max: 1.0,
      //               onChanged: (newValue) {
      //                 setVolume(newValue);
      //               },
      //               onChangeEnd: (newValue) {
      //                 setVolume(newValue);
      //               },
      //             ),
      //             Text(
      //               '${calculateVolumePercentage(isMusicPlaying ? _volume : 0.0)}%',
      //               style: const TextStyle(fontSize: 16),
      //             ),
      //           ],
      //         )
      //       : SizedBox(
      //           width: double.infinity,
      //           child: Row(
      //             children: [
      //               IconButton(
      //                 icon: const Icon(UniconsLine.times_circle),
      //                 onPressed: _closeBanner,
      //               ),
      //               const Expanded(
      //                 child: SizedBox(), // Spacer widget for flexibility
      //               ),
      //               AdWidget(ad: _bannerAd)
      //             ],
      //           ),
      //         ),
      // ),
      appBar: AppBar(
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
                            BorderSide(color: Colors.red)),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Text(
                            'Exit from the game?',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  print('ini di exit $showConfetti');
                                  Get.offAllNamed('/');
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
            style:
                GoogleFonts.aBeeZee(fontWeight: FontWeight.w600, fontSize: 16)),
        centerTitle: true,
      ),
      body: Stack(
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
                        const CircleAvatar(
                            maxRadius: 20,
                            minRadius: 15,
                            backgroundColor: Color(0xFF8dbffa),
                            backgroundImage:
                                AssetImage('assets/animals/cat.png')),
                        const SizedBox(width: 5.0),
                        Text(
                          'Melissa',
                          style:
                              GoogleFonts.aBeeZee(fontSize: 14, shadows: const [
                            Shadow(color: Colors.white, offset: Offset(2, 2))
                          ]),
                        ),
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
                    child: RestartGame(
                      isGameOver: game.isGameOver,
                      pauseGame: () => pauseTimer(),
                      restartGame: () => _resetGame(),
                      continueGame: () => startTimer(),
                      color: Colors.amberAccent[700]!,
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
                    child:
                        // !_isLoaded
                        //     ?
                        Row(
                      children: [
                        IconButton(
                            onPressed: toggleMute,
                            icon: isMusicPlaying
                                ? const Icon(UniconsLine.volume)
                                : const Icon(UniconsLine.volume_mute)),
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
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                    // : Stack(
                    //     children: [
                    //       Positioned(
                    //           top: 0,
                    //           left: 0,
                    //           right: 0,
                    //           bottom: 0,
                    //           child: AdWidget(ad: _bannerAd)),
                    //       Positioned(
                    //         top: 0,
                    //         left: 0,
                    //         child: IconButton(
                    //           icon: const Icon(UniconsLine.times_circle),
                    //           onPressed: _closeBanner,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    ),
              ),
            ],
          ),
          showConfetti ? const GameConfetti() : const SizedBox(),
        ],
      ),
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text('Congratulations! You have completed the game.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _showRewardedAd();
                // Tidak melakukan navigasi ke '/'. Menunggu sampai iklan selesai ditampilkan.
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
