import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:textspeech/interface/content/animal.dart';
import 'package:textspeech/interface/content/family.dart';
import 'package:textspeech/interface/content/fruits.dart';
import 'package:textspeech/interface/content/letters.dart';
import 'package:textspeech/interface/content/numbers.dart';
import 'package:textspeech/interface/content/vegetables.dart';
import 'package:textspeech/util/category_list_mobile.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _timeOfDay;
  bool showAll = false;
  List<bool> longPressStates = List.generate(contentKiddo.length, (_) => false);
  int? selectedLongPressIndex;

  CategoryListNotifier categoryListNotifier = CategoryListNotifier();

  List<Widget> openContent = const [
    NumberContent(),
    LettersContent(),
    AnimalContent(),
    FamilyContent(),
    FruitsContent(),
    VegetablesContent()
  ];

  // banner ads
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    await _anchoredAdaptiveAd?.dispose();
    setState(() {
      _anchoredAdaptiveAd = null;
      _isLoaded = false;
    });

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            // ignore: use_build_context_synchronously
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: 'ca-app-pub-3048736622280674/6380402407',
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  Widget _getAdWidget() {
    if (_anchoredAdaptiveAd != null && _isLoaded) {
      return Container(
        color: Colors.white,
        width: _anchoredAdaptiveAd!.size.width.toDouble(),
        height: _anchoredAdaptiveAd!.size.height.toDouble(),
        child: AdWidget(ad: _anchoredAdaptiveAd!),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void _getTimeOfDay() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    setState(() {
      if (hour >= 4 && hour < 12) {
        _timeOfDay = 'Morning';
      } else if (hour >= 12 && hour < 17) {
        _timeOfDay = 'Afternoon';
      } else if (hour >= 17 && hour < 20) {
        _timeOfDay = 'Evening';
      } else {
        _timeOfDay = 'Night';
      }
    });
  }

  @override
  void initState() {
    _loadAd();
    _getTimeOfDay();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfcf4f1),
      body: SafeArea(
        child: isMobile(context)
            ? Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    shrinkWrap: true,
                    children: [
                      Text(
                        'Good $_timeOfDay',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ).animate().slideY(
                          begin: -2,
                          end: 0,
                          curve: Curves.bounceIn,
                          duration: const Duration(milliseconds: 400)),
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
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
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
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(game['GameName']!,
                                                  style: GoogleFonts.aBeeZee(
                                                      color: kDark,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(game['subtitle']!,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: kDark,
                                                    fontSize: 14,
                                                  ))
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
                                  final Map<String, String> game = entry.value;

                                  final bool isSelected =
                                      selectedIndex == index;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: BorderSide(
                                            color: isSelected
                                                ? Colors.black45
                                                : Colors.white,
                                            width: 2),
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
                                      label: Text(
                                        game['enum']!,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.bold,
                                            color: kDark),
                                      ),
                                    ),
                                  )
                                      .animate(
                                        delay:
                                            const Duration(milliseconds: 100),
                                      )
                                      .slideX(
                                        begin: -2,
                                        end: 0,
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        curve: Curves.easeOut,
                                        delay: const Duration(
                                          milliseconds: 100,
                                        ),
                                      );
                                }).toList(),
                                if (!showAll && gameList.length > 2)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showAll = true;
                                        });
                                      },
                                      child: const Icon(Icons.arrow_forward),
                                    )
                                        .animate(
                                          delay:
                                              const Duration(milliseconds: 100),
                                        )
                                        .slideX(
                                          begin: 2,
                                          end: 0,
                                          duration: const Duration(
                                            milliseconds: 500,
                                          ),
                                          curve: Curves.easeOut,
                                          delay: const Duration(
                                            milliseconds: 100,
                                          ),
                                        ),
                                  ),
                                if (showAll)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showAll = false;
                                        });
                                      },
                                      child: const Icon(Icons.arrow_back),
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
                            if (value != null &&
                                value >= 0 &&
                                value < gameList.length) {
                              final selectedEnum = gameList[value]['enum'];
                              final filteredContent = contentKiddo
                                  .where((item) => item['enum'] == selectedEnum)
                                  .toList();

                              return GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                children:
                                    AnimationConfiguration.toStaggeredList(
                                  duration: const Duration(milliseconds: 800),
                                  childAnimationBuilder: (widget) =>
                                      SlideAnimation(
                                    verticalOffset:
                                        MediaQuery.of(context).size.width / 2,
                                    child: FadeInAnimation(
                                      child: widget,
                                    ),
                                  ),
                                  children: List.generate(
                                      filteredContent.length, (index) {
                                    final content = filteredContent[index];
                                    return Container(
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
                                                  ContainerTransitionType.fade,
                                              closedShape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
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
                                                            content[
                                                                'imagePath']!),
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${content['name']}',
                                            style: GoogleFonts
                                                .montserratAlternates(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
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
                      bottom: 0, left: 10, right: 10, child: _getAdWidget())
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
                                              BorderRadius
                                                  .only(
                                                      bottomLeft: Radius
                                                          .circular(15.0),
                                                      bottomRight: Radius
                                                          .circular(15.0)),
                                          color: kStrongblue),
                                      child: AnimationLimiter(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children:
                                                  AnimationConfiguration
                                                      .toStaggeredList(
                                                          delay:
                                                              const Duration(
                                                                  milliseconds:
                                                                      600),
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500),
                                                          childAnimationBuilder:
                                                              (widget) =>
                                                                  SlideAnimation(
                                                                    horizontalOffset:
                                                                        MediaQuery.of(context).size.width /
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
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      'Learning App\nFor Kids',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0,
                                                          color: Colors.white),
                                                    )
                                                  ]))))
                                  .animate(
                                      delay: const Duration(milliseconds: 200))
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
                                                                vertical: 20.0,
                                                                horizontal:
                                                                    30.0),
                                                        leading: Icon(
                                                            navicon[index]),
                                                        title: Text(
                                                          navbarOpsion[index]
                                                              ['title']!,
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
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
                                      delay: const Duration(milliseconds: 200))
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
                                  child: Text(
                                    'Good $_timeOfDay',
                                    style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 45,
                                        color: Colors.black),
                                  ).animate().fadeIn(
                                      curve: Curves.easeIn,
                                      duration:
                                          const Duration(milliseconds: 700))),
                              const SizedBox(height: 20.0),
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
                                      (index) =>
                                          AnimationConfiguration.staggeredGrid(
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
                                                    Get.toNamed(gameList[index]
                                                        ['routePath']!);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
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
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20.0)),
                                                              child:
                                                                  Image.asset(
                                                                gameList[index][
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
                                                                  Text(
                                                                      gameList[
                                                                              index]
                                                                          [
                                                                          'GameName']!,
                                                                      style: GoogleFonts.aBeeZee(
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  Text(
                                                                      gameList[
                                                                              index]
                                                                          [
                                                                          'subtitle']!,
                                                                      style: GoogleFonts
                                                                          .aBeeZee(
                                                                        fontSize:
                                                                            16,
                                                                      )),
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
                                    right: 5.0, left: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Categories',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35,
                                          color: Colors.black),
                                    ).animate().fadeIn(
                                        curve: Curves.easeIn,
                                        duration:
                                            const Duration(milliseconds: 700)),
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed('/show-all-content');
                                      },
                                      child: Text(
                                        showAll ? 'View Less' : 'Show all',
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: kSoftblue),
                                      ),
                                    ).animate().slideX(
                                        begin: 3,
                                        end: 0,
                                        curve: Curves.bounceIn,
                                        duration:
                                            const Duration(milliseconds: 500)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              AnimationLimiter(
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  childAspectRatio: 1,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  children: List.generate(
                                      showAll ? contentKiddo.length : 4,
                                      (index) =>
                                          AnimationConfiguration.staggeredGrid(
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
                                                      longPressStates.fillRange(
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
                                                                .circular(10.0),
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
                                                                      BorderRadius
                                                                          .circular(
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
                                                                          Get.offNamed(contentKiddo[index]
                                                                              [
                                                                              'routePath']!);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              55,
                                                                          height:
                                                                              55,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Color(0xFF1ed760),
                                                                            border:
                                                                                Border.fromBorderSide(BorderSide(
                                                                              color: Color(0xFF1db954),
                                                                              strokeAlign: 1,
                                                                              width: 1,
                                                                            )),
                                                                          ),
                                                                          child:
                                                                              const Icon(
                                                                            Icons.play_arrow,
                                                                            color:
                                                                                Color(0xFF191414),
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
                                                                    Text(
                                                                        contentKiddo[index]
                                                                            [
                                                                            'name']!,
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                    Text(
                                                                        contentKiddo[index]
                                                                            [
                                                                            'subtitle']!,
                                                                        style: GoogleFonts.aBeeZee(
                                                                            fontSize:
                                                                                18)),
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
                              _getAdWidget()
                            ],
                          ),
                        )),
                  ],
                ),
              ),
      ),
    );
  }
}
