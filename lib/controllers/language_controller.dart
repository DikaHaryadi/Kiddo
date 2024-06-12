import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:textspeech/models/lang_model.dart';
import 'package:textspeech/util/etc/dep_lang.dart';

class LocalizationController extends GetxController implements GetxService {
  final GetStorage storage;

  LocalizationController({required this.storage}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppLanguageConstant.languages[0].languageCode,
      AppLanguageConstant.languages[0].countryCode);
  int _selectedIndex = 0;

  List<LanguageModel> _languages = [];

  int get selectedIndex => _selectedIndex;
  Locale get locale => _locale;
  List<LanguageModel> get languages => _languages;

  void loadCurrentLanguage() async {
    // only gets called during installation or reboot
    _locale = Locale(
        storage.read(AppLanguageConstant.language_code) ??
            AppLanguageConstant.languages[0].languageCode,
        storage.read(AppLanguageConstant.country_code) ??
            AppLanguageConstant.languages[0].countryCode);

    for (int index = 0; index < AppLanguageConstant.languages.length; index++) {
      if (AppLanguageConstant.languages[index].languageCode ==
          _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppLanguageConstant.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void saveLanguage(Locale locale) async {
    storage.write(AppLanguageConstant.language_code, locale.languageCode);
    storage.write(AppLanguageConstant.country_code, locale.countryCode);
  }
}
