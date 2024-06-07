import 'package:flutter/material.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/widgets/text_field_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF272727),
    textTheme: CTextTheme.lightTextTheme,
    chipTheme: KChipTheme.lightChipTheme,
    appBarTheme: CAppBarTheme.lightAppBarTheme,
    checkboxTheme: KCheckboxTheme.lightCheckboxTheme,
    scaffoldBackgroundColor: kPrimaryBackground,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  // Desktop Themes
  static ThemeData lightDesktopTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF272727),
    textTheme: CTextTheme.lightDesktopTextTheme,
    // chipTheme: KChipTheme.lightDesktopChipTheme,
    appBarTheme: CAppBarTheme.lightDesktopAppBarTheme,
    checkboxTheme: KCheckboxTheme.lightCheckboxTheme,
    scaffoldBackgroundColor: kPrimaryBackground,
    // bottomSheetTheme: TBottomSheetTheme.lightDesktopBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightDesktopElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightDesktopOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightDesktopInputDecorationTheme,
  );

  // DarkMode
  // static ThemeData darkTheme = ThemeData(
  //   useMaterial3: true,
  //   fontFamily: 'Urbanist',
  //   disabledColor: TColors.grey,
  //   brightness: Brightness.dark,
  //   primaryColor: kPrimary,
  //   textTheme: CTextTheme.darkTextTheme,
  //   chipTheme: KChipTheme.darkChipTheme,
  //   appBarTheme: CAppBarTheme.darkAppBarTheme,
  //   checkboxTheme: KCheckboxTheme.darkCheckboxTheme,
  //   scaffoldBackgroundColor: kPrimary.withOpacity(0.1),
  //   bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
  //   elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
  //   outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
  //   inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  // );
}

/// Custom Class for Light & Dark Text Themes
class CTextTheme {
  CTextTheme._(); // To avoid creating instances

  /// Mobile Text Theme
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(
        fontFamily: 'Kiddosy',
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF272727)),
    displayMedium: const TextStyle().copyWith(
        fontFamily: 'Kiddosy',
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF272727)),
    displaySmall: const TextStyle().copyWith(
        fontFamily: 'Kiddosy',
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF272727)),
    headlineLarge: const TextStyle().copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF272727)),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF272727)),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF272727)),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF272727)),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: kTextSecondary),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: kTextSecondary),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF272727)),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF272727)),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: kTextSecondary),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF272727)),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: kTextSecondary),
  );

  // Tablet Text Theme
  static TextTheme lightDesktopTextTheme = TextTheme(
    displayMedium: const TextStyle().copyWith(
        fontFamily: 'Kiddosy',
        fontSize: 50.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF272727)),
    displaySmall: const TextStyle().copyWith(
        fontFamily: 'Kiddosy',
        fontSize: 40.0,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF272727)),
    headlineLarge: const TextStyle().copyWith(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF272727)),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF272727)),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF272727)),
    titleLarge: const TextStyle().copyWith(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF272727)),
    titleMedium: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: kTextSecondary),
    titleSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: kTextSecondary),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF272727)),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF272727)),
    bodySmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: kTextSecondary),
    labelLarge: const TextStyle().copyWith(
        fontSize: 22.0,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF272727)),
    labelMedium: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.normal, color: kTextSecondary),
  );

  /// Customizable Dark Text Theme
  // static TextTheme darkTextTheme = TextTheme(
  //   headlineLarge: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.bold, color: kLight),
  //   headlineMedium: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.bold, color: kLight),
  //   headlineSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: kLight),

  //   titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.bold, color: kLight),
  //   titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: kLight),
  //   titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: kLight),

  //   bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, color: kLight),
  //   bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: kLight),
  //   bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w400, color: kLight.withOpacity(0.5)),

  //   labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: kLight),
  //   labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: kLight.withOpacity(0.5)),
  // );
}

class KChipTheme {
  KChipTheme._();

  static ChipThemeData lightChipTheme = const ChipThemeData(
    checkmarkColor: kWhite,
    selectedColor: Color(0xFF272727),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: Color(0xFF272727), fontFamily: 'Urbanist'),
  );

  // static ChipThemeData darkChipTheme = const ChipThemeData(
  //   checkmarkColor: kWhite,
  //   selectedColor: kPrimary,
  //   disabledColor: TColors.darkerGrey,
  //   padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
  //   labelStyle: TextStyle(color: kWhite, fontFamily: 'Urbanist'),
  // );
}

