import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/themes/themeapp/vertical_icon_text.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_,index){
          return HVerticalIconText(title: 'Woman', icons: const Icon(Iconsax.woman),onTap: (){},);
        }
    );
  }
}