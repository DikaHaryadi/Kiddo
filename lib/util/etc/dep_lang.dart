// ignore_for_file: constant_identifier_names

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
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppLanguageConstant.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> jsonData = {};

    mappedJson.forEach((key, value) {
      jsonData[key] = value.toString();
    });

    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        jsonData;
  }

  return languages;
}
