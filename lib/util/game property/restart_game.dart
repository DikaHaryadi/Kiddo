import 'dart:async';

import 'package:flutter/material.dart';
import 'package:textspeech/interface/game_ui.dart';
import 'package:textspeech/util/widgets/game_controls_bottomsheet.dart';
import 'package:unicons/unicons.dart';

class RestartGame extends StatefulWidget {
  const RestartGame({
    required this.isGameOver,
    required this.pauseGame,
    required this.restartGame,
    required this.continueGame,
    this.color = Colors.white,
    super.key,
  });

  final VoidCallback pauseGame;
  final VoidCallback restartGame;
  final VoidCallback continueGame;
  final bool isGameOver;
  final Color color;

  @override
  State<RestartGame> createState() => _RestartGameState();
}

class _RestartGameState extends State<RestartGame> {
  Future<void> showGameControls(BuildContext context) async {
    widget.pauseGame();

    var value = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const GameControlsBottomSheet();
      },
    );

    value ??= false;

    if (value) {
      widget.restartGame();
    } else {
      widget.continueGame();
    }
  }

  void navigateback(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
      return const StartUpPage();
    }), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          widget.isGameOver ? navigateback(context) : showGameControls(context),
      child: CircleAvatar(
        minRadius: 15,
        maxRadius: 20,
        backgroundColor: const Color(0xFF8dbffa),
        child: widget.isGameOver
            ? const Icon(UniconsLine.pause)
            : const Icon(UniconsLine.play),
      ),
    );
  }
}
