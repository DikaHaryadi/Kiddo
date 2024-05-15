import 'package:flutter/material.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: kDarkGrey,
    suffixIconColor: kDarkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        fontSize: 16.0, color: const Color(0xFF272727), fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(
        fontSize: 14.0, color: const Color(0xFF656565), fontFamily: 'Urbanist'),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: const Color(0xFF656565), fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 1, color: kBorderPrimary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 1, color: kBorderPrimary),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 1, color: kBorderSecondary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 1, color: kError),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 2, color: kError),
    ),
  );

  // static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  //   errorMaxLines: 2,
  //   prefixIconColor: kDarkGrey,
  //   suffixIconColor: kDarkGrey,
  //   // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
  //   labelStyle: const TextStyle()
  //       .copyWith(fontSize: 16.0, color: TColors.white, fontFamily: 'Urbanist'),
  //   hintStyle: const TextStyle()
  //       .copyWith(fontSize: 14.0, color: TColors.white, fontFamily: 'Urbanist'),
  //   floatingLabelStyle: const TextStyle().copyWith(
  //       color: TColors.white.withOpacity(0.8), fontFamily: 'Urbanist'),
  //   border: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(12.0),
  //     borderSide: const BorderSide(width: 1, color: kDarkGrey),
  //   ),
  //   enabledBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(12.0),
  //     borderSide: const BorderSide(width: 1, color: kDarkGrey),
  //   ),
  //   focusedBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(12.0),
  //     borderSide: const BorderSide(width: 1, color: TColors.white),
  //   ),
  //   errorBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(12.0),
  //     borderSide: const BorderSide(width: 1, color: kError),
  //   ),
  //   focusedErrorBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(12.0),
  //     borderSide: const BorderSide(width: 2, color: kError),
  //   ),
  // );
}
