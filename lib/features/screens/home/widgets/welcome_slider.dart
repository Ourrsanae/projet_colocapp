import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/features/controllers_onboarding/home_controller.dart';
import 'package:projetpfe/features/screens/home/widgets/carousel.dart';
import 'package:projetpfe/features/screens/home/widgets/circular_container.dart';
import 'package:projetpfe/themes/theme.dart';
import 'package:get/get.dart';

class HWelcomeSlider extends StatelessWidget {
  const HWelcomeSlider({
    super.key, required this.banners,
  });
final List<String> banners;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index,_)=>controller.upateIndicator(index),
          ),
          items: banners.map((url) => HRoundedImage(imageUrl: url)).toList(),
        ),
        const SizedBox(height: HSize.spaceBtwItems,),
        Center(
          child: Obx(
              ()=> Row(
                mainAxisSize: MainAxisSize.min,
              children: [
                for(int i = 0; i<banners.length;i++)HCircularContainer(width: 20, height: 4, margin: const EdgeInsets.only(right: 10),backgroundColor: controller.carouselCurrentIndex.value == i ? lightColorScheme.secondary : Colors.grey,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
