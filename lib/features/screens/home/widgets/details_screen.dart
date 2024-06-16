import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/features/screens/home/widgets/curved_edges_widget.dart';
import 'package:projetpfe/features/screens/profile/widgets/circular_image.dart';
import 'package:projetpfe/features/screens/widgets/appbar/appbar.dart';
import 'package:projetpfe/utils/helper_function.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnnonceDetails extends StatefulWidget {
  final String annonceId;

  const AnnonceDetails({required this.annonceId, Key? key}) : super(key: key);

  @override
  _AnnonceDetailsState createState() => _AnnonceDetailsState();
}

class _AnnonceDetailsState extends State<AnnonceDetails> {
  bool isInWishlist = false;

  @override
  void initState() {
    super.initState();
    _checkIfInWishlist();
  }

  String _formatPhoneNumber(String? phone) {
    if (phone == null) return '';
    if (phone.startsWith('0')) {
      return '+212${phone.substring(1)}';
    } else if (phone.startsWith('+212')) {
      return phone;
    } else if (phone.startsWith('6') || phone.startsWith('7')) {
      return '+212$phone';
    } else {
      return phone; // Assume it's already a valid international format
    }
  }

  Future<void> _checkIfInWishlist() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final wishlistDoc = await FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userId)
        .collection('items')
        .doc(widget.annonceId)
        .get();

    setState(() {
      isInWishlist = wishlistDoc.exists;
    });
  }

  Future<void> _addToWishlist() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userId)
        .collection('items')
        .doc(widget.annonceId)
        .set({
      'addedAt': FieldValue.serverTimestamp(),
    });

    setState(() {
      isInWishlist = true;
    });
  }

  Future<void> _removeFromWishlist() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userId)
        .collection('items')
        .doc(widget.annonceId)
        .delete();

    setState(() {
      isInWishlist = false;
    });
  }

  Future<Map<String, dynamic>> _getUserPreferences(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('preferences').doc(uid).get();
    return doc.data() ?? {};
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final String whatsappUrl = "whatsapp://wa.me/$phoneNumber/?text=I Like your post can we talk";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HAppBar(
        title: const Text('Annonce Details'),
        showBackArrow: true,
        actions: [
          IconButton(
            icon: Icon(isInWishlist ? Iconsax.heart5 : Iconsax.heart),
            color: isInWishlist ? Colors.red : Colors.grey,
            onPressed: () {
              if (isInWishlist) {
                _removeFromWishlist();
              } else {
                _addToWishlist();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('announces').doc(widget.annonceId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Annonce not found'));
          } else {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            String userId = data['uid'] ?? '';

            return FutureBuilder<Map<String, dynamic>>(
              future: _getUserPreferences(userId),
              builder: (context, userPrefSnapshot) {
                if (userPrefSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (userPrefSnapshot.hasError) {
                  return Center(child: Text('Error: ${userPrefSnapshot.error}'));
                } else {
                  Map<String, dynamic> userPrefs = userPrefSnapshot.data ?? {};

                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (userSnapshot.hasError) {
                        return Center(child: Text('Error: ${userSnapshot.error}'));
                      } else if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                        return const Center(child: Text('User not found'));
                      } else {
                        Map<String, dynamic> userData = userSnapshot.data!.data() as Map<String, dynamic>;
                        String formattedPhone = _formatPhoneNumber(userData['phone']);

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              HAnnonceImageSlider(imageUrls: List<String>.from(data['imageUrls'] ?? [])),
                              Padding(
                                padding: const EdgeInsets.all(HSize.defaultSpace),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['title'] ?? '', style: Theme.of(context).textTheme.headlineMedium),
                                    Text('Price: ${data['price'] ?? ''}'),
                                    Text('Bedrooms: ${data['bedrooms'] ?? ''}'),
                                    Text('Address: ${data['address'] ?? ''}'),
                                    Text('Description: ${data['textAbout'] ?? ''}'),
                                    const SizedBox(height: HSize.defaultSpace),
                                    Row(
                                      children: [
                                        HCircularImage(
                                          image: userData['imageUrl'] ?? 'assets/default_avatar.png',
                                          width: 40,
                                          height: 40,
                                          padding: 0,
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Posted by: ${userData['username'] ?? ''}'),
                                            Text('Contact: $formattedPhone'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: HSize.defaultSpace),
                                    Text('Preferences:', style: Theme.of(context).textTheme.headlineSmall),
                                    Text('Languages: ${userPrefs['languages']?.join(', ') ?? 'Not set'}'),
                                    Text('Personality: ${userPrefs['personality']?.join(', ') ?? 'Not set'}'),
                                    Text('LifeStyle: ${userPrefs['lifestyle']?.join(', ') ?? 'Not set'}'),
                                    Text('Hobbies: ${userPrefs['hobbies']?.join(', ') ?? 'Not set'}'),
                                    const SizedBox(height: HSize.defaultSpace),
                                    ElevatedButton.icon(
                                      onPressed: () => _launchWhatsApp(formattedPhone),
                                      icon: const Icon(Iconsax.messages),
                                      label: const Text('Contact via WhatsApp'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

class HAnnonceImageSlider extends StatelessWidget {
  final List<String> imageUrls;

  const HAnnonceImageSlider({
    super.key,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunction.isDarkMode(context);
    return HCurvedEdgeWidget(
      child: Container(
        color: dark ? Colors.black26 : Colors.white,
        child: Stack(
          children: [
            SizedBox(
              height: 400, // Ensure the height is correctly specified
              child: Padding(
                padding: const EdgeInsets.all(HSize.productImageRadius),
                child: Center(
                  child: PageView.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              left: HSize.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => HCircularImage(
                    image: imageUrls[index],
                    width: 80,
                    height: 80,
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: HSize.spaceBtwItems),
                  itemCount: imageUrls.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HCircularImage extends StatelessWidget {
  const HCircularImage({
    Key? key,
    required this.image,
    this.onTap,
    required this.width,
    required this.height,
    this.padding = HSize.sm,
  }) : super(key: key);

  final String image;
  final double width, height, padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isFile = File(image).existsSync();
    bool isNetwork = image.startsWith('http') || image.startsWith('https');

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: HSize.spaceBtwItems),
        child: SizedBox(
          child: Column(
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: ClipOval(
                    child: isFile
                        ? Image.file(File(image), fit: BoxFit.cover, width: width, height: height)
                        : isNetwork
                        ? Image.network(image, fit: BoxFit.cover, width: width, height: height)
                        : Image.asset(image, fit: BoxFit.cover, width: width, height: height),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
