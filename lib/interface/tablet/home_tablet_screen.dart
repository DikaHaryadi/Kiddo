import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../auth/controller/auth_controller.dart';
import '../../auth/controller/user/user_controller.dart';
import '../../controllers/anchor_ads_controller.dart';
import '../../controllers/time_by_sun_position_controller.dart';
import '../../util/etc/app_colors.dart';
import '../../util/etc/constants.dart';
import '../../util/shimmer/shimmer.dart';

class HomeTabletScreen extends StatefulWidget {
  const HomeTabletScreen({super.key});

  @override
  State<HomeTabletScreen> createState() => _HomeTabletScreenState();
}

class _HomeTabletScreenState extends State<HomeTabletScreen> {
  final controller = Get.put(UserController());
  final timeSunPosition = Get.put(TimeSunPosition());
  final adsController = Get.put(AnchorAdsController());

  bool showAll = false;
  List<bool> longPressStates = List.generate(contentKiddo.length, (_) => false);
  int? selectedLongPressIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFFfaf5f1),
                margin: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                            width: double.infinity,
                            height: 200,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0)),
                                color: kStrongblue),
                            child: AnimationLimiter(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: AnimationConfiguration
                                        .toStaggeredList(
                                            delay: const Duration(
                                                milliseconds: 600),
                                            duration: const Duration(
                                                milliseconds: 500),
                                            childAnimationBuilder: (widget) =>
                                                SlideAnimation(
                                                  horizontalOffset:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2,
                                                  child: FadeInAnimation(
                                                      child: widget),
                                                ),
                                            children: [
                                          Image.asset(
                                            'assets/images/Logo_color1.png',
                                            width: 200,
                                          ),
                                          const SizedBox(height: 20),
                                          AutoSizeText(
                                            'Learning App\nFor Kids',
                                            maxFontSize: 20.0,
                                            minFontSize: 18.0,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ]))))
                        .animate(delay: const Duration(milliseconds: 200))
                        .slideY(
                            begin: -3,
                            end: 0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceIn),
                    Expanded(
                      child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.only(top: 20.0),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                              color: kSoftblue),
                          child: Column(
                            children: [
                              AnimationLimiter(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: navbarOpsion.length,
                                  itemBuilder: (context, index) {
                                    final navbar = navbarOpsion[index];
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      delay: const Duration(milliseconds: 250),
                                      duration:
                                          const Duration(milliseconds: 800),
                                      child: SlideAnimation(
                                        verticalOffset: 44.0,
                                        child: FadeInAnimation(
                                          child: ListTile(
                                            leading: Icon(navicon[index]),
                                            title: Text(
                                              navbar['title']!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.apply(color: kWhite),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 30.0),
                                ),
                              ),
                              Expanded(child: Container()),
                              AnimationConfiguration.staggeredGrid(
                                  position: 0,
                                  columnCount: 1,
                                  child: ListTile(
                                    onTap: () => AuthenticationRepository
                                        .instance
                                        .logOut(),
                                    leading: const Icon(Iconsax.logout),
                                    title: AutoSizeText(
                                      'LogOut',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.apply(color: kWhite),
                                    ),
                                  ))
                            ],
                          )),
                    ).animate(delay: const Duration(milliseconds: 200)).slideY(
                        begin: 3,
                        end: 0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.bounceIn),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                color: const Color(0xFFfaf5f1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Obx(() => AutoSizeText(
                              'Good ${timeSunPosition.timeOfDay.value}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall)).animate().fadeIn(
                              curve: Curves.easeIn,
                              duration: const Duration(milliseconds: 700)),
                          Expanded(child: Container()),
                          Obx(() => controller.profileLoading.value
                              ? const DShimmerEffect(width: 100, height: 20)
                              : Text(
                                  controller.user.value.username,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ))
                        ],
                      ).animate().slideX(
                          begin: 4,
                          end: 0,
                          curve: Curves.bounceIn,
                          duration: const Duration(milliseconds: 800)),
                    ),
                    const SizedBox(height: 10.0),
                    AnimationLimiter(
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 18 / 8,
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 20,
                        children: List.generate(
                            gameList.length,
                            (index) => AnimationConfiguration.staggeredGrid(
                                  columnCount: 2,
                                  position: index,
                                  delay: const Duration(milliseconds: 250),
                                  duration: const Duration(milliseconds: 500),
                                  child: ScaleAnimation(
                                    scale: 0.5,
                                    child: FadeInAnimation(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              gameList[index]['routePath']!);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Colors.white),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20.0)),
                                                    child: Image.asset(
                                                      gameList[index]
                                                          ['imagePath']!,
                                                      fit: BoxFit.fitHeight,
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 3,
                                                  child: AutoSizeText(
                                                      gameList[index]
                                                          ['GameName']!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall
                                                          ?.copyWith(
                                                              fontSize: 30.0)))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () => Get.toNamed('/kid-song'),
                      child: AnimationConfiguration.staggeredGrid(
                        duration: const Duration(milliseconds: 900),
                        position: 0,
                        columnCount: 1,
                        child: FadeInAnimation(
                          child: Container(
                            height: Get.height * 0.10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              border: Border.all(
                                  width: 2, color: const Color(0xFFd1d1d1)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(8.0),
                                    ),
                                    child: Image.asset(
                                      'assets/games/logo_musik.png',
                                      fit: BoxFit.fitHeight,
                                      height:
                                          MediaQuery.of(context).size.height,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Kid Song',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Subtitle kid song disini',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () => Get.toNamed('/kid-song'),
                      child: AnimationConfiguration.staggeredGrid(
                        duration: const Duration(milliseconds: 1100),
                        position: 0,
                        columnCount: 1,
                        child: FadeInAnimation(
                          child: Container(
                            height: Get.height * 0.10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              border: Border.all(
                                  width: 2, color: const Color(0xFFd1d1d1)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(8.0),
                                    ),
                                    child: Image.asset(
                                      'assets/games/nationalsong.png',
                                      fit: BoxFit.fitHeight,
                                      height:
                                          MediaQuery.of(context).size.height,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'National Anthem',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Subtitle kid song disini',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'Categories',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontFamily: 'Kiddosy'),
                          ).animate().fadeIn(
                              curve: Curves.easeIn,
                              duration: const Duration(milliseconds: 700)),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/show-all-content');
                            },
                            child: AutoSizeText(
                              'Show all',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .apply(color: kSoftblue),
                            ),
                          ).animate().slideX(
                              begin: 3,
                              end: 0,
                              curve: Curves.bounceIn,
                              duration: const Duration(milliseconds: 500)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Expanded(
                      child: AnimationLimiter(
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          childAspectRatio: 1.1,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: List.generate(
                              showAll ? contentKiddo.length : 4,
                              (index) => AnimationConfiguration.staggeredGrid(
                                    columnCount: 2,
                                    delay: const Duration(milliseconds: 250),
                                    position: index,
                                    duration: const Duration(milliseconds: 500),
                                    child: ScaleAnimation(
                                      scale: 0.5,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onLongPressStart: (_) {
                                            setState(() {
                                              longPressStates.fillRange(
                                                  0,
                                                  longPressStates.length,
                                                  false);
                                              longPressStates[index] = true;
                                            });
                                          },
                                          onLongPressEnd: (_) {
                                            setState(() {
                                              longPressStates[index] = false;
                                              selectedLongPressIndex = null;
                                            });
                                          },
                                          onTap: () {
                                            setState(() {
                                              longPressStates[index] =
                                                  !longPressStates[index];
                                              for (int i = 0;
                                                  i < longPressStates.length;
                                                  i++) {
                                                if (i != index) {
                                                  longPressStates[i] = false;
                                                }
                                              }
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: Colors.white),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          child: Image.asset(
                                                            contentKiddo[index]
                                                                ['imagePath']!,
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            height:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                          ),
                                                        ),
                                                      ),
                                                      longPressStates[index]
                                                          ? Positioned(
                                                              right: 0,
                                                              bottom: 0,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Get.offNamed(
                                                                      contentKiddo[
                                                                              index]
                                                                          [
                                                                          'routePath']!);
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 55,
                                                                  height: 55,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xFF1ed760),
                                                                    border: Border
                                                                        .fromBorderSide(
                                                                            BorderSide(
                                                                      color: Color(
                                                                          0xFF1db954),
                                                                      strokeAlign:
                                                                          1,
                                                                      width: 1,
                                                                    )),
                                                                  ),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .play_arrow,
                                                                    color: Color(
                                                                        0xFF191414),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AutoSizeText(
                                                              contentKiddo[
                                                                      index]
                                                                  ['name']!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                            AutoSizeText(
                                                              contentKiddo[
                                                                      index]
                                                                  ['subtitle']!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                    ),
                    adsController.getAdWidget()
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
