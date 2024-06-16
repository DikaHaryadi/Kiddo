import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AnimalInfoAppBar extends SliverPersistentHeaderDelegate {
  final int count;

  AnimalInfoAppBar(this.count);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Iconsax.repeat,
              size: 25,
            ),
            const SizedBox(width: 5.0),
            AutoSizeText.rich(
              maxFontSize: 14,
              minFontSize: 12,
              TextSpan(text: 'Single Replay | $count Kategori'),
              style: GoogleFonts.robotoSlab(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
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

class QuestionInforAppBar extends SliverPersistentHeaderDelegate {
  final String title;

  QuestionInforAppBar(this.title);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Iconsax.repeat,
              size: 25,
            ),
            const SizedBox(width: 5.0),
            AutoSizeText.rich(
              maxFontSize: 14,
              minFontSize: 12,
              TextSpan(text: 'Single Replay | $title Kategori'),
              style: GoogleFonts.robotoSlab(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
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
