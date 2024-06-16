import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/constants/text_string.dart';
import 'package:projetpfe/features/screens/home/request/wish_list.dart';
import 'package:projetpfe/features/screens/widgets/appbar/appbar.dart';
import 'package:get/get.dart';

class HHomeAppBar extends StatelessWidget {
  const HHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            HTexts.homeTitle,
            style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.grey),),
        ],
      ),

      actions: [
        Stack(
          children: [
            IconButton(onPressed: () => Get.to(() => const HWishListView()), icon: const Icon(Iconsax.heart,color: Colors.white,)),
          ],
        )
      ],
    );
  }
}