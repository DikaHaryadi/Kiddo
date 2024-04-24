import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/config/themes/app_colors.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: mainGradient(context)),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 65,
            ),
            SizedBox(height: 40),
            Text(
                'This is a study app. you can use it as you want. if you understand how it works you would be able to scale it with this you will master firebase backend and flutter front end',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: onSurfaceTextColor,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            Material(
              type: MaterialType.transparency,
              clipBehavior: Clip.hardEdge,
              shape: CircleBorder(),
              child: InkWell(
                onTap: () => Get.toNamed('/main-menu-quiz'),
                child: Icon(Icons.arrow_forward_ios),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
