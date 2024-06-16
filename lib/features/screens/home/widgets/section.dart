import 'package:flutter/material.dart';
import 'package:projetpfe/utils/helper_function.dart';


class HSectionHeading extends StatelessWidget {
  const HSectionHeading({
    super.key, required this.title,
  });
final String title;
  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunction.isDarkMode(context);
    return Row(
      children: [
        Text(title ,style: Theme.of(context).textTheme.headlineSmall!.apply(color:dark ? Colors.white : Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
      ],
    );
  }
}