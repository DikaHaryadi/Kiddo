import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/dino_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/models/dino_model.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class CardDinoContent extends StatefulWidget {
  final DinoController controller;
  final DinoModel model;

  const CardDinoContent({
    super.key,
    required this.controller,
    required this.model,
  });

  @override
  State<CardDinoContent> createState() => _CardDinoContentState();
}

class _CardDinoContentState extends State<CardDinoContent> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Get.height / 3;

  @override
  void initState() {
    super.initState();
    if (widget.model.deskripsi.length > textHeight) {
      firstHalf = widget.model.deskripsi.substring(0, textHeight.toInt());
      secondHalf = widget.model.deskripsi
          .substring(textHeight.toInt() + 1, widget.model.deskripsi.length);
    } else {
      firstHalf = widget.model.deskripsi;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ttsController = Get.put(TtsController());
    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: widget.model.imageContent,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/Logo_color1.png'),
          ),
        ),
        Obx(() {
          if (!widget.controller.collapse.value) {
            return Positioned(
              bottom: 20.0,
              left: 24.0,
              right: 24.0,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white.withOpacity(0.13)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          kBlack.withOpacity(0.5),
                          kBlack.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 8.0,
                        children: List.generate(
                            widget.controller.dinoModel.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              widget.controller.selectedDino.value =
                                  widget.controller.dinoModel[index];
                              ttsController.textToSpeech(
                                  widget.controller.dinoModel[index].deskripsi,
                                  'en-US');
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: widget.controller.selectedDino
                                                  .value ==
                                              widget.controller.dinoModel[index]
                                          ? kWhite
                                          : Colors.transparent)),
                              child: CachedNetworkImage(
                                imageUrl: widget
                                    .controller.dinoModel[index].imageContent,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        'assets/images/Logo_color1.png'),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white.withOpacity(0.13)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          kBlack.withOpacity(0.5),
                          kBlack.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => ttsController.textToSpeech(
                              widget.model.title, "en-US"),
                          child: Text(
                            widget.model.title,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.apply(color: kWhite),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        InkWell(
                            onTap: () => ttsController.textToSpeech(
                                widget.model.jenisMakanan, "en-US"),
                            child: Text(
                              widget.model.jenisMakanan,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.apply(color: kWhite),
                            )),
                        const SizedBox(height: 5.0),
                        InkWell(
                          onTap: () {
                            setState(() {
                              hiddenText = !hiddenText;
                            });
                          },
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                text: (hiddenText
                                    ? ('$firstHalf...')
                                    : (firstHalf + secondHalf)),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.apply(color: kWhite),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: hiddenText ? 'See More' : '',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          setState(() {
                                            hiddenText = !hiddenText;
                                          });
                                        }),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Positioned(
              top: 24.0,
              left: 24.0,
              right: 24.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => widget.controller.toggleCollapse(),
                    icon: const Icon(
                      Iconsax.eye,
                      color: kWhite,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.offNamed('/home'),
                    icon: const Icon(
                      Iconsax.back_square,
                      color: kWhite,
                      size: 40,
                    ),
                  ),
                ],
              ),
            );
          }
        }),
        Obx(() {
          if (!widget.controller.collapse.value) {
            return Positioned(
              top: 14.0,
              left: 14.0,
              right: 14.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => widget.controller.toggleCollapse(),
                    icon: const Icon(
                      Iconsax.eye,
                      color: kWhite,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.musicnote,
                      color: kWhite,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.play_circle,
                      color: kWhite,
                      size: 30,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: widget.model.imageContent,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/Logo_color1.png'),
                  ),
                ),
                Positioned(
                  top: 14.0,
                  left: 14.0,
                  right: 14.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => widget.controller.toggleCollapse(),
                        icon: Icon(
                          !widget.controller.collapse.value
                              ? Iconsax.eye
                              : Iconsax.eye_slash,
                          color: kWhite,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.musicnote,
                          color: kWhite,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.play_circle,
                          color: kWhite,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        })
      ],
    );
  }
}
