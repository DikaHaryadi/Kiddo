import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/dino_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/models/dino_model.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class CardDinoContent extends StatelessWidget {
  final DinoController controller;
  final DinoModel model;

  const CardDinoContent({
    super.key,
    required this.controller,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final ttsController = Get.put(TtsController());
    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: model.imageContent,
            fit: BoxFit.fitHeight,
            placeholder: (context, url) => Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/Logo_color1.png'),
          ),
        ),
        Positioned(
          bottom: 20.0,
          left: 24.0,
          right: 24.0,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 8.0,
                  children: List.generate(controller.dinoModel.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedDino.value =
                            controller.dinoModel[index];
                        ttsController.textToSpeech(
                            controller.dinoModel[index].deskripsi, 'en-US');
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: controller.selectedDino.value ==
                                        controller.dinoModel[index]
                                    ? kWhite
                                    : Colors.transparent)),
                        child: CachedNetworkImage(
                          imageUrl: controller.dinoModel[index].imageContent,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/Logo_color1.png'),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      kBlack.withOpacity(0.15),
                      kBlack.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () =>
                          ttsController.textToSpeech(model.title, "en-US"),
                      child: Text(
                        model.title,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.apply(color: kWhite),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    InkWell(
                        onTap: () => ttsController.textToSpeech(
                            model.jenisMakanan, "en-US"),
                        child: Text(
                          model.jenisMakanan,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.apply(color: kWhite),
                        )),
                    const SizedBox(height: 5.0),
                    InkWell(
                      onTap: () =>
                          ttsController.textToSpeech(model.deskripsi, "en-US"),
                      child: Text(
                        model.deskripsi,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.apply(color: kWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
