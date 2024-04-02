import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:textspeech/util/constants.dart';

class ShowAllContent extends StatefulWidget {
  const ShowAllContent({super.key});

  @override
  State<ShowAllContent> createState() => _ShowAllContentState();
}

class _ShowAllContentState extends State<ShowAllContent> {
  bool longPressPlay = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfcf4f1),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: const Color(0xFFfcf4f1),
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0)),
                                color: kSoftblue),
                            child: Wrap(
                              children: List.generate(
                                  navbarOpsion.length,
                                  (index) => ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 30.0),
                                        leading: Icon(navicon[index]),
                                        title: Text(
                                          navbarOpsion[index]['title']!,
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      )),
                            )),
                      ),
                      Container(
                          width: double.infinity,
                          height: 300,
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 20.0),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                              color: kStrongblue),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/Logo_color1.png',
                                width: 200,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: IconButton(
                                        onPressed: () {
                                          Get.offNamed('/');
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Colors.black,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      'Today',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                DateFormat('EEEE, MMM d')
                                    .format(DateTime.now()),
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ],
                          )),
                    ],
                  ),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  color: const Color(0xFFfcf4f1),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(
                        contentKiddo.length,
                        (index) => GestureDetector(
                              onLongPressStart: (_) {
                                setState(() {
                                  longPressPlay = true;
                                });
                              },
                              onLongPressEnd: (_) {
                                setState(() {
                                  longPressPlay = false;
                                });
                              },
                              onTap: () {
                                setState(() {
                                  longPressPlay = !longPressPlay;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              child: Image.asset(
                                                contentKiddo[index]
                                                    ['imagePath']!,
                                                fit: BoxFit.fitHeight,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                              ),
                                            ),
                                          ),
                                          longPressPlay
                                              ? Positioned(
                                                  right: 30.0,
                                                  bottom: 30.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          contentKiddo[index]
                                                              ['routePath']!);
                                                    },
                                                    child: Container(
                                                      width: 55,
                                                      height: 55,
                                                      decoration: const BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          color: kGreen,
                                                          border: Border
                                                              .fromBorderSide(
                                                                  BorderSide(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      strokeAlign:
                                                                          1,
                                                                      width:
                                                                          1))),
                                                      child: const Icon(
                                                        Icons.play_arrow,
                                                        color: kDark,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    contentKiddo[index]
                                                        ['name']!,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    contentKiddo[index]
                                                        ['subtitle']!,
                                                    style: GoogleFonts.aBeeZee(
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            )),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