class CAppBarTheme {
  CAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: kIconPrimary, size: 24.0),
    actionsIconTheme: IconThemeData(color: kIconPrimary, size: 24.0),
    titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF272727),
        fontFamily: 'Urbanist'),
  );

  static const lightDesktopAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: kIconPrimary, size: 40.0),
    actionsIconTheme: IconThemeData(color: kIconPrimary, size: 40.0),
    titleTextStyle: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF272727),
        fontFamily: 'Urbanist'),
  );
  // static const darkAppBarTheme = AppBarTheme(
  //   elevation: 0,
  //   centerTitle: false,
  //   scrolledUnderElevation: 0,
  //   backgroundColor: TColors.dark,
  //   surfaceTintColor: TColors.dark,
  //   iconTheme: IconThemeData(color: Color(0xFF272727), size: 24.0),
  //   actionsIconTheme: IconThemeData(color: kWhite, size: 24.0),
  //   titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: kWhite, fontFamily: 'Urbanist'),
  // );
}

/// Custom Class for Light & Dark Text Themes
class KCheckboxTheme {
  KCheckboxTheme._(); // To avoid creating instances

  /// Customizable Mobile Light Text Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return kWhite;
      } else {
        return const Color(0xFF272727);
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return kPrimary;
      } else {
        return Colors.transparent;
      }
    }),
  );

  /// Customizable Dark Text Theme
  // static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
  //   shape:
  //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  //   checkColor: MaterialStateProperty.resolveWith((states) {
  //     if (states.contains(MaterialState.selected)) {
  //       return kWhite;
  //     } else {
  //       return Color(0xFF272727);
  //     }
  //   }),
  //   fillColor: MaterialStateProperty.resolveWith((states) {
  //     if (states.contains(MaterialState.selected)) {
  //       return kPrimary;
  //     } else {
  //       return Colors.transparent;
  //     }
  //   }),
  // );
}

class TBottomSheetTheme {
  TBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: kWhite,
    modalBackgroundColor: kWhite,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  // static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
  //   showDragHandle: true,
  //   backgroundColor: kBlack,
  //   modalBackgroundColor: kBlack,
  //   constraints: const BoxConstraints(minWidth: double.infinity),
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  // );
}

/* -- Light & Dark Elevated Button Themes -- */
class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Mobile Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: kLight,
      backgroundColor: kButtonPrimary,
      disabledForegroundColor: const Color(0xFF272727),
      side: const BorderSide(color: kBlack),
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      textStyle: const TextStyle(
          fontSize: 16,
          color: kWhite,
          fontWeight: FontWeight.w500,
          fontFamily: 'Urbanist'),
    ),
  );

  // Light Tablet Theme

  static final lightDesktopElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: kLight,
    backgroundColor: kButtonPrimary,
    disabledForegroundColor: const Color(0xFF272727),
    side: const BorderSide(color: kBlack),
    padding: const EdgeInsets.symmetric(vertical: 22.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    textStyle: const TextStyle(
        fontSize: 20,
        color: kWhite,
        fontWeight: FontWeight.w500,
        fontFamily: 'Urbanist'),
  ));

  /* -- Dark Theme -- */
  // static final darkElevatedButtonTheme = ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     elevation: 0,
  //     foregroundColor: kLight,
  //     backgroundColor: kPrimary,
  //     disabledForegroundColor: Color(0xFF272727)Grey,
  //     disabledBackgroundColor: TColors.darkerGrey,
  //     side: const BorderSide(color: kPrimary),
  //     padding: const EdgeInsets.symmetric(vertical: 18.0),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //     textStyle: const TextStyle(fontSize: 16, color: TColors.textWhite, fontWeight: FontWeight.w600, fontFamily: 'Urbanist'),
  //   ),
  // );
}

/* -- Light & Dark Outlined Button Themes -- */
class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: const Color(0xFF272727),
      side: const BorderSide(color: kBorderPrimary),
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      textStyle: const TextStyle(
          fontSize: 16,
          color: kBlack,
          fontWeight: FontWeight.w600,
          fontFamily: 'Urbanist'),
    ),
  );

  // OutlineButton Tablet
  static final lightDesktopOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: const Color(0xFF272727),
      side: const BorderSide(color: kBorderPrimary),
      padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      textStyle: const TextStyle(
          fontSize: 20,
          color: kBlack,
          fontWeight: FontWeight.w600,
          fontFamily: 'Urbanist'),
    ),
  );

  /* -- Dark Theme -- */
  // static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
  //   style: OutlinedButton.styleFrom(
  //     foregroundColor: TColors.light,
  //     side: const BorderSide(color: kBorderPrimary),
  //     padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //     textStyle: const TextStyle(fontSize: 16, color: TColors.textWhite, fontWeight: FontWeight.w600, fontFamily: 'Urbanist'),
  //   ),
  // );
}
