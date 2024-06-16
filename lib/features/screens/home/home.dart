import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetpfe/constants/images.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/features/screens/home/request/widgets/request_card.dart';
import 'package:projetpfe/features/screens/home/widgets/home_app_bar.dart';
import 'package:projetpfe/features/screens/home/widgets/primary_header_container.dart';
import 'package:projetpfe/features/screens/home/widgets/searchbar.dart';
import 'package:projetpfe/features/screens/home/widgets/section.dart';
import 'package:projetpfe/features/screens/home/widgets/welcome_slider.dart';

class HomePage extends StatelessWidget {
  // Read
  Future<List<Map<String, dynamic>>> getAllAnnounces() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('announces').get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Add the document ID to the data map
      return data;
    }).toList();
  }

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HPrimaryHeaderContainer(
              child: Column(
                children: [
                  HHomeAppBar(),
                  SizedBox(height: HSize.spaceBtwSections),
                  Search(),
                  SizedBox(height: HSize.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(HSize.defaultSpace),
              child: HWelcomeSlider(
                banners: [HImages.carousel1, HImages.carousel2, HImages.carousel3],
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: getAllAnnounces(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No annonces found');
                } else {
                  final annonces = snapshot.data!;
                  return CustomGridView(
                    itemCount: annonces.length,
                    itemBuilder: (_, index) {
                      final annonce = annonces[index];
                      return HAnnonceCard(
                        annonceId: annonce['id'], // Pass the annonceId here
                        title: annonce['title'] ?? 'No title',
                        price: annonce['price']?.toString() ?? 'No price',
                        imageUrl: (annonce['imageUrls'] != null && (annonce['imageUrls'] as List).isNotEmpty)
                            ? annonce['imageUrls'][0]
                            : null,
                        location: 'Location',
                        bedrooms: annonce['bedrooms']?.toString() ?? 'No bedrooms',
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 200,
    required this.itemBuilder,
  });

  final int itemCount;
  final double mainAxisExtent;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: HSize.gridViewSpacing,
        crossAxisSpacing: HSize.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
