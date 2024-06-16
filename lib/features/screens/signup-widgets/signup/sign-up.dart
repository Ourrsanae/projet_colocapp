import 'package:flutter/material.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/constants/text_string.dart';
import 'package:projetpfe/features/screens/signup-widgets/widget/signupform.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(HTexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: HSize.spaceBtwSections,),

              SignUpForm(),

            ],
          ),
        ),
      ),
    );
  }
}


