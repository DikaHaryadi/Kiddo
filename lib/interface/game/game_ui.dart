import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/util/etc/app_colors.dart';
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
        SnackBar(
            content:
                Text('Silakan pilih level permainan terlebih dahulu...'.tr)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isMobile(context)
          ? Container(
              padding: const EdgeInsets.only(top: 32),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/games/bg_memory_game.png'),
                      fit: BoxFit.fill)),
              child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: InkWell(
                          onTap: () => Get.offNamed('/home'),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFFFE9081),
                          )
                              .animate(delay: const Duration(milliseconds: 250))
                              .fadeIn(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubic),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 10.0),
                        child: Text(
                          "Dalam game ini Anda akan mengasah ingatan Anda dalam memilih kartu yang sama, semakin pendek waktu yang Anda butuhkan untuk menyelesaikan level yang dipilih, semakin baik!"
                              .tr,
                        )
                            .animate(delay: const Duration(milliseconds: 250))
                            .fadeIn(
                                duration: const Duration(milliseconds: 800)),
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
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: _startGame,
                          child: Container(
                            width: 270,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border:
                                  Border.all(color: kBlack.withOpacity(0.13)),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.7),
                                  Colors.white.withOpacity(0.5),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Iconsax.backward,
                                  size: 30,
                                  color: kWhite,
                                ),
                                const SizedBox(width: 25.0),
                                Text(
                                  'Mulai Permainan'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.apply(color: kWhite),
                                ),
                                const SizedBox(width: 25.0),
                                const Icon(
                                  Iconsax.forward,
                                  size: 30,
                                  color: kWhite,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            )
          : SizedBox(
              width: Get.width,
              height: Get.height,
              child: Container(
                padding: const EdgeInsets.only(top: 32),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/games/bg_memory_game.png'),
                        fit: BoxFit.fill)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Get.offNamed('/home'),
                      child: Container(
                              margin: const EdgeInsets.only(left: 24.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.7),
                                    Colors.white.withOpacity(0.5),
                                  ],
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xFFFE9081),
                                size: 30,
                              ))
                          .animate(delay: const Duration(milliseconds: 250))
                          .fadeIn(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutCubic),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 20.0),
                      child: Text(
                        "Dalam game ini Anda akan mengasah ingatan Anda dalam memilih kartu yang sama, semakin pendek waktu yang Anda butuhkan untuk menyelesaikan level yang dipilih, semakin baik!"
                            .tr,
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
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: _startGame,
                        child: Container(
                          width: Get.width * .5,
                          height: 80,
                          margin: const EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.13)),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.7),
                                Colors.white.withOpacity(0.5),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Iconsax.backward,
                                size: 40,
                              ),
                              const SizedBox(width: 25.0),
                              Text(
                                'Mulai Permainan'.tr,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(width: 25.0),
                              const Icon(
                                Iconsax.forward,
                                size: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
