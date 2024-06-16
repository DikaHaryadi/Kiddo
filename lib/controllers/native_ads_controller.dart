import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class NativeAdsController extends GetxController {
  NativeAd? nativeAd;
  InterstitialAd? interstitialAd;
  RxBool isNativeAdLoaded = false.obs;
  RxBool isInterstitialAdLoaded = false.obs;

  // Ganti adUnitId dengan ID iklan Anda sendiri
  final String nativeAdUnitId = "ca-app-pub-3940256099942544/2247696110";
  final String interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  @override
  void onInit() {
    super.onInit();
    loadNativeAd();
    loadInterstitialAd();
  }

  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          isNativeAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          isNativeAdLoaded.value = false;
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: kGrey.withOpacity(.15),
        cornerRadius: 30.0,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.cyan,
          style: NativeTemplateFontStyle.monospace,
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: kWhite,
          backgroundColor: kBlack,
          style: NativeTemplateFontStyle.italic,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.green,
          backgroundColor: Colors.black,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.brown,
          backgroundColor: Colors.amber,
          style: NativeTemplateFontStyle.normal,
          size: 16.0,
        ),
      ),
    );
    nativeAd!.load();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            isInterstitialAdLoaded.value = true;
          },
          onAdFailedToLoad: (LoadAdError error) {
            isInterstitialAdLoaded.value = false;
          },
        ));
  }

  void showInterstitialAd() {
    if (isInterstitialAdLoaded.value && interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdImpression: (ad) {},
        onAdFailedToShowFullScreenContent: (ad, err) {
          ad.dispose();
          Get.toNamed('/kid-song');
          isInterstitialAdLoaded.value = false;
          loadInterstitialAd();
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          isInterstitialAdLoaded.value = false;
          loadInterstitialAd();
        },
        onAdClicked: (ad) {},
      );

      interstitialAd!.show();
    } else {}
  }

  void closeNativeAd() {
    nativeAd?.dispose();
    isNativeAdLoaded.value = false;
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    interstitialAd?.dispose();
    isNativeAdLoaded.value = false;
    isInterstitialAdLoaded.value = false;
    super.dispose();
  }
}
