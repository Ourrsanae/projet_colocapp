import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/features/screens/home/home.dart';
import 'package:projetpfe/utils/device.dart';
import 'package:get/get.dart';

class skipPage extends StatelessWidget {
  const skipPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: HDeviceUtils.getAppBarHeight(),
      right: HSize.defaultSpace,
      child: TextButton(
        onPressed: () => Get.to(() => const HomePage()),
        child: const Text('skip'),
      ),
    );
  }
}