import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/language_controller.dart';
import '../../models/lang_model.dart';

class AppLanguageConstant {
  static const String country_code = 'country_code';
  static const String language_code = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        languageName: 'Indonesia', languageCode: 'ID', countryCode: 'id'),
    LanguageModel(
        languageName: 'English', languageCode: 'US', countryCode: 'en'),
  ];
}

Future<Map<String, Map<String, String>>> init() async {
  final storage = await GetStorage.init();
  Get.lazyPut(() => storage);

  Get.lazyPut(() => LocalizationController(storage: GetStorage()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppLanguageConstant.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();

    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });

    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }

  return _languages;
}
