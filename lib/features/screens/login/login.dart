import 'package:flutter/material.dart';
import 'package:projetpfe/common/styles/spacing_styles.dart';
import 'package:projetpfe/features/screens/login/widgets/loginform.dart';
import 'package:projetpfe/features/screens/login/widgets/loginheader.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Padding(
              padding: HSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                children: [
                   const HLoginHeader(),
                   HLoginForm(),
                ],
              ),
            ),
          ),
    );
  }
}




