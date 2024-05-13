import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/models/animal_model.dart';
import 'package:textspeech/util/app_colors.dart';

import '../../interface/detail content/detail_animal.dart';

class AnimalCardScreen extends StatelessWidget {
  const AnimalCardScreen({super.key, required this.model});

  final AnimalModel model;

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
            openBuilder: (context, action) => DetailAnimals(
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
                    model.titleAnimal,
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
                    TextSpan(text: '${model.kategori} | ${model.jenisMakanan}'),
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
                      builder: (context) => DetailAnimals(
                        model: model,
                      ),
                    ));
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
