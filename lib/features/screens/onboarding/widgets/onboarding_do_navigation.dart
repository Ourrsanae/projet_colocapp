
import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/features/controllers_onboarding/onboarding_controller.dart';
import 'package:projetpfe/utils/device.dart';
import 'package:projetpfe/utils/helper_function.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingDoNavigation extends StatelessWidget {
  const OnboardingDoNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final dark = HHelperFunction.isDarkMode(context);
    return Positioned(
      bottom: HDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: HSize.defaultSpace,
      child:SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(activeDotColor: dark ? Colors.white:Colors.black12, dotHeight: 6),
      ),);
  }
}
