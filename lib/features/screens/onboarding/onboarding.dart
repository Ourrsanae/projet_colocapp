import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetpfe/constants/images.dart';
import 'package:projetpfe/constants/text_string.dart';
import 'package:projetpfe/features/controllers_onboarding/onboarding_controller.dart';
import 'package:projetpfe/features/screens/onboarding/widgets/onboarding_do_navigation.dart';
import 'package:projetpfe/features/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:projetpfe/features/screens/onboarding/widgets/onboarding_page.dart';
import 'package:projetpfe/features/screens/onboarding/widgets/onboarding_skip.dart';




class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: HImages.onboarding1,
                title: HTexts.welcomeTitle,
                subTitle: HTexts.welcomesubTitle,
              ),
              OnBoardingPage(
                image: HImages.onboarding2,
                title: HTexts.secondTitle,
                subTitle: HTexts.secondsubTitle,
              ),
              OnBoardingPage(
                image: HImages.onboarding3,
                title: HTexts.thirdTitle,
                subTitle: HTexts.thirdsubTitle,
              ),
            ],
          ),

          const OnboardingSkip(),

          const OnboardingDoNavigation(),

          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}





