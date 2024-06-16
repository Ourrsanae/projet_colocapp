import 'package:flutter/material.dart';
import 'package:projetpfe/themes/theme.dart';

class HAppBarTheme{
  HAppBarTheme._();

  static var LightAppBar = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: lightColorScheme.shadow,size: 24),
    toolbarTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: lightColorScheme.shadow),
  );
  static var darkAppBar = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: darkColorScheme.shadow,size: 24),
    toolbarTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: darkColorScheme.shadow),
  );
}