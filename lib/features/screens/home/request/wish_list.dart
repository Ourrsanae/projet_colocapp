import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetpfe/features/screens/home/request/widgets/commande%20_controller.dart';
import 'package:projetpfe/features/screens/widgets/appbar/appbar.dart';
import 'package:projetpfe/themes/theme.dart';
import 'package:projetpfe/utils/helper_function.dart';

class HWishListView extends StatefulWidget {
  const HWishListView({Key? key}) : super(key: key);

  @override
  _HWishListViewState createState() => _HWishListViewState();
}

class _HWishListViewState extends State<HWishListView> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _removeFromWishlist(String annonceId) async {
    await FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userId)
        .collection('items')
        .doc(annonceId)
        .delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HAppBar(
        title: const Text('My Wishlist'),
        showBackArrow: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('wishlists')
            .doc(userId)
            .collection('items')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No items in your wishlist'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var wishItem = snapshot.data!.docs[index];
                String annonceId = wishItem.id;

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('announces').doc(annonceId).get(),
                  builder: (context, annonceSnapshot) {
                    if (annonceSnapshot.connectionState == ConnectionState.waiting) {
                      return const ListTile(title: Text('Loading...'));
                    } else if (annonceSnapshot.hasError) {
                      return ListTile(title: Text('Error: ${annonceSnapshot.error}'));
                    } else if (!annonceSnapshot.hasData || !annonceSnapshot.data!.exists) {
                      return const ListTile(title: Text('Annonce not found'));
                    } else {
                      var annonceData = annonceSnapshot.data!.data() as Map<String, dynamic>;

                      return ListTile(
                        leading: Image.network(annonceData['imageUrls'][0], fit: BoxFit.cover, width: 50, height: 50),
                        title: Text(annonceData['title']),
                        subtitle: Text('Price: ${annonceData['price']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => _removeFromWishlist(annonceId),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnnonceDetails(annonceId: annonceId),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
