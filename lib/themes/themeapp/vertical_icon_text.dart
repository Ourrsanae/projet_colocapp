import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/utils/helper_function.dart';

class HVerticalIconText extends StatelessWidget {
  const HVerticalIconText({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.onTap,
    required this.icons,
    this.IconColor = Colors.black54,
  });
  final String title;
  final Icon icons;
  final Color? IconColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: HSize.spaceBtwItems),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding:const EdgeInsets.all(HSize.sm),
              decoration: BoxDecoration(
                color: backgroundColor ?? (dark ? Colors.black : Colors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Icon(icons.icon,
                  color: IconColor ?? (dark ? Colors.white : Colors.black54),),
              ),
            ),
            const SizedBox(height: HSize.spaceBtwItems / 2,),
            SizedBox(width: 45,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.apply(color: backgroundColor ?? (dark ? Colors.black : Colors.white)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
