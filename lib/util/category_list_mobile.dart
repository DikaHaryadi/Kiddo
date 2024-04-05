import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryListNotifier with ChangeNotifier {
  final List<Map<String, String>> categoryList = [
    {'enum': 'Alphabet'},
    {'enum': 'Months'},
    {'enum': 'Numbers'},
    {'enum': 'Days'},
    {'enum': "etc"},
  ];

  late SharedPreferences _prefs;
  late ValueNotifier<int?> _selectedTab;

  CategoryListNotifier() {
    _selectedTab = ValueNotifier<int?>(
        0); // Inisialisasi dengan nilai default 0 (misalnya)
    initPreferences();
  }

  ValueNotifier<int?> get selectedTab => _selectedTab;

  Future<void> initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    final savedTab =
        _prefs.getInt('selectedTab') ?? 0; // Gunakan nilai default jika null
    _selectedTab.value =
        savedTab; // Set nilai _selectedTab setelah inisialisasi
    notifyListeners();
  }

  void selectTab(int index) {
    _selectedTab.value = index;
    _prefs.setInt('selectedTab', index);
    notifyListeners();
  }
}
