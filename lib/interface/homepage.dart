import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:textspeech/interface/center_category.dart';
import 'package:textspeech/util/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  List contentKiddo = [];
  List sliderKiddo = [];

  _readDataContent() async {
    await DefaultAssetBundle.of(context)
        .loadString('assets/json/content.json')
        .then((value) {
      setState(() {
        contentKiddo = jsonDecode(value);
      });
    });
  }

  _readDataSlider() async {
    await DefaultAssetBundle.of(context)
        .loadString('assets/json/slider.json')
        .then((value) {
      setState(() {
        sliderKiddo = jsonDecode(value);
      });
    });
  }

  @override
  void initState() {
    _readDataContent();
    _readDataSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Widget carouselSlider = (sliderKiddo.isNotEmpty)
        ? CarouselSlider(
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
                            Get.toNamed(gamesRoutes[_current]['routePath']!);
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
        : const SizedBox.shrink();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                            backgroundImage:
                                const AssetImage('assets/animals/cat.png'),
                            radius: width / 15,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Melissa',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 20,
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
                      fontSize: 20,
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
            carouselSlider,
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
                'Kursus',
                style: GoogleFonts.montserratAlternates(
                  fontSize: 24,
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
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 110,
                  childAspectRatio: .8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contentKiddo.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                        child: OpenContainer(
                      openColor: Colors.pink,
                      transitionDuration: const Duration(milliseconds: 500),
                      transitionType: ContainerTransitionType.fade,
                      closedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      openBuilder: (context, action) {
                        return const CategoryCenter();
                      },
                      closedBuilder: (context, action) {
                        return GestureDetector(
                          onTap: () {
                            // Get.offNamed('/categories', arguments: {
                            //   'titleContent': category['categories'][0]
                            //       ['titleContent']
                            // });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                  image: AssetImage(
                                      '${contentKiddo[index]['imagePath']}'),
                                  fit: BoxFit.contain),
                              // borderRadius: BorderRadius.circular(20.0),
                            ),
                          )
                              .animate(
                                delay: const Duration(milliseconds: 100),
                              )
                              .fadeIn(
                                  delay: Duration(milliseconds: index * 200))
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
                        .fadeIn(delay: Duration(milliseconds: index * 100))
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
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
