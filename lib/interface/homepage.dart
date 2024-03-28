import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:textspeech/interface/content/animal.dart';
import 'package:textspeech/interface/content/family.dart';
import 'package:textspeech/interface/content/fruits.dart';
import 'package:textspeech/interface/content/letters.dart';
import 'package:textspeech/interface/content/numbers.dart';
import 'package:textspeech/interface/content/vegetables.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/curved_edges.dart';
import 'package:textspeech/util/game_list.dart';
import 'package:textspeech/util/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GameListNotifier gameListNotifier = GameListNotifier();

  int _current = 0;
  List sliderKiddo = [];

  List<Widget> openContent = const [
    NumberContent(),
    LettersContent(),
    AnimalContent(),
    FamilyContent(),
    FruitsContent(),
    VegetablesContent()
  ];

  _readDataSlider() async {
    await DefaultAssetBundle.of(context)
        .loadString('assets/json/slider.json')
        .then((value) {
      setState(() {
        sliderKiddo = jsonDecode(value);
      });
    });
  }

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
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/9214589741',
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
        margin: const EdgeInsets.only(top: 20),
        width: _anchoredAdaptiveAd!.size.width.toDouble(),
        height: _anchoredAdaptiveAd!.size.height.toDouble(),
        child: AdWidget(ad: _anchoredAdaptiveAd!),
      );
    } else {
      return const SizedBox
          .shrink(); // Return empty container if ad is not loaded
    }
  }

  @override
  void initState() {
    _readDataSlider();
    _loadAd();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              size: Size(double.infinity, MediaQuery.of(context).size.height),
              painter: HomeCurvesEdge(),
            ),
            if (isMobile(context))
              ListView(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                shrinkWrap: true,
                children: [
                  Container(
                    width: width,
                    height: height / 13,
                    padding: const EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xFFedddd0)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: const AssetImage(
                                      'assets/animals/cat.png'),
                                  radius: width / 15,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      'Melissa',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'Lv.4',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                      .animate(
                        delay: const Duration(milliseconds: 100),
                      )
                      .fadeIn(delay: const Duration(milliseconds: 200))
                      .shimmer(
                        duration: 200.ms,
                      )
                      .slide(
                        begin: const Offset(0, 1),
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeOut,
                        delay: const Duration(
                          milliseconds: 100,
                        ),
                      ),
                  CarouselSlider(
                    items: sliderKiddo.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 15.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xFF65d1ff),
                              image: DecorationImage(
                                image: AssetImage(item['img']),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bermain Angka',
                                  style: GoogleFonts.montserratAlternates(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                Text(
                                  'Temukan Angka',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        gamesRoutes[_current]['routePath']!);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    margin: const EdgeInsets.only(top: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Text(
                                      'Mulai',
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      autoPlay: false,
                      aspectRatio: 19 / 15,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  )
                      .animate(
                        delay: const Duration(milliseconds: 100),
                      )
                      .fadeIn(delay: const Duration(milliseconds: 300))
                      .shimmer(
                        duration: 200.ms,
                      )
                      .slide(
                        begin: const Offset(0, 0.5),
                        duration: const Duration(
                          milliseconds: 600,
                        ),
                        curve: Curves.easeOut,
                        delay: const Duration(
                          milliseconds: 100,
                        ),
                      ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedSmoothIndicator(
                      activeIndex: _current,
                      count: sliderKiddo.length,
                      effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 5,
                          activeDotColor: Colors.grey),
                    ),
                  ).animate(delay: const Duration(milliseconds: 100)).slideX(
                      begin: 2,
                      end: 0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
                    child: Text(
                      'Kategori Permainan',
                      style: GoogleFonts.montserratAlternates(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                        .animate(
                          delay: const Duration(milliseconds: 100),
                        )
                        .fadeIn(delay: const Duration(milliseconds: 400))
                        .shimmer(
                          duration: 200.ms,
                        )
                        .slide(
                          begin: const Offset(0.5, 0),
                          duration: const Duration(
                            milliseconds: 700,
                          ),
                          curve: Curves.easeOut,
                          delay: const Duration(
                            milliseconds: 100,
                          ),
                        ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: .8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: List.generate(
                        contentKiddo.length,
                        (index) => Column(
                              children: [
                                Expanded(
                                    child: OpenContainer(
                                  openColor: Colors.pink,
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  transitionType: ContainerTransitionType.fade,
                                  closedShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  openBuilder: (context, action) {
                                    return openContent[index];
                                  },
                                  closedBuilder: (context, action) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            routesList[index]['routePath']!);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  '${contentKiddo[index]['imagePath']}'),
                                              fit: BoxFit.contain),
                                        ),
                                      )
                                          .animate(
                                            delay: const Duration(
                                                milliseconds: 100),
                                          )
                                          .fadeIn(
                                              delay: Duration(
                                                  milliseconds: index * 200))
                                          .shimmer(
                                            duration: 200.ms,
                                          )
                                          .slide(
                                            begin: const Offset(0.5, 0),
                                            duration: const Duration(
                                              milliseconds: 700,
                                            ),
                                            curve: Curves.easeOut,
                                            delay: Duration(
                                              milliseconds: index * 100,
                                            ),
                                          ),
                                    );
                                  },
                                )),
                                const SizedBox(height: 5.0),
                                Text(
                                  '${contentKiddo[index]['name']}',
                                  style: GoogleFonts.montserratAlternates(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                )
                                    .animate(
                                      delay: const Duration(milliseconds: 100),
                                    )
                                    .fadeIn(
                                        delay:
                                            Duration(milliseconds: index * 100))
                                    .shimmer(
                                      duration: 200.ms,
                                    )
                                    .slide(
                                      begin: const Offset(0.5, 0),
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      curve: Curves.easeOut,
                                      delay: Duration(
                                        milliseconds: index * 100,
                                      ),
                                    ),
                              ],
                            )),
                  )
                ],
              ),
            if (isDesktop(context))
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.blue,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, top: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.purple,
                                  ),
                                  const SizedBox(width: 15.0),
                                  Text(
                                    'Hi Melissa',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 40.0, bottom: 20.0),
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/banner_home.png'),
                                        fit: BoxFit.fill),
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Text(
                                'Game Category',
                                style: GoogleFonts.montserrat(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              ValueListenableBuilder<int?>(
                                valueListenable: gameListNotifier.selectedTab,
                                builder: (context, selectedIndex, child) {
                                  final gameList = gameListNotifier.gameList;
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children:
                                          gameList.asMap().entries.map((entry) {
                                        final int index = entry.key;
                                        final Map<String, String> game =
                                            entry.value;

                                        final bool isSelected =
                                            selectedIndex == index;

                                        return InkWell(
                                          onTap: () {
                                            gameListNotifier.selectTab(index);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5.0,
                                              horizontal: 25.0,
                                            ),
                                            margin: const EdgeInsets.only(
                                              right: 20.0,
                                              top: 15.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                color: isSelected
                                                    ? Colors.blue
                                                    : Colors.grey.shade300,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                const CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor: Colors.pink,
                                                ),
                                                const SizedBox(width: 10.0),
                                                Text(game['enum']!)
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                              ValueListenableBuilder<int?>(
                                valueListenable: gameListNotifier.selectedTab,
                                builder: (context, value, child) {
                                  final gameList = gameListNotifier.gameList;
                                  if (value != null &&
                                      value >= 0 &&
                                      value < gameList.length) {
                                    final selectedGame = gameList[value];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      width: double.infinity,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              selectedGame['imagePath']!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bermain Angka',
                                            style: GoogleFonts
                                                .montserratAlternates(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Text(
                                            'Temukan Angka',
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(gamesRoutes[_current]
                                                  ['routePath']!);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                              margin: const EdgeInsets.only(
                                                  top: 10.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              child: Text(
                                                'Mulai',
                                                style: GoogleFonts.robotoSlab(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        height: 200,
                                        color: Colors.black,
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      )),
                                ],
                              ),
                              _getAdWidget(),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 20, bottom: 10.0),
                                child: Text(
                                  'Course Learning',
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: contentKiddo.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            routesList[index]['routePath']!);
                                      },
                                      child: Container(
                                        height: 200,
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    contentKiddo[index]
                                                        ['imagePath']!),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
