import 'package:flutter/material.dart';
import 'package:textspeech/util/config/themes/sub_theme_data_mixin.dart';

const Color primaryLightColorLight = Color(0xFFC7CEEA);
const Color primaryColorLight = Color(0XFFB5EAD7);
const Color secondaryLightColorLight = Color(0XFFF8F7F0);
const Color secondaryColorLight = Color(0xFFE2F0CB);
const Color aksenLightColorLight = Color(0xFFFFDAC1);
const Color aksenColorLight = Color(0xFFFFB7B2);
const Color lastColorLight = Color(0xFFFF9AA2);

const Color mainTextColor = Color.fromARGB(255, 40, 40, 40);

class LightTheme with SubThemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        iconTheme: getIconTheme(),
        textTheme: getTextThemes()
            .apply(bodyColor: mainTextColor, displayColor: mainTextColor));
  }
}
