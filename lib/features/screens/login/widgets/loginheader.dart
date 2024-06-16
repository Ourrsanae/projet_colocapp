import 'package:flutter/material.dart';
import 'package:projetpfe/constants/images.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/constants/text_string.dart';
import 'package:projetpfe/features/screens/widgets/skippage.dart';


class HLoginHeader extends StatelessWidget {
  const HLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const skipPage(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              height: 150,
              image: AssetImage(HImages.darkAppIcon),
            ),
            Text(
              HTexts.loginTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: HSize.sm,),
            Text(
              HTexts.welcomesubTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
