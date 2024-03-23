import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/util/constants.dart';
import 'package:unicons/unicons.dart';

class AnimalInfoAppBar extends SliverPersistentHeaderDelegate {
  final int count;

  AnimalInfoAppBar(this.count); // Constructor added here

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 50,
            height: 8,
            margin: const EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  UniconsLine.repeat,
                  size: 25,
                ),
                const SizedBox(width: 5.0),
                RichText(
                  text: TextSpan(
                    text: 'Single Replay |',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' $count categories',
                        style: GoogleFonts.robotoSlab(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
