import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/constants/images.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/features/screens/home/request/wish_list.dart';
import 'package:projetpfe/features/screens/home/widgets/primary_header_container.dart';
import 'package:projetpfe/features/screens/profile/edit_information.dart';
import 'package:projetpfe/features/screens/profile/edit_profile.dart';
import 'package:projetpfe/features/screens/profile/widgets/circular_image.dart';
import 'package:projetpfe/features/screens/profile/widgets/settings_menu_tile.dart';
import 'package:projetpfe/features/screens/home/widgets/section.dart';
import 'package:projetpfe/features/screens/login/login.dart';
import 'package:projetpfe/features/screens/profile/widgets/user_post.dart';
import 'package:projetpfe/features/screens/widgets/appbar/appbar.dart';
import 'package:projetpfe/constants/images.dart';
class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  Future<Map<String, String?>> _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>?; // Safely cast to a Map
        String? username = data?['username'];
        String? firstName = data?['firstName'];
        String? lastName = data?['lastName'];
        String? imageUrl = data != null && data.containsKey('imageUrl') ? data['imageUrl'] : null; // Check if imageUrl exists
        return {
          'username': username,
          'firstName': firstName,
          'lastName': lastName,
          'imageUrl': imageUrl, // Include image URL if it exists
        };
      }
    }
    return {
      'username': 'Unknown',
      'firstName': 'Unknown',
      'lastName': 'Unknown',
      'imageUrl': null, // Default value for image URL
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, String?>>(
        future: _fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            String? username = snapshot.data?['username'];
            String? firstName = snapshot.data?['firstName'];
            String? lastName = snapshot.data?['lastName'];
            String? imageUrl = snapshot.data?['imageUrl']; // Fetch the image URL

            return SingleChildScrollView(
              child: Column(
                children: [
                  HPrimaryHeaderContainer(
                    child: Column(
                      children: [
                        HAppBar(
                          title: Text(
                            "Account",
                            style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: HSize.spaceBtwSections),
                        ListTile(
                          leading: HCircularImage(
                            image: imageUrl ?? HImages.accountIcon, // Use the fetched image URL or fallback to a default image
                            height: 50,
                            width: 50,
                            padding: 0,
                          ),
                          title: Text(
                            username ?? 'Unknown',
                            style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),
                          ),
                          subtitle: Text(
                            '$firstName $lastName',
                            style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: HSize.spaceBtwSections),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(HSize.defaultSpace),
                    child: Column(
                      children: [
                        const HSectionHeading(title: 'Account Settings'),
                        const SizedBox(height: HSize.spaceBtwItems),
                        HSettingsMenuTile(
                          icon: Iconsax.user_edit,
                          title: 'Edit Profile',
                          subtitle: 'Personal Information',
                          onTap: () => Get.to(() => const EditProfile()),
                        ),
                        HSettingsMenuTile(
                          icon: Iconsax.airdrop,
                          title: 'Edit Information',
                          subtitle: 'Preferences Information',
                          onTap: () => Get.to(() => HEditInformation(annonceId: 'someAnnonceId')), // Adjust this line if necessary
                        ),
                        HSettingsMenuTile(
                          icon: Iconsax.like,
                          title: 'Wish List',
                          subtitle: 'Your Preferences Post',
                          onTap: () => Get.to(() => const HWishListView()),
                        ),
                        HSettingsMenuTile(
                          icon: Iconsax.add_circle,
                          title: 'Your Post',
                          subtitle: 'Edit Your Post',
                          onTap: () => Get.to(() => const UserPostsList()), // Adjust this line if necessary
                        ),
                        const SizedBox(height: HSize.spaceBtwItems),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => Get.to(() => const LoginScreen()),
                            child: const Text('LogOut'),
                          ),
                        ),
                        const SizedBox(height: HSize.spaceBtwSections * 2.5),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}


