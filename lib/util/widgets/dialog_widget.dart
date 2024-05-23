import 'package:flutter/material.dart';
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
}
