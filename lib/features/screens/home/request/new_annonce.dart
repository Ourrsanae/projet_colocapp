import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:projetpfe/constants/sizes.dart';
import 'package:projetpfe/widgets/navigation_menu.dart';
import 'package:get/get.dart';

class NewAnnonce extends StatefulWidget {
  const NewAnnonce({super.key});

  @override
  _NewAnnonceState createState() => _NewAnnonceState();
}

class _NewAnnonceState extends State<NewAnnonce> {
  LocationData? _currentLocation;
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  final Location _location = Location();

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final longController = TextEditingController();
  final latController = TextEditingController();
  final textAboutController = TextEditingController();
  final bedroomsController = TextEditingController();
  final addressController = TextEditingController();
  List<File> _selectedImages = [];

  void getLocation(BuildContext context) async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await _location.getLocation();

    longController.text = _currentLocation!.longitude.toString();
    latController.text = _currentLocation!.latitude.toString();
  }

  Future<void> pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      _selectedImages = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    });
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];
    for (File image in images) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child('announces/$fileName');
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() => null);
      String imageUrl = await storageReference.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  void saveAnnounce(BuildContext context) async {
    final String title = titleController.text.trim();
    final String price = priceController.text.trim();
    final String bedrooms = bedroomsController.text.trim();
    final String address = addressController.text.trim();
    final String textAbout = textAboutController.text.trim();
    List<String> imageUrls = [];

    if (_selectedImages.isNotEmpty) {
      imageUrls = await uploadImages(_selectedImages);
    }

    CollectionReference annonce = FirebaseFirestore.instance.collection('announces');
    try {
      await annonce.add({
        'title': title,
        'price': price,
        'longitude': _currentLocation!.longitude,
        'latitude': _currentLocation!.latitude,
        'bedrooms': bedrooms,
        'address': address,
        'textAbout': textAbout,
        'imageUrls': imageUrls,
        'uid': FirebaseAuth.instance.currentUser?.uid,
      });
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Annonce'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: HSize.spaceBtwSections),
            child: Column(
              children: [
                GestureDetector(
                  onTap: pickImages,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: _selectedImages.isNotEmpty
                        ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        return Image.file(_selectedImages[index], fit: BoxFit.cover);
                      },
                    )
                        : const Icon(Icons.add_a_photo, color: Colors.grey, size: 100),
                  ),
                ),
                const SizedBox(height: HSize.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: "Title",
                        ),
                      ),
                    ),
                    const SizedBox(width: HSize.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: bedroomsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Chambres",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: HSize.spaceBtwInputFields),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.paperclip),
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(height: HSize.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: longController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.location),
                          labelText: 'Long',
                        ),
                      ),
                    ),
                    const SizedBox(width: HSize.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: latController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.location),
                          labelText: 'Lat',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: HSize.spaceBtwInputFields),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.map),
                    labelText: 'Address',
                  ),
                ),
                const SizedBox(height: HSize.spaceBtwInputFields),
                Padding(
                  padding: const EdgeInsets.all(HSize.defaultSpace),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        getLocation(context);
                      },
                      child: const Text("Get Location"),
                    ),
                  ),
                ),

                const SizedBox(height: HSize.spaceBtwInputFields),
                TextFormField(
                  maxLines: 3,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return "Tell us about it";
                    } else {
                      return null;
                    }
                  },
                  controller: textAboutController,
                  decoration: const InputDecoration(
                    hintText: "A little About it",
                    suffixIcon: Icon(Icons.text_fields),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: HSize.spaceBtwInputFields),
                Padding(
                  padding: const EdgeInsets.all(HSize.defaultSpace),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        saveAnnounce(context);
                      },
                      child: const Text("Continue"),
                    ),
                  ),
                ),
                const SizedBox(height: HSize.spaceBtwInputFields),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
