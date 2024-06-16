import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';


class HRoundedImage extends StatelessWidget {
  const HRoundedImage({
    super.key,
    this.width ,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = false,
    this.border,
    this.fit = BoxFit.contain,
    this.backgroundColor = Colors.white70,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed, this.borderRadius = HSize.lg,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final BoxFit fit;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius:  BorderRadius.circular(borderRadius) ,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: isNetworkImage
              ? Image.network(
            imageUrl,
            fit: fit,
          )
              : Image.asset(
            imageUrl,
            fit: fit,
          ),
        ),
      ),
    );
  }
}