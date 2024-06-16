import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/features/controllers_onboarding/onboarding_controller.dart';
import 'package:projetpfe/utils/device.dart';


class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: HSize.defaultSpace,
      bottom: HDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: ()=> OnboardingController.instance.nextPage,
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        child: const Icon(
          Iconsax.arrow_right_3,
        ),
      ),
    );
  }
}