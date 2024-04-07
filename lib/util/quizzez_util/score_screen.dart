import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/quizzez_util/question_controller.dart';
import 'package:unicons/unicons.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  // show reward ads
  RewardedAd? _rewardedAd;

  int _numRewardedLoadAttempts = 0;

  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313',
      request: AdRequest(),
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
      ),
    );
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
        Get.offNamed('/');
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
        print('$ad with reward ${reward.amount}, ${reward.type}');
      },
    );
    _rewardedAd = null;
  }

  @override
  void initState() {
    _createRewardedAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.put(QuestionController());

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Score",
              style:
                  Theme.of(context).textTheme.headline3!.copyWith(color: kDark),
            ),
            const SizedBox(height: 20.0),
            // Menggunakan currentQuestionSet untuk mengakses jumlah pertanyaan yang benar dan total pertanyaan yang sesuai dengan kumpulan pertanyaan saat ini
            Text(
              "${qnController.numOfCorrectAns * 10}/${qnController.currentQuestionSet.length * 10}",
              style:
                  Theme.of(context).textTheme.headline4!.copyWith(color: kDark),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton.icon(
              onPressed: () {
                _showRewardedAd();
              },
              icon: const Icon(UniconsLine.home),
              label: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
