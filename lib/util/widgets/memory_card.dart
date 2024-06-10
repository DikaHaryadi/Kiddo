import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:textspeech/util/widgets/card_item.dart';

class MemoryCard extends StatelessWidget {
  const MemoryCard({
    required this.card,
    required this.index,
    required this.onCardPressed,
    super.key,
  });

  final CardItem card;
  final int index;
  final ValueChanged<int> onCardPressed;

  void _handleCardTap() {
    if (card.state == CardState.hidden) {
      Timer(const Duration(milliseconds: 10), () {
        popClickSound();
        onCardPressed(index);
      });
    }
  }

  void popClickSound() async {
    final path = AssetSource('voices/pop.mp3');
    final audioplayer = AudioPlayer();
    await audioplayer.play(path);
    audioplayer.setVolume(1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleCardTap,
      child: Card(
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color:
            card.state == CardState.visible || card.state == CardState.guessed
                ? card.color
                : Colors.grey,
        child: Center(
          child: card.state == CardState.hidden
              ? null
              : SizedBox.expand(
                  child: FittedBox(
                    child: Icon(
                      card.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
