import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/controllers/number_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/models/number_model.dart';

class CardNumberContent extends StatefulWidget {
  final NumberController controller;
  final NumberModel model;

  const CardNumberContent({
    Key? key,
    required this.controller,
    required this.model,
  }) : super(key: key);

  @override
  State<CardNumberContent> createState() => _CardNumberContentState();
}

class _CardNumberContentState extends State<CardNumberContent> {
  final CardSwiperController controllerCard = CardSwiperController();
  final TtsController ttsController = Get.put(TtsController());
  int currentIndex = 0;

  @override
  void dispose() {
    controllerCard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: AnimationLimiter(
            child: CardSwiper(
              controller: controllerCard,
              cardsCount: widget.controller.numberModels.length,
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
                final numData = widget.controller.numberModels[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 1000),
                  child: SlideAnimation(
                    verticalOffset: 100.0,
                    child: FadeInAnimation(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.red,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0)),
                                  child: CachedNetworkImage(
                                    imageUrl: numData.imagePath,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => Container(
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/images/Logo_color1.png'),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0, -2),
                                        blurRadius: .5,
                                        spreadRadius: 1,
                                        blurStyle: BlurStyle.outer)
                                  ],
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16.0),
                                      bottomRight: Radius.circular(16.0))),
                              child: Row(
                                children: [
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: CachedNetworkImage(
                                      imageUrl: numData.imagePath,
                                      width: 60,
                                      height: 60,
                                      placeholder: (context, url) => Container(
                                        alignment: Alignment.center,
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              'assets/images/Logo_color1.png'),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: AutoSizeText(
                                      numData.name,
                                      maxFontSize: 20,
                                      minFontSize: 18,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => ttsController.textToSpeech(
                                        numData.speech, "en-US"),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      margin:
                                          const EdgeInsets.only(right: 15.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          border: const Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.orange,
                                                  strokeAlign: 1,
                                                  width: 1))),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimationLimiter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 800),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: MediaQuery.of(context).size.width / 2,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  InkWell(
                    onTap: () => controllerCard.undo(),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.orange, // ganti dengan kPrimary jika ada
                      ),
                      child: const Icon(
                        Icons.rotate_left,
                        color: Colors.white, // ganti dengan kWhite jika ada
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  InkWell(
                    onTap: () => ttsController.textToSpeech(
                        widget.controller.numberModels[currentIndex].speech,
                        'ar'),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/icon/arabic.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  InkWell(
                    onTap: () => ttsController.textToSpeech(
                        widget.controller.numberModels[currentIndex].speech,
                        'en-US'),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/icon/english.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? newIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $newIndex is on top',
    );

    setState(() {
      if (newIndex != null) {
        currentIndex = newIndex;
      }
    });

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

    setState(() {
      if (previousIndex != null) {
        currentIndex = previousIndex;
      }
    });

    return true;
  }
}
