import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/constants/text_string.dart';
import 'package:projetpfe/features/screens/signup-widgets/widget/check_box_condition.dart';


class SignUpForm extends StatelessWidget {

  final first_controller = TextEditingController();
  final last_controller = TextEditingController();
  final user_controller = TextEditingController();
  final email_controller = TextEditingController();
  final phone_controller = TextEditingController();
  final pass_controller = TextEditingController();

  SignUpForm({
    super.key,
  });

  Future<void> signUpAndSaveUserDetails(String email, String password,String phone ,String username,String lastName,String firstName) async {
    User? user = await signUpWithEmailPassword(email, password);
    if (user != null) {
      await saveUserDetails(user.uid, username, lastName,firstName,phone);
    }
  }

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> saveUserDetails(String uid, String username,String phone ,String lastName,String firstName) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(uid).set({
        'username': username,
        'firstName': firstName,
        'lastName' : lastName,
        'phone' : phone,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: first_controller,
                  expands: false,
                  decoration: const InputDecoration(labelText: HTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: HSize.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: last_controller,
                  expands: false,
                  decoration: const InputDecoration(labelText: HTexts.lastName, prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: HSize.spaceBtwInputFields),
          TextFormField(
            controller: user_controller,

            decoration: const InputDecoration(labelText: HTexts.userName, prefixIcon: Icon(Iconsax.user)),
          ),
          const SizedBox(height: HSize.spaceBtwInputFields),
          TextFormField(
            controller: email_controller,

            decoration: const InputDecoration(labelText: HTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          TextFormField(
            controller: phone_controller,
            validator: (value) {
              if (value!.isEmpty || value.length < 10) {
                return "phone number must be 10 digits";
              } else {
                return null;
              }
            },
            //   focusNode: _focusNodes[0],

            decoration: const InputDecoration(
                hintText: "Your Phone",
                suffixIcon: Icon(
                  Icons.phone,
                )),
          ),
          const SizedBox(height: HSize.spaceBtwInputFields),
          TextFormField(
            controller: pass_controller,
            obscureText :true,
            decoration: const InputDecoration(labelText: HTexts.password, prefixIcon: Icon(Iconsax.password_check),suffixIcon: Icon(Iconsax.eye_slash),),
          ),
          const SizedBox(height: HSize.spaceBtwInputFields),
          const CheckBoxConditions(),
          const SizedBox(height: HSize.spaceBtwSections,),

          SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){
            signUpAndSaveUserDetails(
              email_controller.text,
              pass_controller.text,
              user_controller.text,
              last_controller.text,
              first_controller.text,
              phone_controller.text
            );
          }, child: const Text(HTexts.createAccount),),),
        ],
      ),
    );
  }
}

