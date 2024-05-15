import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/shimmer/shimmer.dart';

class CardSwiperShimmer extends StatefulWidget {
  const CardSwiperShimmer({super.key});

  @override
  State<CardSwiperShimmer> createState() => _CardSwiperShimmerState();
}

class _CardSwiperShimmerState extends State<CardSwiperShimmer> {
  final CardSwiperController controller = CardSwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      controller: controller,
      cardsCount: 6,
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
        return Container(
          width: double.infinity,
          height: Get.height,
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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0)),
                      child: DShimmerEffect(
                        width: double.infinity,
                        height: 0,
                      )),
                ),
              ),
              DShimmerEffect(width: double.infinity, height: 80)
            ],
          ),
        );
      },
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
