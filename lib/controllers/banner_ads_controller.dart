import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdsController extends GetxController {
  final inlineAdaptiveAd = Rx<AdManagerBannerAd?>(null);
  final adSize = Rx<AdSize?>(null);
  final isAdsLoaded = RxBool(false);

  double get _adWidth => Get.width;

  @override
  void onInit() {
    loadBannerAds();
    super.onInit();
  }

  Future<void> loadBannerAds() async {
    await inlineAdaptiveAd.value?.dispose();
    inlineAdaptiveAd.value = null;
    isAdsLoaded.value = false;

    // Get an inline adaptive size based on the available width.
    AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
        _adWidth.truncate());

    inlineAdaptiveAd.value = AdManagerBannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      sizes: [size],
      request: const AdManagerAdRequest(),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) async {
          print('Inline adaptive banner loaded: ${ad.responseInfo}');

          AdManagerBannerAd bannerAd = (ad as AdManagerBannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            print('Error: getPlatformAdSize() returned null for $bannerAd');
            return;
          }

          inlineAdaptiveAd.value = bannerAd;
          isAdsLoaded.value = true;
          adSize.value = size;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    await inlineAdaptiveAd.value!.load();
  }

  getAdWidget() {
    if (inlineAdaptiveAd.value != null &&
        isAdsLoaded.value &&
        adSize.value != null) {
      return Container(
        padding: const EdgeInsets.only(top: 30.0),
        width: _adWidth,
        height: adSize.value!.height.toDouble(),
        child: AdWidget(ad: inlineAdaptiveAd.value!),
      );
    }
    return const SizedBox.shrink();
  }
}
