import 'package:flutter/material.dart';
import 'package:projetpfe/themes/theme.dart';

class HChipTheme {
  HChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: lightColorScheme.outlineVariant.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: lightColorScheme.secondary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );
  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: darkColorScheme.outlineVariant.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: darkColorScheme.secondary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );
}