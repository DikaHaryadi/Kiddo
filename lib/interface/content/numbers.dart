import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/util/card.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/responsive.dart';

class NumberContent extends StatefulWidget {
  const NumberContent({
    super.key,
  });

  @override
  State<NumberContent> createState() => _NumberContentState();
}

class _NumberContentState extends State<NumberContent> {
  final CardSwiperController controller = CardSwiperController();
  FlutterTts flutterTts = FlutterTts();

  int selectedIndex = 0;

  void textToSpeech(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

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

    // Get an inline adaptive size based on the available width.
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String counterPath = numsList[selectedIndex]['counterPath']!;
    String name = numsList[selectedIndex]['name']!;
    String title = numsList[selectedIndex]['title']!;
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
                  'Bilangan Angka',
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
                        child: CardSwiper(
                          controller: controller,
                          cardsCount: numsList.length,
                          onSwipe: _onSwipe,
                          onUndo: _onUndo,
                          numberOfCardsDisplayed: 3,
                          backCardOffset: const Offset(40, 40),
                          padding: const EdgeInsets.all(24.0),
                          cardBuilder: (
                            context,
                            index,
                            horizontalThresholdPercentage,
                            verticalThresholdPercentage,
                          ) {
                            final numData = numsList[index];
                            return CardContent(
                              imagePath: numData['imagePath']!,
                              counterPath: numData['counterPath']!,
                              name: numData['title']!,
                              onTap: () {
                                textToSpeech(numData['name']!);
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              heroTag: 'undo_button',
                              onPressed: controller.undo,
                              child: const Icon(Icons.rotate_left),
                            ),
                            FloatingActionButton(
                              heroTag: 'swipe_left_button',
                              onPressed: () =>
                                  controller.swipe(CardSwiperDirection.left),
                              child: const Icon(Icons.keyboard_arrow_left),
                            ),
                            FloatingActionButton(
                              heroTag: 'swipe_right_button',
                              onPressed: () =>
                                  controller.swipe(CardSwiperDirection.right),
                              child: const Icon(Icons.keyboard_arrow_right),
                            ),
                            FloatingActionButton(
                              heroTag: 'swipe_top_button',
                              onPressed: () =>
                                  controller.swipe(CardSwiperDirection.top),
                              child: const Icon(Icons.keyboard_arrow_up),
                            ),
                            FloatingActionButton(
                              heroTag: 'swipe_bottom_button',
                              onPressed: () =>
                                  controller.swipe(CardSwiperDirection.bottom),
                              child: const Icon(Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
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
                                        onPressed: () => Get.back(),
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
                                  child: Text(
                                    'Numbers',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50),
                                  ).animate().slideX(
                                      begin: -2,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.easeIn),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Today, we will learn about numbers with great enthusiasm',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade400,
                                        fontSize: 40),
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
                                      textToSpeech(name);
                                    },
                                    child: Image.asset(counterPath)
                                        .animate()
                                        .fadeIn(
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            curve: Curves.easeIn),
                                  ),
                                )),
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Text(
                                    title,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40),
                                  ).animate().fadeIn(
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      curve: Curves.easeIn),
                                )),
                                _getAdWidget(),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'click on the image to reveal the sound',
                                    style: GoogleFonts.roboto(
                                        fontSize: 25,
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
                            child: GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 35,
                              childAspectRatio:
                                  MediaQuery.of(context).size.aspectRatio,
                              children: List.generate(numsList.length, (index) {
                                int durationMilliseconds = 500 + (index * 50);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Image.asset(
                                    numsList[index]['imagePath']!,
                                  ).animate().slideX(
                                      begin: 2,
                                      end: 0,
                                      duration: Duration(
                                          milliseconds: durationMilliseconds),
                                      curve: Curves.bounceInOut),
                                );
                              }),
                            ),
                          )),
                    ],
                  )));
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
