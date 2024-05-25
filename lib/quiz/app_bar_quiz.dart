import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/quiz/quiz_overview_screen.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import '../util/etc/curved_edges.dart';

class AppBarQuizz extends StatelessWidget {
  const AppBarQuizz(
      {super.key,
      this.title = '',
      this.titleWidget,
      this.leading,
      this.showActionIcon = false,
      this.onMenuActionTap});

  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
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
                          style: Theme.of(context).textTheme.headlineMedium,
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
                            () => Get.toNamed(TestOverviewScreen.routeName),
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
    );
  }
}
