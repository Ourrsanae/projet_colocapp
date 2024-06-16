import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetpfe/features/screens/home/request/widgets/request_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchText = "";
  List<DocumentSnapshot> _posts = [];
  List<DocumentSnapshot> _filteredPosts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() async {
    FirebaseFirestore.instance.collection('announces').get().then((snapshot) {
      setState(() {
        _posts = snapshot.docs;
        _filteredPosts = _posts;
      });
    });
  }

  void _filterPosts(String searchText) {
    setState(() {
      _searchText = searchText;
      _filteredPosts = _posts.where((post) {
        return (post['title'] as String).toLowerCase().contains(_searchText.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Posts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      onChanged: (value) => _filterPosts(value),
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPosts.length,
              itemBuilder: (context, index) {
                var post = _filteredPosts[index];
                var data = post.data() as Map<String, dynamic>;
                return HAnnonceCard(
                  annonceId: post.id,
                  title: data['title'] ?? 'No title',
                  price: data['price'] ?? '0',
                  imageUrl: data['imageUrl'],
                  location: data['location'] ?? 'No location',
                  bedrooms: data['bedrooms'] ?? '0',
                  preferences: (data['preferences'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
