import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/constants/text_string.dart';
import 'package:projetpfe/themes/theme.dart';
import 'package:projetpfe/utils/helper_function.dart';


class CheckBoxConditions extends StatelessWidget {
  const CheckBoxConditions({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunction.isDarkMode(context);
    return Row(
      children: [
        SizedBox(width: 24,height: 24,child: Checkbox(value: true, onChanged: (value){})),
        const SizedBox(width: HSize.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: HTexts.iAgreaTo, style: Theme.of(context).textTheme.bodySmall,),
              TextSpan(text: HTexts.privacyPolicy, style:Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? Colors.white : lightColorScheme.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark ? Colors.white : lightColorScheme.primary,
              ),),
              TextSpan(text: ' and', style: Theme.of(context).textTheme.bodySmall,),
              TextSpan(text: HTexts.termsOfUse, style:Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? Colors.white : lightColorScheme.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark ? Colors.white : lightColorScheme.primary,
              ),),
            ],
          ),
        ),
      ],
    );
  }
}