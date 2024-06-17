import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/question_controller.dart';
import 'package:textspeech/quiz/answer_card.dart';
import 'package:textspeech/quiz/question_number.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/responsive.dart';
import '../util/etc/curved_edges.dart';

class AppBarQuizz extends StatelessWidget {
  const AppBarQuizz(
      {super.key,
      this.title = '',
      this.titleWidget,
      this.leading,
      this.showActionIcon = false,
      this.onMenuActionTap,
      required this.controller});

  final QuestionController controller;
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? ClipPath(
            clipper: TCustomCurvedEdges(),
            child: Container(
              color: Colors.blueAccent,
              height: 100,
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: titleWidget == null
                          ? Center(
                              child: Text(
                                title,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            )
                          : Center(
                              child: titleWidget,
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      leading ??
                          Transform.translate(
                            offset: const Offset(-14, 0),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: BackButton(),
                                )),
                          ),
                      if (showActionIcon)
                        Transform.translate(
                          offset: const Offset(10, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 22.0),
                            child: InkWell(
                              onTap: onMenuActionTap ??
                                  () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            width: double.maxFinite,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Check Your Answer Before Completing The Test',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium,
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height:
                                                        20), // Add some spacing
                                                Flexible(
                                                  child: GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: controller
                                                        .allQuestions.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          (Get.width ~/ 75),
                                                      childAspectRatio: 1,
                                                      crossAxisSpacing: 8,
                                                      mainAxisSpacing: 8,
                                                    ),
                                                    itemBuilder: (_, index) {
                                                      AnswerStatus?
                                                          answereStatus;
                                                      if (controller
                                                              .allQuestions[
                                                                  index]
                                                              .selectedAnswer !=
                                                          null) {
                                                        answereStatus =
                                                            AnswerStatus
                                                                .answered;
                                                      }
                                                      return QuestionNumberCard(
                                                          index: index + 1,
                                                          status: answereStatus,
                                                          onTap: () => controller
                                                              .jumpToQuestion(
                                                                  index));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Get.width / 3,
                                                  child: OutlinedButton(
                                                    onPressed: controller
                                                        .navigateToHome,
                                                    child: const Text('Keluar'),
                                                  ),
                                                ),
                                                const SizedBox(width: 8.0),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed:
                                                          controller.complete,
                                                      child: const Text(
                                                          'Complete'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                              child: const Icon(
                                Iconsax.firstline,
                                color: kWhite,
                              ),
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          )
        : ClipPath(
            clipper: TCustomCurvedEdges(),
            child: Container(
              color: Colors.blueAccent,
              height: 200,
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: titleWidget == null
                          ? Center(
                              child: Text(
                                title,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            )
                          : Center(
                              child: titleWidget,
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      leading ??
                          Transform.translate(
                            offset: const Offset(-14, 0),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: BackButton(),
                                )),
                          ),
                      if (showActionIcon)
                        Transform.translate(
                          offset: const Offset(10, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: InkWell(
                              onTap: onMenuActionTap ??
                                  () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            width: double.maxFinite,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Check Your Answer Before Completing The Test',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium,
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height:
                                                        20), // Add some spacing
                                                Flexible(
                                                  child: GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: controller
                                                        .allQuestions.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          (Get.width ~/ 75),
                                                      childAspectRatio: 1,
                                                      crossAxisSpacing: 8,
                                                      mainAxisSpacing: 8,
                                                    ),
                                                    itemBuilder: (_, index) {
                                                      AnswerStatus?
                                                          answereStatus;
                                                      if (controller
                                                              .allQuestions[
                                                                  index]
                                                              .selectedAnswer !=
                                                          null) {
                                                        answereStatus =
                                                            AnswerStatus
                                                                .answered;
                                                      }
                                                      return QuestionNumberCard(
                                                          index: index + 1,
                                                          status: answereStatus,
                                                          onTap: () => controller
                                                              .jumpToQuestion(
                                                                  index));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Get.width / 3,
                                                  child: OutlinedButton(
                                                    onPressed: controller
                                                        .navigateToHome,
                                                    child: const Text('Keluar'),
                                                  ),
                                                ),
                                                const SizedBox(width: 8.0),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed:
                                                          controller.complete,
                                                      child: const Text(
                                                          'Complete'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                              child: const Icon(
                                Iconsax.firstline,
                                size: 40,
                                color: kWhite,
                              ),
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
