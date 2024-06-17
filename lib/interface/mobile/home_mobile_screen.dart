import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/language_controller.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/curved_edges.dart';
import 'package:textspeech/util/etc/dep_lang.dart';

import '../../auth/controller/user/user_controller.dart';
import '../../controllers/anchor_ads_controller.dart';
import '../../controllers/time_by_sun_position_controller.dart';
import '../../util/etc/constants.dart';
import '../../util/shimmer/shimmer.dart';
import '../user/edit_profile.dart';

class HomeMobileScreem extends StatefulWidget {
  const HomeMobileScreem({super.key});

  @override
  State<HomeMobileScreem> createState() => _HomeMobileScreemState();
}

class _HomeMobileScreemState extends State<HomeMobileScreem> {
  bool showAll = false;

  final controller = Get.put(UserController());
  final timeSunPosition = Get.put(TimeSunPosition());
  final adsController = Get.put(AnchorAdsController());

  final List<String> items = [
    'assets/images/indonesia.png',
    'assets/images/english.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          ListView(
            children: [
              ClipPath(
                clipper: HomeMobileCurvedEdges(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.8,
                  color: kSoftblue,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 140,
                          height: 40,
                          child: DropdownButtonHideUnderline(
                            child: GetBuilder<LocalizationController>(
                              builder: (controller) {
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  value: items[controller.selectedIndex],
                                  onChanged: (String? value) {
                                    int index = items.indexOf(value!);
                                    controller.setLanguage(Locale(
                                        AppLanguageConstant
                                            .languages[index].languageCode,
                                        AppLanguageConstant
                                            .languages[index].countryCode));
                                    controller.setSelectIndex(index);
                                  },
                                  icon: const Icon(Icons.arrow_drop_down),
                                  selectedItemBuilder: (BuildContext context) {
                                    return items.map<Widget>((String item) {
                                      return Row(
                                        children: [
                                          Image.asset(
                                            item,
                                            width: 24,
                                            height: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(item == items[0]
                                              ? 'Indonesia'
                                              : 'English'),
                                        ],
                                      );
                                    }).toList();
                                  },
                                  items: items.map<DropdownMenuItem<String>>(
                                      (String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            item,
                                            width: 24,
                                            height: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(item == items[0]
                                              ? 'Indonesia'
                                              : 'English'),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * .1,
                          right: Get.width * .1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => AutoSizeText(
                                    'Selamat ${timeSunPosition.timeOfDay.value}'
                                        .tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.apply(color: kWhite),
                                  ),
                                ).animate().slideX(
                                    begin: -4,
                                    end: 0,
                                    curve: Curves.bounceIn,
                                    duration:
                                        const Duration(milliseconds: 400)),
                                Obx(() => controller.profileLoading.value
                                    ? const DShimmerEffect(
                                        width: 100, height: 20)
                                    : AutoSizeText(
                                        controller.user.value.username,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.apply(color: kWhite),
                                      )).animate().slideX(
                                    begin: -4,
                                    end: 0,
                                    curve: Curves.bounceIn,
                                    duration:
                                        const Duration(milliseconds: 400)),
                              ],
                            ),
                            Obx(() {
                              final networkImage =
                                  controller.user.value.profilePicture;
                              final image = networkImage.isNotEmpty
                                  ? networkImage
                                  : 'assets/images/cat.png';
                              return CircularImage(
                                image: image,
                                widht: 50,
                                height: 50,
                                isNetworkImage: networkImage.isNotEmpty,
                                onTap: () => Get.toNamed('/profile'),
                              );
                            }).animate().slideX(
                                begin: 4,
                                end: 0,
                                curve: Curves.bounceIn,
                                duration: const Duration(milliseconds: 400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      AnimationLimiter(
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 18 / 8,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 500),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              horizontalOffset:
                                  MediaQuery.of(context).size.width,
                              child: widget,
                            ),
                            children: gameList.map((game) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(game['routePath']!);
                                },
                                child: Image.asset(
                                  game['imagePath']!,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      GestureDetector(
                        onTap: () => Get.toNamed('/kid-song'),
                        child: AnimationConfiguration.staggeredGrid(
                          duration: const Duration(milliseconds: 900),
                          position: 0,
                          columnCount: 1,
                          child: FadeInAnimation(
                            child: Container(
                              height: Get.height * 0.12,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: const Color(0xFFd1d1d1)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/games/logo_musik.png',
                                    fit: BoxFit.fitHeight,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                                  Text(
                                    'Lagu Anak'.tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                            fontFamily: 'Kiddosy',
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () => Get.toNamed('/lagu-nasional'),
                        child: AnimationConfiguration.staggeredGrid(
                          duration: const Duration(milliseconds: 900),
                          position: 0,
                          columnCount: 1,
                          child: FadeInAnimation(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              height: Get.height * 0.12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: const Color(0xFFd1d1d1)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    height: 100,
                                    'assets/games/nationalsong.png',
                                  ),
                                  Text(
                                    'Lagu Nasional'.tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                            fontFamily: 'Kiddosy',
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: AnimationLimiter(
                    child: GridView.builder(
                  itemCount: contentKiddo.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (_, index) {
                    final content = contentKiddo[index];

                    return AnimationConfiguration.staggeredGrid(
                      columnCount: 2,
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: ScaleAnimation(
                        scale: 0.5,
                        child: FadeInAnimation(
                          child: OpenContainer(
                            closedColor: const Color(0xFFfcf4f1),
                            closedElevation: 0,
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            transitionType: ContainerTransitionType.fade,
                            closedShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            openBuilder: (context, action) {
                              return openContent[index];
                            },
                            closedBuilder: (context, action) {
                              return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(content['routePath']!);
                                  },
                                  child: Image.asset(
                                    width: double.infinity,
                                    content['imagePath']!,
                                  ));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: adsController.getAdWidget())
        ],
      ),
    );
  }
}
