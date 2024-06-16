import 'package:flutter/material.dart';
import 'package:projetpfe/themes/theme.dart';


class HElevatedButtonTheme{
  HElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: lightColorScheme.onPrimary,
      backgroundColor: lightColorScheme.secondary,
      disabledForegroundColor: lightColorScheme.outlineVariant,
      disabledBackgroundColor: lightColorScheme.outlineVariant,
      side: BorderSide(color: lightColorScheme.secondary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: TextStyle(fontSize: 16, color: lightColorScheme.onPrimary, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: darkColorScheme.onPrimary,
      backgroundColor: darkColorScheme.secondary,
      disabledForegroundColor: darkColorScheme.outlineVariant,
      disabledBackgroundColor: darkColorScheme.outlineVariant,
      side: BorderSide(color: darkColorScheme.secondary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: TextStyle(fontSize: 16, color: darkColorScheme.onPrimary, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}