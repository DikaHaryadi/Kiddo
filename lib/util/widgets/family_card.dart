import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/models/family_model.dart';
import 'package:textspeech/interface/detail%20content/detail_family.dart';

class FamilyCardScreen extends StatelessWidget {
  const FamilyCardScreen({super.key, required this.model});

  final FamilyModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24.0),
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
              return CachedNetworkImage(
                imageUrl: model.imageContent,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/Logo_color1.png'),
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
        ],
      ),
    );
  }
}
