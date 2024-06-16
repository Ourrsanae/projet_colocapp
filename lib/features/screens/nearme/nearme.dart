import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House Mate Hub'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('announces').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No announces found'));
          } else {
            List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
            List<Marker> markers = docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              if (data.containsKey('latitude') && data.containsKey('longitude')) {
                double latitude = data['latitude'];
                double longitude = data['longitude'];
                return Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(latitude, longitude),
                  builder: (ctx) => const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40.0,
                  ),
                );
              } else {
                return Marker(
                  width: 0.0,
                  height: 0.0,
                  point: LatLng(0.0, 0.0),
                  builder: (ctx) => Container(),
                );
              }
            }).toList();

            return FlutterMap(
              options: MapOptions(
                center: LatLng(33.2508882253301, -8.531517818111821), // Example coordinates
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: markers,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
