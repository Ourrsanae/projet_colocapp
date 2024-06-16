import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/constants/text_string.dart';
import 'package:projetpfe/features/screens/home/widgets/request/search_page.dart';
import 'package:projetpfe/utils/device.dart';
import 'package:projetpfe/utils/helper_function.dart';

class Search extends StatelessWidget {
  const Search({
    super.key, this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: HSize.defaultSpace),
        child: Container(
          width: HDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(HSize.md),
          decoration: BoxDecoration(
            color: dark ? Colors.black26 : Colors.white,
            borderRadius: BorderRadius.circular(HSize.cardRadiusLg),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              const Icon(Iconsax.search_normal, color: Colors.grey,),
              const SizedBox(width: HSize.sm,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(HTexts.search, style: Theme.of(context).textTheme.bodyMedium),
                  Text(HTexts.searchSecond, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
