import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projetpfe/features/screens/login/login.dart';
import 'package:get_storage/get_storage.dart';
  class OnboardingController extends GetxController{
    static OnboardingController get instance => Get.find();

    final pageController = PageController();
    Rx<int> currentPageIndex = 0.obs;

    void updatePageIndicator(index) => currentPageIndex.value = index;

    void dotNavigationClick(index){
     currentPageIndex.value = index;
     pageController.jumpTo(index);
    }

    void nextPage() {
      if(currentPageIndex.value==2){
        final storage = GetStorage();
        storage.write('IsFirstTime',false);
        Get.offAll(const LoginScreen());
      }else{
        int  page = currentPageIndex.value + 1;
        pageController.jumpToPage(page);
      }
    }

    void skipPage() {
      if(currentPageIndex.value==2){
        Get.offAll(const LoginScreen());
      }else{
        Get.offAll(const LoginScreen());

      }

    }
  }
