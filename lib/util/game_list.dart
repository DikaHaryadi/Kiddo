import 'package:flutter/material.dart';

class GameListNotifier with ChangeNotifier {
  final List<Map<String, String>> gameList = [
    {
      'GameName': 'Memo Game',
      'imagePath': 'assets/banner_game.png',
      'enum': 'Memory'
    },
    {
      'GameName': 'Summation',
      'imagePath': 'assets/games/memo.png',
      'enum': 'Summation'
    },
  ];

  final ValueNotifier<int?> selectedTab =
      ValueNotifier<int?>(0); // Set default value to 0

  void selectTab(int index) {
    selectedTab.value = index;
    notifyListeners();
  }
}
