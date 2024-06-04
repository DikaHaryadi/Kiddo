import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class NativeAdsController extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;

  // Ganti adUnitId dengan ID iklan Anda sendiri
  final String adUnitId = "ca-app-pub-3940256099942544/2247696110";

  @override
  void onInit() {
    super.onInit();
    loadAd();
  }

  void loadAd() {
    nativeAd = NativeAd(
      adUnitId: adUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          isAdLoaded.value = true;
          print("Ad Loaded");
        },
        onAdFailedToLoad: (ad, error) {
          isAdLoaded.value = false;
          print("Failed to load an ad: $error");
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: kGrey.withOpacity(.15),
        cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.cyan,
          backgroundColor: Colors.red,
          style: NativeTemplateFontStyle.monospace,
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.red,
          backgroundColor: Colors.cyan,
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

  void closeAd() {
    nativeAd?.dispose();
    isAdLoaded.value = false;
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    isAdLoaded.value = false;
    super.dispose();
  }
}
