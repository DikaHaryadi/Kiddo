import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:textspeech/util/widgets/card_item.dart';
import 'package:textspeech/util/game%20property/icon_game.dart';

class Game {
  Game(this.gridSize) {
    generateCards();
    player = AudioPlayer();
  }

  final int gridSize;
  List<CardItem> cards = [];
  bool isGameOver = false;
  Set<IconData> icons = {};
  late AudioPlayer player;
  bool isProcessing = false; // New flag to check if a pair is being processed

  void dispose() {
    player.dispose();
  }

  void generateCards() {
    generateIcons();
    cards = [];
    final List<Color> cardColors = Colors.primaries.toList();
    for (int i = 0; i < (gridSize * gridSize / 2); i++) {
      final cardValue = i + 1;
      final IconData icon = icons.elementAt(i);
      final Color cardColor = cardColors[i % cardColors.length];
      final List<CardItem> newCards =
          _createCardItems(icon, cardColor, cardValue);
      cards.addAll(newCards);
    }
    cards.shuffle(Random());
  }

  void generateIcons() {
    icons = <IconData>{};
    for (int j = 0; j < (gridSize * gridSize / 2); j++) {
      final IconData icon = _getRandomCardIcon();
      icons.add(icon);
      icons.add(icon); // Add the icon twice to ensure pairs are generated.
    }
  }

  void resetGame() {
    generateCards();
    isGameOver = false;
    isProcessing = false; // Reset the processing flag
  }

  void onCardPressed(int index) {
    if (isProcessing ||
        cards[index].state == CardState.guessed ||
        cards[index].state == CardState.visible) {
      return; // Ignore click if a pair is being processed or the card is already guessed/visible
    }

    cards[index].state = CardState.visible;
    final List<int> visibleCardIndexes = _getVisibleCardIndexes();

    if (visibleCardIndexes.length == 2) {
      isProcessing = true; // Set the processing flag
      final CardItem card1 = cards[visibleCardIndexes[0]];
      final CardItem card2 = cards[visibleCardIndexes[1]];

      if (card1.value == card2.value) {
        // Play correct sound
        player.play(AssetSource('voices/Correct_1.mp3'));
        card1.state = CardState.guessed;
        card2.state = CardState.guessed;
        isProcessing =
            false; // Reset the processing flag immediately as the cards are guessed
        isGameOver = _isGameOver();
      } else {
        // Delay hiding the cards for 500 milliseconds to speed up the game
        Future.delayed(const Duration(milliseconds: 800), () {
          card1.state = CardState.hidden;
          card2.state = CardState.hidden;
          isProcessing = false; // Reset the processing flag after the delay
        });
      }
    }
  }

  List<CardItem> _createCardItems(
      IconData icon, Color cardColor, int cardValue) {
    return List.generate(
      2,
      (index) => CardItem(
        value: cardValue,
        icon: icon,
        color: cardColor,
      ),
    );
  }

  IconData _getRandomCardIcon() {
    final Random random = Random();
    IconData icon;
    do {
      icon = cardIcons[random.nextInt(cardIcons.length)];
    } while (icons.contains(icon));
    return icon;
  }

  List<int> _getVisibleCardIndexes() {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state == CardState.visible)
        .map((entry) => entry.key)
        .toList();
  }

  bool _isGameOver() {
    return cards.every((card) => card.state == CardState.guessed);
  }
}
