import 'package:flutter/material.dart';
import 'package:projetpfe/themes/theme.dart';


class HCircularContainer extends StatelessWidget {
  HCircularContainer( {
    super.key,
    this.width = 400,
    this.height =400,
    this.padding,
    this.child,
    this.backgroundColor = Colors.white,
    this.radius = 20,  this.margin,
    this.showBorder = false,
    this.borderColor =Colors.white,
  });
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool showBorder;
  final Color borderColor;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}