import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AnchorAdsController extends GetxController {
  final anchoredAdaptiveAd = Rx<BannerAd?>(null);
  final isAdsLoaded = RxBool(false);

  @override
  void onInit() {
    loadAd();
    super.onInit();
  }

  Future<void> loadAd() async {
    await anchoredAdaptiveAd.value?.dispose();
    anchoredAdaptiveAd.value = null;
    isAdsLoaded.value = false;

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(Get.context!).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    anchoredAdaptiveAd.value = BannerAd(
      adUnitId: 'ca-app-pub-3048736622280674/6380402407',
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          anchoredAdaptiveAd.value = ad as BannerAd?;
          isAdsLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return anchoredAdaptiveAd.value!.load();
  }

  Widget getAdWidget() {
    if (anchoredAdaptiveAd.value != null && isAdsLoaded.value) {
      return Container(
        color: Colors.white,
        width: anchoredAdaptiveAd.value!.size.width.toDouble(),
        height: anchoredAdaptiveAd.value!.size.height.toDouble(),
        child: AdWidget(ad: anchoredAdaptiveAd.value!),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void onClose() {
    anchoredAdaptiveAd.value?.dispose();
    super.onClose();
  }
}
