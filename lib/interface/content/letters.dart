import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:textspeech/controllers/letter_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/util/card_letter.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/responsive.dart';

import '../../controllers/tts_controller.dart';
import '../../util/shimmer/card_swiper_shimmer.dart';

class LettersContent extends StatefulWidget {
  const LettersContent({
    super.key,
  });

  @override
  State<LettersContent> createState() => _LettersContentState();
}

class _LettersContentState extends State<LettersContent> {
  int selectedIndex = 0;

  static const _insets = 16.0;
  AdManagerBannerAd? _inlineAdaptiveAd;
  bool _isLoaded = false;
  AdSize? _adSize;

  double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);

  void _loadAd() async {
    await _inlineAdaptiveAd?.dispose();
    setState(() {
      _inlineAdaptiveAd = null;
      _isLoaded = false;
    });

    AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
        _adWidth.truncate());

    _inlineAdaptiveAd = AdManagerBannerAd(
      adUnitId: 'ca-app-pub-3048736622280674/6380402407',
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

          setState(() {
            _inlineAdaptiveAd = bannerAd;
            _isLoaded = true;
            _adSize = size;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    await _inlineAdaptiveAd!.load();
  }

  Widget _getAdWidget() {
    if (_inlineAdaptiveAd != null && _isLoaded && _adSize != null) {
      return Container(
        padding: const EdgeInsets.only(top: 30.0),
        width: _adWidth,
        height: _adSize!.height.toDouble(),
        child: AdWidget(ad: _inlineAdaptiveAd!),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  void initState() {
    _loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final letterController = Get.put(LetterController());
    final ttsController = Get.put(TtsController());
    String subImage = lettersList[selectedIndex]['subImage']!;
    String name = lettersList[selectedIndex]['name']!;
    return Scaffold(
        appBar: isMobile(context)
            ? AppBar(
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 250), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    });
                  },
                  icon: const Icon(Icons.arrow_back_ios)
                      .animate(delay: const Duration(milliseconds: 250))
                      .slideX(
                          begin: 2,
                          end: 0,
                          duration: const Duration(milliseconds: 300)),
                ),
                title: Text(
                  'Huruf Hijaiyah',
                  style: GoogleFonts.montserratAlternates(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ).animate(delay: const Duration(milliseconds: 250)).slideX(
                    begin: 1,
                    end: 0,
                    duration: const Duration(milliseconds: 400)),
                centerTitle: true,
              )
            : null,
        body: SafeArea(
            child: isMobile(context)
                ? Column(
                    children: [
                      Flexible(
                        child: Obx(() => letterController.isLoadingLetter.value
                            ? const CardSwiperShimmer()
                            : CardLetterContent(controller: letterController)),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            color: const Color(0xFFfcf4f1),
                            padding: const EdgeInsets.only(
                                top: 50.0, left: 35.0, right: 40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                        onPressed: () => Get.offNamed('/home'),
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          size: 50,
                                        ))
                                    .animate()
                                    .slideX(
                                        begin: -2,
                                        end: 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: AutoSizeText(
                                    'Hijaiyah',
                                    maxFontSize: 50,
                                    minFontSize: 45,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).animate().slideX(
                                      begin: -2,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.easeIn),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: AutoSizeText(
                                    'Today, we will learn about the hijaiyah letters.',
                                    maxFontSize: 40,
                                    minFontSize: 35,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade400,
                                    ),
                                  ).animate().slideX(
                                      begin: -2,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.easeIn),
                                ),
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: InkWell(
                                    onTap: () {
                                      ttsController.textToSpeech(name);
                                    },
                                    child: Image.asset(
                                      subImage,
                                      width: double.infinity,
                                      height: 400,
                                    ).animate().fadeIn(
                                        duration:
                                            const Duration(milliseconds: 2000),
                                        curve: Curves.easeIn),
                                  ),
                                )),
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: AutoSizeText(
                                    name,
                                    maxFontSize: 40,
                                    minFontSize: 35,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).animate().fadeIn(
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      curve: Curves.easeIn),
                                )),
                                _getAdWidget(),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    'click on the image to reveal the sound',
                                    maxFontSize: 25,
                                    minFontSize: 22,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold),
                                  ).animate().slideY(
                                      begin: 1,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 1100),
                                      curve: Curves.bounceInOut),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(top: 20.0),
                            child: AnimationLimiter(
                              child: GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 35,
                                childAspectRatio:
                                    MediaQuery.of(context).size.aspectRatio,
                                children:
                                    List.generate(lettersList.length, (index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    columnCount: 2,
                                    position: index,
                                    delay: const Duration(milliseconds: 200),
                                    duration: const Duration(milliseconds: 800),
                                    child: ScaleAnimation(
                                      scale: 0.5,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedIndex = index;
                                              });
                                            },
                                            child: Image.asset(
                                              lettersList[index]['imagePath']!,
                                            )),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )),
                    ],
                  )));
  }
}
