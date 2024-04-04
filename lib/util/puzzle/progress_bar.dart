import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      builder: (controller) {
        double percent = controller.percentCompleted.value;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: LinearProgressIndicator(
              color: Colors.amber,
              backgroundColor: Colors.grey,
              value: percent,
            ),
          ),
        );
      },
    );
  }
}
