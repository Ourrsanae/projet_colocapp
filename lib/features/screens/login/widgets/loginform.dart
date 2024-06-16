import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/constants/text_string.dart';
import 'package:get/get.dart';
import 'package:projetpfe/features/screens/signup-widgets/signup/sign-up.dart';
import 'package:projetpfe/widgets/navigation_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HLoginForm extends StatelessWidget {
  final user_controller = TextEditingController();
  final pass_controller = TextEditingController();
  HLoginForm({
    super.key,
  });


  void signUserIn(BuildContext context) async {
    final String username = user_controller.text.trim();
    final String password = pass_controller.text.trim();


    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // Save the user ID in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userID', user.uid);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged In')),
        );
        Get.offAll(() => const NavigationMenu());
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('here')),
      );
      // You can navigate to the HomePage or perform actions if sign-in was successful
    } catch (e) {
      // Handle the error
      if (e is FirebaseAuthException) {
        // Firebase Authentication error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in: ${e.message}')),
        );
        if (e.code == 'user-not-found') {
          // Handle user not found error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign in: ${e.message}')),
          );
        } else if (e.code == 'wrong-password') {
          // Handle wrong password error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign in: ${e.message}')),
          );
        } else {
          // Handle other Firebase Authentication errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign in: ${e.message}')),
          );
        }
      } else {
        // Handle non-Firebase Authentication errors
        print('An unexpected error occurred: $e');
      }}}

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: HSize.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: user_controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: HTexts.email,
              ),
            ),
            const SizedBox(height: HSize.spaceBtwInputFields,),
            TextFormField(
              controller: pass_controller,

              obscureText :true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: HTexts.password,
                  suffixIcon: Icon(Iconsax.eye_slash)
              ),
            ),
            const SizedBox(height: HSize.spaceBtwInputFields / 2,),
            Row(
              children : [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value){}),
                    const Text(HTexts.remmeberMe),
                    const SizedBox(width: HSize.spaceBtwItems),
                    const SizedBox(width: HSize.spaceBtwItems),
                    TextButton(onPressed: (){}, child: const Text(HTexts.forgetPassword),),
                  ],
                ),
              ],
            ),
            const SizedBox(height: HSize.spaceBtwSections,),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed:() {  signUserIn(context);},child: const Text(HTexts.signin),),),
            const SizedBox(height: HSize.spaceBtwItems,),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> Get.to(() => const SignUpScreen()),child: const Text(HTexts.createAccount),),),
            const SizedBox(height: HSize.spaceBtwSections,),
          ],
        ),
      ),
    );
  }
}
