import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/util/etc/responsive.dart';
import 'package:textspeech/util/game%20property/game_option.dart';
import '../../util/etc/constants.dart';
import '../../util/game property/game_board_mobile.dart';

class MemoryGameHome extends StatefulWidget {
  const MemoryGameHome({super.key});

  @override
  State<MemoryGameHome> createState() => _MemoryGameHomeState();
}

class _MemoryGameHomeState extends State<MemoryGameHome> {
  int? activeIndex; // Menyimpan indeks tombol yang aktif

  static Route<dynamic> _routeBuilder(BuildContext context, int gameLevel) {
    return MaterialPageRoute(
      builder: (_) {
        return GameBoardMobile(gameLevel: gameLevel);
      },
    );
  }

  void _onLevelSelected(int? index) {
    setState(() {
      activeIndex = index;
    });
  }

  void _startGame() {
    if (activeIndex != null) {
      Navigator.of(context).pushAndRemoveUntil(
        _routeBuilder(context, gameLevels[activeIndex!]['level']),
        (Route<dynamic> route) => false,
      );
    } else {
      // Tampilkan pesan atau indikator bahwa level harus dipilih terlebih dahulu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a game level first.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isMobile(context)
          ? AppBar(
              backgroundColor: const Color(0xFFFEF8F2),
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () => Get.offNamed('/home'),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFFE9081),
                  )),
              title: Text(
                'Memory Game',
                style: Theme.of(context).textTheme.headlineMedium!.apply(
                      color: const Color(0xFFFE9081),
                    ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.firstline,
                      color: Color(0xFFFE9081),
                    ))
              ],
            )
          : AppBar(
              backgroundColor: const Color(0xFFFEF8F2),
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Get.offNamed('/home'),
                padding: const EdgeInsets.only(left: 24.0),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFFFE9081),
                ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubic),
              ),
              title: Text(
                'Memory Game',
                style: Theme.of(context).textTheme.headlineMedium!.apply(
                      color: const Color(0xFFFE9081),
                    ),
              ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic),
              centerTitle: true,
              actions: [
                IconButton(
                        padding: const EdgeInsets.only(right: 24.0),
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.firstline,
                          color: Color(0xFFFE9081),
                        ))
                    .animate(delay: const Duration(milliseconds: 250))
                    .fadeIn(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubic),
              ],
            ),
      body: isMobile(context)
          ? SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: const Color(0xFFFEF8F2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 24.0, right: 24.0, top: 10.0),
                          child: Text(
                            "In this game you'll be honing your memory in choosing the same card, the shorter the time it takes you to complete the chosen level, the better!",
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        GameOptions(
                          onLevelSelected: _onLevelSelected,
                        )
                            .animate(
                              delay: const Duration(milliseconds: 500),
                            )
                            .slideY(
                              begin: 5,
                              end: 0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.bounceInOut,
                            ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: Get.width,
                    height: 30,
                    color: const Color(0xFFDEE0F5),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -20.0,
                          left: (Get.width / 2) - 100,
                          child: GestureDetector(
                            onTap: _startGame,
                            child: Container(
                              height: 40,
                              width: 200,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFF2D396F),
                                    offset: Offset(2, 0),
                                  ),
                                  BoxShadow(
                                    color: Color(0xFF2D396F),
                                    offset: Offset(-2, 0),
                                  ),
                                  BoxShadow(
                                    color: Color(0xFF2D396F),
                                    offset: Offset(0, -2),
                                  ),
                                  BoxShadow(
                                    color: Color(0xFF2D396F),
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                color: const Color(0xFFFE9081),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Iconsax.backward,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Start Game',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .apply(color: Colors.white),
                                  ),
                                  const Icon(
                                    Iconsax.forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 270,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            )
          : SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: const Color(0xFFFEF8F2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 24.0, top: 20.0),
                          child: Text(
                            "In this game you'll be honing your memory in choosing the same card, the shorter the time it takes you to complete the chosen level, the better!",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.normal),
                          )
                              .animate(delay: const Duration(milliseconds: 250))
                              .fadeIn(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubic),
                        ),
                        const SizedBox(height: 16.0),
                        GameOptions(
                          onLevelSelected: _onLevelSelected,
                        )
                            .animate(
                              delay: const Duration(milliseconds: 500),
                            )
                            .slideY(
                              begin: 5,
                              end: 0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.bounceInOut,
                            ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: Get.width,
                    height: 30,
                    color: const Color(0xFFDEE0F5),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -30.0,
                          left: (Get.width / 2) - 200,
                          child: GestureDetector(
                            onTap: _startGame,
                            child: Container(
                              height: 70,
                              width: 400,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFF2D396F),
                                    offset: Offset(2, 0),
                                  ),
                                  BoxShadow(
                                    color: Color(0xFF2D396F),
                                    offset: Offset(-2, 0),
                                  ),
                                  BoxShadow(
                                    color: Color(0xFF2D396F),
                                    offset: Offset(0, -2),
                                  ),
                                  BoxShadow(
                                    color: Color(0xFF2D396F),
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                color: const Color(0xFFFE9081),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Iconsax.backward,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Start Game',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .apply(color: Colors.white),
                                  ),
                                  const Icon(
                                    Iconsax.forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )
                                .animate(
                                    delay: const Duration(milliseconds: 250))
                                .fadeIn(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOutCubic),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: Get.width * 0.6,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          )
                              .animate(delay: const Duration(milliseconds: 250))
                              .fadeIn(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubic),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
    );
  }
}
