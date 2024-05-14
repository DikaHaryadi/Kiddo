import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/models/family_model.dart';
import 'package:textspeech/interface/detail%20content/detail_family.dart';
import 'package:textspeech/util/app_colors.dart';

class FamilyCardScreen extends StatelessWidget {
  const FamilyCardScreen({super.key, required this.model});

  final FamilyModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          OpenContainer(
            closedElevation: 0,
            transitionDuration: const Duration(milliseconds: 500),
            transitionType: ContainerTransitionType.fade,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            closedBuilder: (context, action) {
              return Image.network(
                model.imageContent,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              );
            },
            openBuilder: (context, action) => DetailFamily(
              model: model,
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFfcf4f1),
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    model.subjectFamily,
                    maxFontSize: 14,
                    minFontSize: 12,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  AutoSizeText(
                    model.subtitle,
                    maxFontSize: 14,
                    minFontSize: 12,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 250), () {
                Get.to(
                  () => DetailFamily(
                    model: model,
                  ),
                );
              });
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kGreen,
                  border: Border.fromBorderSide(BorderSide(
                      color: Colors.white, strokeAlign: 1, width: 2))),
              child: const Icon(
                Icons.play_arrow,
                color: kDark,
              ),
            ),
          )
        ],
      ),
    );
  }
}
