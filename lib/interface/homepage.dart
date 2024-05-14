import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:textspeech/auth/controller/network_manager.dart';
import 'package:textspeech/auth/controller/user_controller.dart';
import 'package:textspeech/controllers/anchor_ads_controller.dart';
import 'package:textspeech/controllers/time_by_sun_position_controller.dart';
import 'package:textspeech/interface/edit_profile.dart';
import 'package:textspeech/util/category_list_mobile.dart';
import 'package:textspeech/util/app_colors.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/responsive.dart';
import 'package:textspeech/util/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showAll = false;
  List<bool> longPressStates = List.generate(contentKiddo.length, (_) => false);
  int? selectedLongPressIndex;

  CategoryListNotifier categoryListNotifier = CategoryListNotifier();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final timeSunPosition = Get.put(TimeSunPosition());
    final adsController = Get.put(AnchorAdsController());
    return Scaffold(
      backgroundColor: const Color(0xFFfcf4f1),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: SafeArea(
          child: isMobile(context)
              ? Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ).animate().slideX(
                                    begin: -4,
                                    end: 0,
                                    curve: Curves.bounceIn,
                                    duration:
                                        const Duration(milliseconds: 400)),
                                Obx(() => AutoSizeText(
                                          controller.user.value.username,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ))
                                    .animate()
                                    .slideX(
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
                              return controller.imageUploading.value
                                  ? const DShimmerEffect(
                                      width: 80, height: 80, radius: 80)
                                  : CircularImage(
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
                                horizontalOffset:
                                    MediaQuery.of(context).size.width,
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
                                          width: 2,
                                          color: const Color(0xFFd1d1d1)),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              bottomLeft: Radius.circular(8.0),
                                            ),
                                            child: Image.asset(
                                              game['imagePath']!,
                                              fit: BoxFit.fitHeight,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    game['GameName']!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                            selectedIndex ??=
                                categoryListNotifier.selectedTab.value;

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
                                    final Map<String, String> game =
                                        entry.value;

                                    final bool isSelected =
                                        selectedIndex == index;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          backgroundColor: Colors.white,
                                          side: BorderSide(
                                            color: isSelected
                                                ? Colors.black45
                                                : Colors.white,
                                            width: 2,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          backgroundColor: Colors.white,
                                          side: const BorderSide(
                                              color: Colors.white),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ), // Ganti teks sesuai kebutuhan
                                      ),
                                    ),
                                  if (showAll)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          backgroundColor: Colors.white,
                                          side: const BorderSide(
                                              color: Colors.white),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ), // Ganti teks sesuai kebutuhan
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                        // const CategoriesDisplay(),
                        AnimationLimiter(
                          child: ValueListenableBuilder<int?>(
                            valueListenable: categoryListNotifier.selectedTab,
                            builder: (context, value, child) {
                              final gameList =
                                  categoryListNotifier.categoryList;
                              if (value != null &&
                                  value >= 0 &&
                                  value < gameList.length) {
                                final selectedEnum = gameList[value]['enum'];
                                List<Map<String, String>> filteredContent;

                                if (selectedEnum == 'All') {
                                  filteredContent = contentKiddo;
                                } else {
                                  filteredContent = contentKiddo
                                      .where((item) =>
                                          item['enum'] == selectedEnum)
                                      .toList();
                                }

                                return GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  children: List.generate(
                                      filteredContent.length, (index) {
                                    final content = filteredContent[index];
                                    return AnimationConfiguration.staggeredGrid(
                                      columnCount: 2,
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 800),
                                      child: ScaleAnimation(
                                        scale: 0.5,
                                        child: FadeInAnimation(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                                    closedColor:
                                                        const Color(0xFFfcf4f1),
                                                    closedElevation: 0,
                                                    transitionDuration:
                                                        const Duration(
                                                            milliseconds: 500),
                                                    transitionType:
                                                        ContainerTransitionType
                                                            .fade,
                                                    closedShape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(8.0),
                                                      ),
                                                    ),
                                                    openBuilder:
                                                        (context, action) {
                                                      return openContent[index];
                                                    },
                                                    closedBuilder:
                                                        (context, action) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(content[
                                                              'routePath']!);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  content[
                                                                      'imagePath']!),
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                AutoSizeText(
                                                    '${content['name']}',
                                                    textAlign: TextAlign.center,
                                                    // maxFontSize: 16,
                                                    // minFontSize: 14,
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
                        bottom: 0,
                        left: 10,
                        right: 10,
                        child: adsController.getAdWidget())
                  ],
                )
              : SizedBox(
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
                                            borderRadius:
                                                BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15.0),
                                                    bottomRight:
                                                        Radius.circular(15.0)),
                                            color: kStrongblue),
                                        child: AnimationLimiter(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: AnimationConfiguration
                                                    .toStaggeredList(
                                                        delay: const Duration(
                                                            milliseconds: 600),
                                                        duration: const Duration(
                                                            milliseconds: 500),
                                                        childAnimationBuilder:
                                                            (widget) =>
                                                                SlideAnimation(
                                                                  horizontalOffset:
                                                                      MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2,
                                                                  child: FadeInAnimation(
                                                                      child:
                                                                          widget),
                                                                ),
                                                        children: [
                                                      Image.asset(
                                                        'assets/images/Logo_color1.png',
                                                        width: 200,
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      AutoSizeText(
                                                        'Learning App\nFor Kids',
                                                        maxFontSize: 20.0,
                                                        minFontSize: 18.0,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                      )
                                                    ]))))
                                    .animate(
                                        delay:
                                            const Duration(milliseconds: 200))
                                    .slideY(
                                        begin: -3,
                                        end: 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.bounceIn),
                                Expanded(
                                  child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(top: 20.0),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.0),
                                              topRight: Radius.circular(15.0)),
                                          color: kSoftblue),
                                      child: AnimationLimiter(
                                        child: Wrap(
                                          children: List.generate(
                                              navbarOpsion.length,
                                              (index) => AnimationConfiguration
                                                      .staggeredList(
                                                    position: index,
                                                    delay: const Duration(
                                                        milliseconds: 600),
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    child: SlideAnimation(
                                                      verticalOffset: 44.0,
                                                      child: FadeInAnimation(
                                                        child: ListTile(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      20.0,
                                                                  horizontal:
                                                                      30.0),
                                                          leading: Icon(
                                                              navicon[index]),
                                                          title: AutoSizeText(
                                                            navbarOpsion[index]
                                                                ['title']!,
                                                            maxFontSize: 20.0,
                                                            minFontSize: 18.0,
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                        ),
                                      )),
                                )
                                    .animate(
                                        delay:
                                            const Duration(milliseconds: 200))
                                    .slideY(
                                        begin: 3,
                                        end: 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.bounceIn),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            color: const Color(0xFFfaf5f1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Obx(() => AutoSizeText(
                                              'Good ${timeSunPosition.timeOfDay.value}',
                                              maxFontSize: 45,
                                              minFontSize: 40,
                                              style: GoogleFonts.aBeeZee(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ))
                                        .animate()
                                        .fadeIn(
                                            curve: Curves.easeIn,
                                            duration: const Duration(
                                                milliseconds: 700))),
                                const SizedBox(height: 20.0),
                                AnimationLimiter(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    childAspectRatio: 18 / 8,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 30,
                                    crossAxisSpacing: 20,
                                    children: List.generate(
                                        gameList.length,
                                        (index) => AnimationConfiguration
                                                .staggeredGrid(
                                              columnCount: 2,
                                              position: index,
                                              delay: const Duration(
                                                  milliseconds: 250),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              child: ScaleAnimation(
                                                scale: 0.5,
                                                child: FadeInAnimation(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          gameList[index]
                                                              ['routePath']!);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 2,
                                                              child: ClipRRect(
                                                                borderRadius: const BorderRadius
                                                                    .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20.0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            20.0)),
                                                                child:
                                                                    Image.asset(
                                                                  gameList[
                                                                          index]
                                                                      [
                                                                      'imagePath']!,
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height,
                                                                ),
                                                              )),
                                                          Expanded(
                                                              flex: 3,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    AutoSizeText(
                                                                        gameList[index]
                                                                            [
                                                                            'GameName']!,
                                                                        maxFontSize:
                                                                            25,
                                                                        minFontSize:
                                                                            22,
                                                                        style: GoogleFonts.aBeeZee(
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                    AutoSizeText(
                                                                        gameList[index]
                                                                            [
                                                                            'subtitle']!,
                                                                        maxFontSize:
                                                                            25,
                                                                        minFontSize:
                                                                            20,
                                                                        style: GoogleFonts.aBeeZee(
                                                                            fontWeight:
                                                                                FontWeight.w400)),
                                                                  ],
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5.0, left: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        'Categories',
                                        maxFontSize: 35,
                                        minFontSize: 30,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ).animate().fadeIn(
                                          curve: Curves.easeIn,
                                          duration: const Duration(
                                              milliseconds: 700)),
                                      TextButton(
                                        onPressed: () {
                                          Get.toNamed('/show-all-content');
                                        },
                                        child: AutoSizeText(
                                          'Show all',
                                          maxFontSize: 20,
                                          minFontSize: 18,
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              color: kSoftblue),
                                        ),
                                      ).animate().slideX(
                                          begin: 3,
                                          end: 0,
                                          curve: Curves.bounceIn,
                                          duration: const Duration(
                                              milliseconds: 500)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                AnimationLimiter(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    childAspectRatio: 1,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    children: List.generate(
                                        showAll ? contentKiddo.length : 4,
                                        (index) => AnimationConfiguration
                                                .staggeredGrid(
                                              columnCount: 2,
                                              delay: const Duration(
                                                  milliseconds: 250),
                                              position: index,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              child: ScaleAnimation(
                                                scale: 0.5,
                                                child: FadeInAnimation(
                                                  child: GestureDetector(
                                                    onLongPressStart: (_) {
                                                      setState(() {
                                                        longPressStates
                                                            .fillRange(
                                                                0,
                                                                longPressStates
                                                                    .length,
                                                                false);
                                                        longPressStates[index] =
                                                            true;
                                                      });
                                                    },
                                                    onLongPressEnd: (_) {
                                                      setState(() {
                                                        longPressStates[index] =
                                                            false;
                                                        selectedLongPressIndex =
                                                            null;
                                                      });
                                                    },
                                                    onTap: () {
                                                      setState(() {
                                                        longPressStates[index] =
                                                            !longPressStates[
                                                                index];
                                                        for (int i = 0;
                                                            i <
                                                                longPressStates
                                                                    .length;
                                                            i++) {
                                                          if (i != index) {
                                                            longPressStates[i] =
                                                                false;
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 10.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
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
                                                                          .all(
                                                                          20.0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                    child: Image
                                                                        .asset(
                                                                      contentKiddo[
                                                                              index]
                                                                          [
                                                                          'imagePath']!,
                                                                      fit: BoxFit
                                                                          .fitHeight,
                                                                      height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height,
                                                                    ),
                                                                  ),
                                                                ),
                                                                longPressStates[
                                                                        index]
                                                                    ? Positioned(
                                                                        right:
                                                                            30.0,
                                                                        bottom:
                                                                            30.0,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.offNamed(contentKiddo[index]['routePath']!);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                55,
                                                                            height:
                                                                                55,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: Color(0xFF1ed760),
                                                                              border: Border.fromBorderSide(BorderSide(
                                                                                color: Color(0xFF1db954),
                                                                                strokeAlign: 1,
                                                                                width: 1,
                                                                              )),
                                                                            ),
                                                                            child:
                                                                                const Icon(
                                                                              Icons.play_arrow,
                                                                              color: Color(0xFF191414),
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
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      AutoSizeText(
                                                                          contentKiddo[index]
                                                                              [
                                                                              'name']!,
                                                                          maxFontSize:
                                                                              25,
                                                                          minFontSize:
                                                                              22,
                                                                          style: const TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold)),
                                                                      AutoSizeText(
                                                                          contentKiddo[index]
                                                                              [
                                                                              'subtitle']!,
                                                                          maxFontSize:
                                                                              18,
                                                                          minFontSize:
                                                                              16,
                                                                          style:
                                                                              GoogleFonts.aBeeZee(fontWeight: FontWeight.w400)),
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
                                adsController.getAdWidget()
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await NetworkManager.instance.refreshConnectionStatus();
  }
}
