import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/controller/user/user_controller.dart';
import '../../controllers/anchor_ads_controller.dart';
import '../../controllers/time_by_sun_position_controller.dart';
import '../../util/etc/app_colors.dart';
import '../../util/etc/category_list_mobile.dart';
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
  CategoryListNotifier categoryListNotifier = CategoryListNotifier();

  final controller = Get.put(UserController());
  final timeSunPosition = Get.put(TimeSunPosition());
  final adsController = Get.put(AnchorAdsController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => AutoSizeText(
                        'Good ${timeSunPosition.timeOfDay.value}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ).animate().slideX(
                        begin: -4,
                        end: 0,
                        curve: Curves.bounceIn,
                        duration: const Duration(milliseconds: 400)),
                    Obx(() => controller.profileLoading.value
                        ? const DShimmerEffect(width: 100, height: 20)
                        : AutoSizeText(
                            controller.user.value.username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium,
                          )).animate().slideX(
                        begin: -4,
                        end: 0,
                        curve: Curves.bounceIn,
                        duration: const Duration(milliseconds: 400)),
                  ],
                ),
                Obx(() {
                  final networkImage = controller.user.value.profilePicture;
                  final image = networkImage.isNotEmpty
                      ? networkImage
                      : 'assets/images/cat.png';
                  return CircularImage(
                    image: image,
                    widht: 65,
                    height: 65,
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
            const SizedBox(height: 15.0),
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
                    horizontalOffset: MediaQuery.of(context).size.width,
                    child: widget,
                  ),
                  children: gameList.map((game) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(game['routePath']!);
                      },
                      child: Container(
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
                                  game['imagePath']!,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        game['GameName']!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        game['subtitle']!,
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
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            ValueListenableBuilder<int?>(
              valueListenable: categoryListNotifier.selectedTab,
              builder: (context, selectedIndex, child) {
                final gameList = categoryListNotifier.categoryList;
                final displayCount = showAll ? gameList.length : 2;

                // Inisialisasi selectedIndex dengan nilai default dari selectedTab
                selectedIndex ??= categoryListNotifier.selectedTab.value;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...gameList
                          .asMap()
                          .entries
                          .take(displayCount)
                          .map((entry) {
                        final int index = entry.key;
                        final Map<String, String> game = entry.value;

                        final bool isSelected = selectedIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color:
                                    isSelected ? Colors.black45 : Colors.white,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              categoryListNotifier.selectTab(index);
                            },
                            icon: const CircleAvatar(
                              minRadius: 10,
                              maxRadius: 15,
                              backgroundColor: Colors.pink,
                            ),
                            label: AutoSizeText(
                              game['enum']!,
                              maxFontSize: 14,
                              minFontSize: 12,
                              style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.w600,
                                color: kDark,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      if (!showAll && gameList.length > 2)
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                showAll = true;
                              });
                            },
                            icon: const CircleAvatar(
                              minRadius: 10,
                              maxRadius: 15,
                              backgroundColor: Colors.pink,
                            ),
                            label: Text(
                              "Show All",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ), // Ganti teks sesuai kebutuhan
                          ),
                        ),
                      if (showAll)
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                showAll = false;
                              });
                            },
                            icon: const CircleAvatar(
                              minRadius: 10,
                              maxRadius: 15,
                              backgroundColor: Colors.pink,
                            ),
                            label: Text(
                              "Show Less",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ), // Ganti teks sesuai kebutuhan
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10.0),
            AnimationLimiter(
              child: ValueListenableBuilder<int?>(
                valueListenable: categoryListNotifier.selectedTab,
                builder: (context, value, child) {
                  final gameList = categoryListNotifier.categoryList;
                  if (value != null && value >= 0 && value < gameList.length) {
                    final selectedEnum = gameList[value]['enum'];
                    List<Map<String, String>> filteredContent;

                    if (selectedEnum == 'All') {
                      filteredContent = contentKiddo;
                    } else {
                      filteredContent = contentKiddo
                          .where((item) => item['enum'] == selectedEnum)
                          .toList();
                    }

                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: List.generate(filteredContent.length, (index) {
                        final content = filteredContent[index];
                        return AnimationConfiguration.staggeredGrid(
                          columnCount: 2,
                          position: index,
                          duration: const Duration(milliseconds: 800),
                          child: ScaleAnimation(
                            scale: 0.5,
                            child: FadeInAnimation(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 2,
                                    color: const Color(0xFFd1d1d1),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: OpenContainer(
                                        closedColor: const Color(0xFFfcf4f1),
                                        closedElevation: 0,
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        transitionType:
                                            ContainerTransitionType.fade,
                                        closedShape:
                                            const RoundedRectangleBorder(
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
                                              Get.toNamed(
                                                  content['routePath']!);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      content['imagePath']!),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    AutoSizeText('${content['name']}',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
        Positioned(
            bottom: 0, left: 10, right: 10, child: adsController.getAdWidget())
      ],
    );
  }
}
