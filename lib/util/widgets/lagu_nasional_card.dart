import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/interface/detail%20content/detail_lagu_nasional.dart';
import 'package:textspeech/models/lagu_nasional_model.dart';
import 'package:textspeech/util/etc/to_title_case.dart';

class LaguNasionalCard extends StatelessWidget {
  const LaguNasionalCard({super.key, required this.model});

  final LaguNasionalModel model;

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
                imageUrl: model.image,
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
            openBuilder: (context, action) => DetailLaguNasional(
              model: model,
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    toTitleCase(model.title),
                    maxFontSize: 14,
                    minFontSize: 12,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  AutoSizeText(
                    toTitleCase(model.subtitle),
                    maxFontSize: 14,
                    minFontSize: 12,
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
