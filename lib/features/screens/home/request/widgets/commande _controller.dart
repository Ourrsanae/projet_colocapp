import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetpfe/utils/helper_function.dart';

class AnnonceDetails extends StatelessWidget {
  final String annonceId;

  const AnnonceDetails({super.key, required this.annonceId});

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Annonce Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('announces').doc(annonceId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Annonce not found'));
          }
          var annonce = snapshot.data!.data() as Map<String, dynamic>;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (annonce['imageUrls'] != null && annonce['imageUrls'].isNotEmpty)
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: annonce['imageUrls'].length,
                      itemBuilder: (context, index) {
                        return Image.network(annonce['imageUrls'][index]);
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        annonce['title'],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '${annonce['price']} MAD',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Location: ${annonce['latitude']}, ${annonce['longitude']}',
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Bedrooms: ${annonce['bedrooms']}',
                      ),
                      const SizedBox(height: 10),
                      Text(
                        annonce['textAbout'] ?? 'No description provided',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
