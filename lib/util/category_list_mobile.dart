import 'package:flutter/material.dart';

class CategoryListNotifier with ChangeNotifier {
  final List<Map<String, String>> categoryList = [
    {'enum': 'Alphabet'},
    {
      'enum': 'Months',
    },
    {'enum': 'Numbers'},
    {'enum': 'Days'},
    {'enum': "etc"},
  ];

  final ValueNotifier<int?> selectedTab =
      ValueNotifier<int?>(0); // Set default value to 0

  void selectTab(int index) {
    selectedTab.value = index;
    notifyListeners();
  }
}
