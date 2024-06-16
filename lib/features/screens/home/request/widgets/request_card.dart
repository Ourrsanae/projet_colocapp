import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/features/screens/home/request/widgets/like_icon.dart';
import 'package:projetpfe/features/screens/home/widgets/details_screen.dart';
import 'package:projetpfe/themes/theme.dart';

class HAnnonceCard extends StatelessWidget {
  final String annonceId;
  final String title;
  final String price;
  final String? imageUrl;
  final String location;
  final String bedrooms;
  final List<String>? preferences; // Add preferences field

  const HAnnonceCard({
    Key? key,
    required this.annonceId,
    required this.title,
    required this.price,
    this.imageUrl,
    required this.location,
    required this.bedrooms,
    this.preferences, // Initialize preferences field
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => Get.to(() => AnnonceDetails(annonceId: annonceId)),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // Adjust the border radius
          color: dark ? Colors.black26 : Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  imageUrl != null
                      ? Image.network(imageUrl!, fit: BoxFit.cover, width: double.infinity)
                      : Container(color: Colors.grey), // Add placeholder for image
                  Positioned(
                    right: 0,
                    top: 0,
                    child: LikeIcon(
                      icon: Iconsax.heart5,
                      color: Colors.grey,
                      annonceId: annonceId,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$price MAD',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      if (preferences != null) ...[
                        Row(
                          children: preferences!.map((pref) => Text(pref)).toList(),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
