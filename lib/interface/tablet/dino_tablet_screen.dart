import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/dino_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/models/dino_model.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class DinoTabletScreen extends StatelessWidget {
  final DinoController controller;
  final DinoModel model;

  const DinoTabletScreen(
      {Key? key, required this.controller, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ttsController = Get.put(TtsController());

    return GestureDetector(
      onTap: () {
        if (controller.collapse.value) {
          controller.toggleCollapse();
        }
      },
      child: Stack(
        children: [
          // CachedNetworkImage with conditional positioning
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: model.imageContent,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/Logo_color1.png'),
            ),
          ),
          // Expanded content when collapsed
          Obx(() {
            if (!controller.collapse.value) {
              return Positioned(
                left: 0,
                top: 16,
                bottom: Get.height / 3.5,
                width: Get.width / 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    border: Border.all(color: kBlack.withOpacity(0.13)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.3),
                      ],
                    ),
                  ),
                  child: Scrollbar(
                    scrollbarOrientation: ScrollbarOrientation.left,
                    thickness: 5,
                    child: ListView.builder(
                      itemCount: controller.dinoModel.length,
                      itemBuilder: (context, index) {
                        final dino = controller.dinoModel[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: const Duration(milliseconds: 250),
                          duration: const Duration(milliseconds: 1000),
                          child: SlideAnimation(
                            verticalOffset: 44.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectedDino.value = dino;
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 20.0,
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      imageUrl: dino.imageContent,
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                      placeholder: (context, url) => Container(
                                        alignment: Alignment.center,
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              'assets/images/Logo_color1.png'),
                                    ),
                                  ),
                                  title: Text(
                                    dino.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.apply(color: kBlack),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              // Default view or expanded content
              return Positioned(
                top: 24.0,
                left: 24.0,
                right: 24.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => controller.toggleCollapse(),
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
          // Additional content at the bottom
          Obx(() {
            if (!controller.collapse.value) {
              return Stack(
                children: [
                  Positioned(
                    bottom: 20.0,
                    left: 24.0,
                    right: 24.0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.13)),
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
                                model.title, "en-US"),
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
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          InkWell(
                            onTap: () => ttsController.textToSpeech(
                                model.deskripsi, "en-US"),
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
                  ),
                  Positioned(
                    bottom: 20.0,
                    left: 24.0,
                    right: 24.0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.13)),
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
                            onTap: () => ttsController.textToSpeech(
                                model.title, "en-US"),
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
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          InkWell(
                            onTap: () => ttsController.textToSpeech(
                                model.deskripsi, "en-US"),
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
                  ),
                  Positioned(
                    top: 24.0,
                    left: 24.0,
                    right: 24.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => controller.toggleCollapse(),
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
                  )
                ],
              );
            } else {
              return Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: model.imageContent,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/Logo_color1.png'),
                    ),
                  ),
                  Positioned(
                    top: 24.0,
                    left: 24.0,
                    right: 24.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => controller.toggleCollapse(),
                          icon: Icon(
                            !controller.collapse.value
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
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
                  )
                ],
              );
            }
          })
        ],
      ),
    );
  }
}
