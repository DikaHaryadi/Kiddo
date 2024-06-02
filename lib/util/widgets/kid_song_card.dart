import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/interface/detail%20content/detail_kid_song.dart';
import 'package:textspeech/models/kidsong_model.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/to_title_case.dart';

class KidSongCardScreen extends StatelessWidget {
  const KidSongCardScreen({super.key, required this.model});

  final KidSongModel model;

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
              return Image.network(
                model.imageContent,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              );
            },
            openBuilder: (context, action) => DetailKidSong(
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
                    toTitleCase(model.titleKidSong),
                    maxFontSize: 14,
                    minFontSize: 12,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  AutoSizeText.rich(
                    maxFontSize: 14,
                    minFontSize: 12,
                    TextSpan(text: toTitleCase('ini disini')),
                    style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 250), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailKidSong(
                        model: model,
                      ),
                    ));
              });
            },
            child: const ClayContainer(
              color: kWhite,
              child: Icon(
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
