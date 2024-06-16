import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';

class HSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: HSize.appBarHeight,
    left: HSize.defaultSpace,
    bottom: HSize.defaultSpace,
    right: HSize.defaultSpace,
  );
}