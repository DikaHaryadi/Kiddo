import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/quiz/question_model.dart';
import 'package:textspeech/quiz/question_paper_controller.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/responsive.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  const QuestionCard({super.key, required this.model});

  final QuestionModel model;

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? InkWell(
            onTap: () {
              controller.navigateToQuestions(paper: model, tryAgain: false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.width * 0.2,
                    width: Get.width * 0.2,
                    child: CachedNetworkImage(
                      imageUrl: model.imageUrl,
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/Logo_color1.png'),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kButtonPrimary),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          child: Text(
                            model.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(Iconsax.note),
                                const SizedBox(width: 2),
                                Text(
                                  '${model.questionCount} questions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.apply(color: kGrey),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12.0),
                            Row(
                              children: [
                                const Icon(Iconsax.clock),
                                const SizedBox(width: 2),
                                Text(
                                  model.timeInMinits(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.apply(color: kError),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : InkWell(
            onTap: () {
              controller.navigateToQuestions(paper: model, tryAgain: false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.width * 0.2,
                    width: Get.width * 0.2,
                    child: CachedNetworkImage(
                      imageUrl: model.imageUrl,
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/Logo_color1.png'),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kButtonPrimary),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 15.0, right: 10.0),
                          child: Text(
                            model.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Iconsax.note,
                                  size: 35,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${model.questionCount} questions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.apply(color: kGrey),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16.0),
                            Row(
                              children: [
                                const Icon(
                                  Iconsax.clock,
                                  size: 35,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  model.timeInMinits(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.apply(color: kError),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
