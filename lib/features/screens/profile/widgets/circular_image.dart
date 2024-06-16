import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';

class HCircularImage extends StatelessWidget {
  const HCircularImage({
    super.key,
    required this.image,
    this.onTap,
    required this.width,
    required this.height,
    this.padding = HSize.sm,
  });

  final String image;
  final double width, height, padding;
  final void Function()? onTap;

  bool _isNetworkImage(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    bool isNetworkImage = _isNetworkImage(image);
    bool isLocalFile = !isNetworkImage && File(image).existsSync();

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipOval(
            child: isNetworkImage
                ? Image.network(image, fit: BoxFit.cover, width: width, height: height)
                : isLocalFile
                ? Image.file(File(image), fit: BoxFit.cover, width: width, height: height)
                : Image.asset(image, fit: BoxFit.cover, width: width, height: height),
          ),
        ),
      ),
    );
  }
}
