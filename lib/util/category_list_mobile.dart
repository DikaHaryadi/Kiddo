import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CategoryListNotifier with ChangeNotifier {
  final List<Map<String, String>> categoryList = [
    {'enum': "All"},
    {'enum': 'Alphabet'},
    {'enum': 'Months'},
    {'enum': 'Numbers'},
    {'enum': 'Days'},
  ];

  late final GetStorage _prefs;
  late final ValueNotifier<int?> _selectedTab;

  CategoryListNotifier() {
    _selectedTab = ValueNotifier<int?>(
        0); // Inisialisasi dengan nilai default 0 (misalnya)
    initPreferences();
  }

  ValueNotifier<int?> get selectedTab => _selectedTab;

  Future<void> initPreferences() async {
    await GetStorage.init();
    _prefs = GetStorage();
    final savedTab =
        _prefs.read('selectedTab') ?? 0; // Gunakan nilai default jika null
    _selectedTab.value =
        savedTab; // Set nilai _selectedTab setelah inisialisasi
    notifyListeners();
  }

  void selectTab(int index) {
    _selectedTab.value = index;
    _prefs.write('selectedTab', index);
    notifyListeners();
  }
}
