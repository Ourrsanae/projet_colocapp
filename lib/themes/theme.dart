import 'package:flutter/material.dart';
import 'package:projetpfe/themes/themeapp/appbar.dart';
import 'package:projetpfe/themes/themeapp/bottom_sheet_theme.dart';
import 'package:projetpfe/themes/themeapp/checkbox_theme.dart';
import 'package:projetpfe/themes/themeapp/chip_theme.dart';
import 'package:projetpfe/themes/themeapp/elevated_button_theme.dart';
import 'package:projetpfe/themes/themeapp/outlined_button_theme.dart';
import 'package:projetpfe/themes/themeapp/text_field_theme.dart';
import 'package:projetpfe/themes/themeapp/text_theme.dart';


const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF53329D),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF3D239F),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFFC2C8BC),
  surface: Color(0xFFF9FAF3),
  onSurface: Color(0xFF1A1C18),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF53329D),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF3D239F),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFFC2C8BC),
  surface: Color(0xFFF9FAF3),
  onSurface: Color(0xFF1A1C18),
);
ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  textTheme: HTexttheme.lightTextTheme,
  chipTheme: HChipTheme.lightChipTheme,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: HAppBarTheme.LightAppBar,
  checkboxTheme: HCheckBoxTheme.lightCheckboxTheme,
  bottomSheetTheme: HBottomSheetTheme.lightBottomSheetTheme,
  elevatedButtonTheme: HElevatedButtonTheme.lightElevatedButtonTheme,
  outlinedButtonTheme: HOutlinedButtonTheme.lightOutlinedButtonTheme,
  inputDecorationTheme: HTextFieldTheme.lightInputDecorationTheme,
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: HTexttheme.darkTextTheme,
  chipTheme: HChipTheme.darkChipTheme,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: HAppBarTheme.darkAppBar,
  checkboxTheme: HCheckBoxTheme.darkCheckboxTheme,
  bottomSheetTheme: HBottomSheetTheme.darkBottomSheetTheme,
  elevatedButtonTheme: HElevatedButtonTheme.darkElevatedButtonTheme,
  outlinedButtonTheme: HOutlinedButtonTheme.darkOutlinedButtonTheme,
  inputDecorationTheme: HTextFieldTheme.darkInputDecorationTheme,
);
