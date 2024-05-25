import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key, this.color, required this.time});

  final Color? color;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Iconsax.clock,
          color: color ?? kWhite,
        ),
        const SizedBox(width: 5.0),
        Text(
          time,
          style: Theme.of(context).textTheme.headlineMedium?.apply(
                color: color ?? kWhite,
              ),
        )
      ],
    );
  }
}
