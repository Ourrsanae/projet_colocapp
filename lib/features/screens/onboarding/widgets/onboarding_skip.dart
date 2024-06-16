import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/features/controllers_onboarding/onboarding_controller.dart';
import 'package:projetpfe/utils/device.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: HDeviceUtils.getAppBarHeight(),
      right: HSize.defaultSpace,
      child: TextButton(
        onPressed: () => OnboardingController.instance.skipPage(),
        child: const Text('skip'),
      ),
    );
  }
}
