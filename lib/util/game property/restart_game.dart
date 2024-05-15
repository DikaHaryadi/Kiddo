import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/interface/game/game_ui.dart';
import 'package:textspeech/util/widgets/game_controls_bottomsheet.dart';

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
      return const MemoryGameHome();
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
            ? const Icon(Iconsax.pause)
            : const Icon(Iconsax.play_circle),
      ),
    );
  }
}
