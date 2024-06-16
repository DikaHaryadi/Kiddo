import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Dialogs {
  static final Dialogs _dialogs = Dialogs._internal();
  Dialogs._internal();

  factory Dialogs() {
    return _dialogs;
  }

  static Widget questionStartDialogue({required VoidCallback onTap}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi..',
            style:
                GoogleFonts.aBeeZee(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Text('Please login before you start+')
        ],
      ),
      actions: [TextButton(onPressed: onTap, child: const Text('Confirm'))],
    );
  }

  static Widget timesUpDialogue({required VoidCallback onTap}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Permainan Berakhir',
            style:
                GoogleFonts.aBeeZee(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Text("You've run out of time")
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Get.offAllNamed('/main-menu-quiz'),
            child: const Text('Keluar')),
        TextButton(onPressed: onTap, child: const Text('TryAgain?')),
      ],
    );
  }

  static Widget catchUpDialogue(
      {void Function()? tryAgain,
      void Function()? navigateBack,
      required String title,
      required String subtitle,
      TextStyle? titletextStyle,
      TextStyle? subtitleTextStyle}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titletextStyle,
          ),
          Text(
            subtitle,
            style: subtitleTextStyle,
          )
        ],
      ),
      actions: [
        TextButton(onPressed: tryAgain, child: const Text('Coba lagi')),
        TextButton(onPressed: navigateBack, child: const Text('Kembali?')),
      ],
    );
  }
}
