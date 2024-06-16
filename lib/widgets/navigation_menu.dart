import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/features/screens/home/home.dart';
import 'package:projetpfe/features/screens/home/request/new_annonce.dart';
import 'package:projetpfe/features/screens/nearme/nearme.dart';
import 'package:projetpfe/features/screens/profile/settings.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return SafeArea(
      child: FirebaseAuth.instance.currentUser != null
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          bottomNavigationBar: Obx(
                () => NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(
                    icon: Icon(Iconsax.home), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Iconsax.add_circle), label: 'New Annonce'),
                NavigationDestination(
                    icon: Icon(Iconsax.map), label: 'Near Me'),
                NavigationDestination(
                    icon: Icon(Iconsax.user), label: 'Profile'),
              ],
            ),
          ),
          body: Obx(
                () => controller.screens[controller.selectedIndex.value],
          ),
        ),
      )
          : const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomePage(),
    const NewAnnonce(),
    const MapScreen(),
    const SettingsScreen()
  ];
}
