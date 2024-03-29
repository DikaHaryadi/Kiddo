import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/responsive.dart';

class VegetablesContent extends StatelessWidget {
  const VegetablesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isMobile(context)
            ? Container()
            : Column(children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      'track and match'.toUpperCase(),
                      style: GoogleFonts.roboto(
                          fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: vegetablesList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Image.asset(
                            vegetablesList[index]['imagePath']!,
                            height: 200,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              color: Colors.white,
                            ),
                            child: Text(vegetablesList[index]['name']!),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ]),
      ),
    );
  }
}
