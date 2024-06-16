import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/utils/device.dart';
import 'package:get/get.dart';
class HAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HAppBar({super.key, this.title, this.actions, this.leadingIcon,this.leadingOnPressed,this.showBackArrow = false});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HSize.defaultSpace),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(onPressed: ()=>Get.back(), icon: const Icon(Iconsax.arrow_left)) :
            leadingIcon != null ? IconButton(onPressed:leadingOnPressed, icon: Icon(leadingIcon)) : null,
        title: title,
        actions: actions,

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight((HDeviceUtils.getAppBarHeight()));
}
