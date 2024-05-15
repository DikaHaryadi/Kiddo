import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/controllers/number_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/util/shimmer/card_swiper_shimmer.dart';

class CardNumberContent extends StatefulWidget {
  final NumberController controller;

  const CardNumberContent({
    super.key,
    required this.controller,
  });

  @override
  State<CardNumberContent> createState() => _CardNumberContentState();
}

class _CardNumberContentState extends State<CardNumberContent> {
  final CardSwiperController controllerCard = CardSwiperController();
  final ttsController = Get.put(TtsController());

  @override
  void dispose() {
    controllerCard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => widget.controller.isLoadingNumber.value
            ? const CardSwiperShimmer()
            : Flexible(
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
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0)),
                                          child: Image.network(
                                            numData.imagePath,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
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
                                              bottomRight:
                                                  Radius.circular(16.0))),
                                      child: Row(
                                        children: [
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Image.network(
                                              numData.imagePath,
                                              width: 60,
                                              height: 60,
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
                                            onTap: () => ttsController
                                                .textToSpeech(numData.name),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              margin: const EdgeInsets.only(
                                                  right: 15.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  border: const Border
                                                      .fromBorderSide(
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
                      }),
                ),
              )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimationLimiter(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: AnimationConfiguration.toStaggeredList(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 800),
                    childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: MediaQuery.of(context).size.width / 2,
                        child: FadeInAnimation(
                          child: widget,
                        )),
                    children: [
                      FloatingActionButton(
                        heroTag: 'undo_button',
                        onPressed: controllerCard.undo,
                        child: const Icon(Icons.rotate_left),
                      ),
                      FloatingActionButton(
                        heroTag: 'swipe_left_button',
                        onPressed: () =>
                            controllerCard.swipe(CardSwiperDirection.left),
                        child: const Icon(Icons.keyboard_arrow_left),
                      ),
                      FloatingActionButton(
                        heroTag: 'swipe_right_button',
                        onPressed: () =>
                            controllerCard.swipe(CardSwiperDirection.right),
                        child: const Icon(Icons.keyboard_arrow_right),
                      ),
                      FloatingActionButton(
                        heroTag: 'swipe_top_button',
                        onPressed: () =>
                            controllerCard.swipe(CardSwiperDirection.top),
                        child: const Icon(Icons.keyboard_arrow_up),
                      ),
                      FloatingActionButton(
                        heroTag: 'swipe_bottom_button',
                        onPressed: () =>
                            controllerCard.swipe(CardSwiperDirection.bottom),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ])),
          ),
        ),
      ],
    );
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
